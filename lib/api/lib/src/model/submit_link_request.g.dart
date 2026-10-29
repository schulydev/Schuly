// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_link_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SubmitLinkRequest extends SubmitLinkRequest {
  @override
  final String stepId;
  @override
  final BuiltMap<String, String>? values;
  @override
  final String? action;

  factory _$SubmitLinkRequest([
    void Function(SubmitLinkRequestBuilder)? updates,
  ]) => (SubmitLinkRequestBuilder()..update(updates))._build();

  _$SubmitLinkRequest._({required this.stepId, this.values, this.action})
    : super._();
  @override
  SubmitLinkRequest rebuild(void Function(SubmitLinkRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubmitLinkRequestBuilder toBuilder() =>
      SubmitLinkRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubmitLinkRequest &&
        stepId == other.stepId &&
        values == other.values &&
        action == other.action;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, stepId.hashCode);
    _$hash = $jc(_$hash, values.hashCode);
    _$hash = $jc(_$hash, action.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SubmitLinkRequest')
          ..add('stepId', stepId)
          ..add('values', values)
          ..add('action', action))
        .toString();
  }
}

class SubmitLinkRequestBuilder
    implements Builder<SubmitLinkRequest, SubmitLinkRequestBuilder> {
  _$SubmitLinkRequest? _$v;

  String? _stepId;
  String? get stepId => _$this._stepId;
  set stepId(String? stepId) => _$this._stepId = stepId;

  MapBuilder<String, String>? _values;
  MapBuilder<String, String> get values =>
      _$this._values ??= MapBuilder<String, String>();
  set values(MapBuilder<String, String>? values) => _$this._values = values;

  String? _action;
  String? get action => _$this._action;
  set action(String? action) => _$this._action = action;

  SubmitLinkRequestBuilder() {
    SubmitLinkRequest._defaults(this);
  }

  SubmitLinkRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _stepId = $v.stepId;
      _values = $v.values?.toBuilder();
      _action = $v.action;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubmitLinkRequest other) {
    _$v = other as _$SubmitLinkRequest;
  }

  @override
  void update(void Function(SubmitLinkRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SubmitLinkRequest build() => _build();

  _$SubmitLinkRequest _build() {
    _$SubmitLinkRequest _$result;
    try {
      _$result =
          _$v ??
          _$SubmitLinkRequest._(
            stepId: BuiltValueNullFieldError.checkNotNull(
              stepId,
              r'SubmitLinkRequest',
              'stepId',
            ),
            values: _values?.build(),
            action: action,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'values';
        _values?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SubmitLinkRequest',
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
