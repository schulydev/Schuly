import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:schuly_api/schuly_api.dart';

import '../../services/active_account_service.dart';
import '../../services/api_client.dart';
import '../../services/school_data_service.dart';

/// Documents screen — mirrors the Schulnetz "Persönliches Dossier": files are
/// grouped into folders by their category (report cards / Zeugnisse get their
/// own folder, pinned first). Pull down to fetch fresh files from Schulnetz;
/// tapping a file downloads and opens it.
class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  String? _downloadingId;

  /// Folder label for a document; report cards land in a dedicated bucket.
  static String _folderOf(StudentDocumentDto d) {
    final cat = (d.category ?? '').trim();
    if (cat.toLowerCase().contains('zeugnis')) return 'Report cards';
    return cat.isEmpty ? 'Other' : cat;
  }

  /// Documents grouped into folders, report cards first, then alphabetical.
  List<MapEntry<String, List<StudentDocumentDto>>> get _folders {
    final docs = SchoolDataService.instance.documents;
    final map = <String, List<StudentDocumentDto>>{};
    for (final d in docs) {
      (map[_folderOf(d)] ??= []).add(d);
    }
    for (final list in map.values) {
      list.sort((a, b) => (a.title).toLowerCase().compareTo((b.title).toLowerCase()));
    }
    final entries = map.entries.toList()
      ..sort((a, b) {
        if (a.key == 'Report cards') return -1;
        if (b.key == 'Report cards') return 1;
        return a.key.toLowerCase().compareTo(b.key.toLowerCase());
      });
    return entries;
  }

  /// Pull-to-refresh: trigger a real provider re-fetch (pulls fresh documents
  /// from Schulnetz), then reload the local cache. Falls back to a plain cache
  /// reload if there's no connected provider account.
  Future<void> _refresh() async {
    final active = ActiveAccountService.instance.active;
    final accountId = active?.pluginAccountId;
    if (accountId != null) {
      try {
        final sync = ApiClient.instance.api.getSyncApi();
        if (active!.provider == 'odaorg') {
          await sync.apiPluginsOdaorgAccountsAccountIdSyncPost(accountId: accountId);
        } else {
          await sync.apiPluginsSchulwareAccountsAccountIdSyncPost(accountId: accountId);
        }
      } on DioException catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Sync failed (${e.response?.statusCode ?? 'network'})')));
        }
      } catch (_) {/* fall through to the cache reload */}
    }
    await SchoolDataService.instance.refresh();
  }

  /// Download a document's bytes through the authed Dio and open it with the
  /// system viewer.
  Future<void> _openDocument(StudentDocumentDto doc) async {
    final id = doc.id;
    if (id == null) return;
    setState(() => _downloadingId = id);
    try {
      final res = await ApiClient.instance.dio.get<List<int>>(
        '/api/documents/$id',
        options: Options(responseType: ResponseType.bytes),
      );
      final dir = await getTemporaryDirectory();
      final name = doc.fileName?.isNotEmpty == true ? doc.fileName! : 'document-$id';
      final file = File('${dir.path}/$name');
      await file.writeAsBytes(res.data ?? const []);
      await OpenFilex.open(file.path);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Could not open document: $e')));
      }
    } finally {
      if (mounted) setState(() => _downloadingId = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final folders = _folders;

    return FScaffold(
      header: FHeader.nested(
        title: const Text('Documents'),
        prefixes: [FHeaderAction.back(onPress: () => Navigator.of(context).pop())],
      ),
      child: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            if (folders.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 48),
                child: Center(
                  child: Text('No documents yet — pull down to refresh.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: colors.mutedForeground)),
                ),
              )
            else
              for (final folder in folders)
                _FolderTile(
                  name: folder.key,
                  files: folder.value,
                  downloadingId: _downloadingId,
                  onOpen: _openDocument,
                ),
          ],
        ),
      ),
    );
  }
}

/// An expandable folder containing its document rows.
class _FolderTile extends StatefulWidget {
  final String name;
  final List<StudentDocumentDto> files;
  final String? downloadingId;
  final Future<void> Function(StudentDocumentDto) onOpen;
  const _FolderTile({
    required this.name,
    required this.files,
    required this.downloadingId,
    required this.onOpen,
  });

  @override
  State<_FolderTile> createState() => _FolderTileState();
}

class _FolderTileState extends State<_FolderTile> {
  late bool _open = widget.name == 'Report cards'; // report cards expanded by default

  static String _fmtSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(0)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FTile(
            prefix: Icon(_open ? FIcons.folderOpen : FIcons.folder),
            title: Text(widget.name),
            details: Text('${widget.files.length}'),
            suffix: Icon(_open ? FIcons.chevronDown : FIcons.chevronRight),
            onPress: () => setState(() => _open = !_open),
          ),
          if (_open)
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final doc in widget.files)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: FTile(
                        prefix: widget.downloadingId == doc.id
                            ? const FCircularProgress()
                            : const Icon(FIcons.fileText),
                        title: Text(doc.title.isNotEmpty ? doc.title : (doc.fileName ?? 'Document')),
                        subtitle: Text([
                          if (doc.enteredBy?.isNotEmpty ?? false) doc.enteredBy,
                          if (doc.fileSizeBytes != null) _fmtSize(doc.fileSizeBytes!),
                        ].whereType<String>().where((s) => s.isNotEmpty).join(' · ')),
                        suffix: Icon(FIcons.download, color: colors.mutedForeground),
                        onPress: widget.downloadingId == null ? () => widget.onOpen(doc) : null,
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
