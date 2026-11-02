// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_link_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StartLinkRequest extends StartLinkRequest {
  @override
  final String? flowId;
  @override
  final String? platform;
  @override
  final String? reauthAccountId;

  factory _$StartLinkRequest([
    void Function(StartLinkRequestBuilder)? updates,
  ]) => (StartLinkRequestBuilder()..update(updates))._build();

  _$StartLinkRequest._({this.flowId, this.platform, this.reauthAccountId})
    : super._();
  @override
  StartLinkRequest rebuild(void Function(StartLinkRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StartLinkRequestBuilder toBuilder() =>
      StartLinkRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StartLinkRequest &&
        flowId == other.flowId &&
        platform == other.platform &&
        reauthAccountId == other.reauthAccountId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, flowId.hashCode);
    _$hash = $jc(_$hash, platform.hashCode);
    _$hash = $jc(_$hash, reauthAccountId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StartLinkRequest')
          ..add('flowId', flowId)
          ..add('platform', platform)
          ..add('reauthAccountId', reauthAccountId))
        .toString();
  }
}

class StartLinkRequestBuilder
    implements Builder<StartLinkRequest, StartLinkRequestBuilder> {
  _$StartLinkRequest? _$v;

  String? _flowId;
  String? get flowId => _$this._flowId;
  set flowId(String? flowId) => _$this._flowId = flowId;

  String? _platform;
  String? get platform => _$this._platform;
  set platform(String? platform) => _$this._platform = platform;

  String? _reauthAccountId;
  String? get reauthAccountId => _$this._reauthAccountId;
  set reauthAccountId(String? reauthAccountId) =>
      _$this._reauthAccountId = reauthAccountId;

  StartLinkRequestBuilder() {
    StartLinkRequest._defaults(this);
  }

  StartLinkRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _flowId = $v.flowId;
      _platform = $v.platform;
      _reauthAccountId = $v.reauthAccountId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StartLinkRequest other) {
    _$v = other as _$StartLinkRequest;
  }

  @override
  void update(void Function(StartLinkRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StartLinkRequest build() => _build();

  _$StartLinkRequest _build() {
    final _$result =
        _$v ??
        _$StartLinkRequest._(
          flowId: flowId,
          platform: platform,
          reauthAccountId: reauthAccountId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
