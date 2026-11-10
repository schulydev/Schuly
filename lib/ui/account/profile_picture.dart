import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:image_picker/image_picker.dart';

import '../../l10n/app_localizations.dart';
import '../../services/api_client.dart';
import '../../services/toast_service.dart';
import '../core/ui/auth_image.dart';
import '../core/ui/kit.dart';

/// The server takes PNG, JPEG and WebP up to 2 MB (`PUT /api/me/avatar`), the same limit the web checks.
const _maxBytes = 2000000;

DioMediaType? _mediaType(String name, String? mime) {
  final type = (mime ?? '').toLowerCase();
  final ext = name.toLowerCase().split('.').last;
  if (type == 'image/png' || ext == 'png') return DioMediaType('image', 'png');
  if (type == 'image/webp' || ext == 'webp') return DioMediaType('image', 'webp');
  if (type == 'image/jpeg' || ext == 'jpg' || ext == 'jpeg') return DioMediaType('image', 'jpeg');
  return null;
}

/// The Schuly account's picture with a pencil on it; tapping opens the web's small menu: upload a picture, or remove
/// the one there is. [onChanged] runs after the server took the change, to load the new picture.
class ProfilePictureButton extends StatefulWidget {
  const ProfilePictureButton({super.key, required this.url, required this.name, required this.onChanged, this.size = 60});

  final String? url;
  final String? name;
  final double size;
  final Future<void> Function() onChanged;

  @override
  State<ProfilePictureButton> createState() => _ProfilePictureButtonState();
}

class _ProfilePictureButtonState extends State<ProfilePictureButton> with SingleTickerProviderStateMixin {
  late final FPopoverController _menu = FPopoverController(vsync: this);
  bool _busy = false;

  @override
  void dispose() {
    _menu.dispose();
    super.dispose();
  }

  Future<void> _run(Future<void> Function() change) async {
    final t = AppLocalizations.of(context)!;
    setState(() => _busy = true);
    try {
      await change();
      // The picture may keep its address, so drop the cached one.
      clearFetchedImages();
      await widget.onChanged();
    } on DioException catch (_) {
      ToastService.error(t.profileChangePicture, t.profileUploadFailed);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _upload() async {
    final t = AppLocalizations.of(context)!;
    await _menu.hide();
    // Scaled down on the phone, so a camera photo fits the 2 MB the server takes.
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 1024, maxHeight: 1024, imageQuality: 85);
    if (picked == null) return;
    final bytes = await picked.readAsBytes();
    final type = _mediaType(picked.name, picked.mimeType);
    if (bytes.length > _maxBytes || type == null) {
      ToastService.error(t.profileChangePicture, t.profileTooLarge);
      return;
    }
    await _run(() => ApiClient.instance.api.getMeApi().apiMeAvatarPut(file: MultipartFile.fromBytes(bytes, filename: picked.name, contentType: type)));
  }

  Future<void> _remove() async {
    await _menu.hide();
    await _run(() => ApiClient.instance.api.getMeApi().apiMeAvatarDelete());
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colors = context.theme.colors;
    final hasPicture = widget.url != null && widget.url!.isNotEmpty;
    return FPopoverMenu.tiles(
      control: FPopoverControl.managed(controller: _menu),
      menuAnchor: AlignmentDirectional.topStart,
      childAnchor: AlignmentDirectional.bottomStart,
      menu: [
        FTileGroup(
          children: [
            FTile(title: Text(t.profileUpload), onPress: _upload),
            if (hasPicture) FTile(title: Text(t.profileRemove, style: TextStyle(color: colors.destructive)), onPress: _remove),
          ],
        ),
      ],
      builder: (context, controller, _) => Semantics(
        button: true,
        label: t.profileChangePicture,
        child: FTappable(
          onPress: _busy ? null : controller.toggle,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Avatar(url: widget.url, name: widget.name, size: widget.size),
              Positioned(
                right: -2,
                bottom: -2,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: colors.background, border: Border.all(color: colors.border)),
                  child: _busy ? const Padding(padding: EdgeInsets.all(5), child: FCircularProgress()) : Icon(FIcons.pencil, size: 12, color: colors.foreground),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
