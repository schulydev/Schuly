// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unified_login_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UnifiedLoginRequest extends UnifiedLoginRequest {
  @override
  final String systemKey;
  @override
  final BuiltMap<String, String>? fields;
  @override
  final String? displayName;

  factory _$UnifiedLoginRequest([
    void Function(UnifiedLoginRequestBuilder)? updates,
  ]) => (UnifiedLoginRequestBuilder()..update(updates))._build();

  _$UnifiedLoginRequest._({
    required this.systemKey,
    this.fields,
    this.displayName,
  }) : super._();
  @override
  UnifiedLoginRequest rebuild(
    void Function(UnifiedLoginRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UnifiedLoginRequestBuilder toBuilder() =>
      UnifiedLoginRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UnifiedLoginRequest &&
        systemKey == other.systemKey &&
        fields == other.fields &&
        displayName == other.displayName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, systemKey.hashCode);
    _$hash = $jc(_$hash, fields.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UnifiedLoginRequest')
          ..add('systemKey', systemKey)
          ..add('fields', fields)
          ..add('displayName', displayName))
        .toString();
  }
}

class UnifiedLoginRequestBuilder
    implements Builder<UnifiedLoginRequest, UnifiedLoginRequestBuilder> {
  _$UnifiedLoginRequest? _$v;

  String? _systemKey;
  String? get systemKey => _$this._systemKey;
  set systemKey(String? systemKey) => _$this._systemKey = systemKey;

  MapBuilder<String, String>? _fields;
  MapBuilder<String, String> get fields =>
      _$this._fields ??= MapBuilder<String, String>();
  set fields(MapBuilder<String, String>? fields) => _$this._fields = fields;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  UnifiedLoginRequestBuilder() {
    UnifiedLoginRequest._defaults(this);
  }

  UnifiedLoginRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _systemKey = $v.systemKey;
      _fields = $v.fields?.toBuilder();
      _displayName = $v.displayName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UnifiedLoginRequest other) {
    _$v = other as _$UnifiedLoginRequest;
  }

  @override
  void update(void Function(UnifiedLoginRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UnifiedLoginRequest build() => _build();

  _$UnifiedLoginRequest _build() {
    _$UnifiedLoginRequest _$result;
    try {
      _$result =
          _$v ??
          _$UnifiedLoginRequest._(
            systemKey: BuiltValueNullFieldError.checkNotNull(
              systemKey,
              r'UnifiedLoginRequest',
              'systemKey',
            ),
            fields: _fields?.build(),
            displayName: displayName,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'fields';
        _fields?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'UnifiedLoginRequest',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
