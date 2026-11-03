// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_helply_workspace_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateHelplyWorkspaceRequest extends UpdateHelplyWorkspaceRequest {
  @override
  final bool enabled;

  factory _$UpdateHelplyWorkspaceRequest([
    void Function(UpdateHelplyWorkspaceRequestBuilder)? updates,
  ]) => (UpdateHelplyWorkspaceRequestBuilder()..update(updates))._build();

  _$UpdateHelplyWorkspaceRequest._({required this.enabled}) : super._();
  @override
  UpdateHelplyWorkspaceRequest rebuild(
    void Function(UpdateHelplyWorkspaceRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateHelplyWorkspaceRequestBuilder toBuilder() =>
      UpdateHelplyWorkspaceRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateHelplyWorkspaceRequest && enabled == other.enabled;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, enabled.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'UpdateHelplyWorkspaceRequest',
    )..add('enabled', enabled)).toString();
  }
}

class UpdateHelplyWorkspaceRequestBuilder
    implements
        Builder<
          UpdateHelplyWorkspaceRequest,
          UpdateHelplyWorkspaceRequestBuilder
        > {
  _$UpdateHelplyWorkspaceRequest? _$v;

  bool? _enabled;
  bool? get enabled => _$this._enabled;
  set enabled(bool? enabled) => _$this._enabled = enabled;

  UpdateHelplyWorkspaceRequestBuilder() {
    UpdateHelplyWorkspaceRequest._defaults(this);
  }

  UpdateHelplyWorkspaceRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _enabled = $v.enabled;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateHelplyWorkspaceRequest other) {
    _$v = other as _$UpdateHelplyWorkspaceRequest;
  }

  @override
  void update(void Function(UpdateHelplyWorkspaceRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateHelplyWorkspaceRequest build() => _build();

  _$UpdateHelplyWorkspaceRequest _build() {
    final _$result =
        _$v ??
        _$UpdateHelplyWorkspaceRequest._(
          enabled: BuiltValueNullFieldError.checkNotNull(
            enabled,
            r'UpdateHelplyWorkspaceRequest',
            'enabled',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
