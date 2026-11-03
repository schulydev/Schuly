// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helply_decision_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HelplyDecisionRequest extends HelplyDecisionRequest {
  @override
  final String? approvalId;
  @override
  final bool approved;

  factory _$HelplyDecisionRequest([
    void Function(HelplyDecisionRequestBuilder)? updates,
  ]) => (HelplyDecisionRequestBuilder()..update(updates))._build();

  _$HelplyDecisionRequest._({this.approvalId, required this.approved})
    : super._();
  @override
  HelplyDecisionRequest rebuild(
    void Function(HelplyDecisionRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HelplyDecisionRequestBuilder toBuilder() =>
      HelplyDecisionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HelplyDecisionRequest &&
        approvalId == other.approvalId &&
        approved == other.approved;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, approvalId.hashCode);
    _$hash = $jc(_$hash, approved.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HelplyDecisionRequest')
          ..add('approvalId', approvalId)
          ..add('approved', approved))
        .toString();
  }
}

class HelplyDecisionRequestBuilder
    implements Builder<HelplyDecisionRequest, HelplyDecisionRequestBuilder> {
  _$HelplyDecisionRequest? _$v;

  String? _approvalId;
  String? get approvalId => _$this._approvalId;
  set approvalId(String? approvalId) => _$this._approvalId = approvalId;

  bool? _approved;
  bool? get approved => _$this._approved;
  set approved(bool? approved) => _$this._approved = approved;

  HelplyDecisionRequestBuilder() {
    HelplyDecisionRequest._defaults(this);
  }

  HelplyDecisionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _approvalId = $v.approvalId;
      _approved = $v.approved;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HelplyDecisionRequest other) {
    _$v = other as _$HelplyDecisionRequest;
  }

  @override
  void update(void Function(HelplyDecisionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HelplyDecisionRequest build() => _build();

  _$HelplyDecisionRequest _build() {
    final _$result =
        _$v ??
        _$HelplyDecisionRequest._(
          approvalId: approvalId,
          approved: BuiltValueNullFieldError.checkNotNull(
            approved,
            r'HelplyDecisionRequest',
            'approved',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
