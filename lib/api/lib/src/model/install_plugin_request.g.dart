// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'install_plugin_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$InstallPluginRequest extends InstallPluginRequest {
  @override
  final String name;
  @override
  final String? version;

  factory _$InstallPluginRequest([
    void Function(InstallPluginRequestBuilder)? updates,
  ]) => (InstallPluginRequestBuilder()..update(updates))._build();

  _$InstallPluginRequest._({required this.name, this.version}) : super._();
  @override
  InstallPluginRequest rebuild(
    void Function(InstallPluginRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  InstallPluginRequestBuilder toBuilder() =>
      InstallPluginRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InstallPluginRequest &&
        name == other.name &&
        version == other.version;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InstallPluginRequest')
          ..add('name', name)
          ..add('version', version))
        .toString();
  }
}

class InstallPluginRequestBuilder
    implements Builder<InstallPluginRequest, InstallPluginRequestBuilder> {
  _$InstallPluginRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _version;
  String? get version => _$this._version;
  set version(String? version) => _$this._version = version;

  InstallPluginRequestBuilder() {
    InstallPluginRequest._defaults(this);
  }

  InstallPluginRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _version = $v.version;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InstallPluginRequest other) {
    _$v = other as _$InstallPluginRequest;
  }

  @override
  void update(void Function(InstallPluginRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InstallPluginRequest build() => _build();

  _$InstallPluginRequest _build() {
    final _$result =
        _$v ??
        _$InstallPluginRequest._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'InstallPluginRequest',
            'name',
          ),
          version: version,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
