// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_helply_approvals_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AnswerHelplyApprovalsRequest extends AnswerHelplyApprovalsRequest {
  @override
  final BuiltList<HelplyDecisionRequest>? decisions;

  factory _$AnswerHelplyApprovalsRequest([
    void Function(AnswerHelplyApprovalsRequestBuilder)? updates,
  ]) => (AnswerHelplyApprovalsRequestBuilder()..update(updates))._build();

  _$AnswerHelplyApprovalsRequest._({this.decisions}) : super._();
  @override
  AnswerHelplyApprovalsRequest rebuild(
    void Function(AnswerHelplyApprovalsRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AnswerHelplyApprovalsRequestBuilder toBuilder() =>
      AnswerHelplyApprovalsRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AnswerHelplyApprovalsRequest &&
        decisions == other.decisions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, decisions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'AnswerHelplyApprovalsRequest',
    )..add('decisions', decisions)).toString();
  }
}

class AnswerHelplyApprovalsRequestBuilder
    implements
        Builder<
          AnswerHelplyApprovalsRequest,
          AnswerHelplyApprovalsRequestBuilder
        > {
  _$AnswerHelplyApprovalsRequest? _$v;

  ListBuilder<HelplyDecisionRequest>? _decisions;
  ListBuilder<HelplyDecisionRequest> get decisions =>
      _$this._decisions ??= ListBuilder<HelplyDecisionRequest>();
  set decisions(ListBuilder<HelplyDecisionRequest>? decisions) =>
      _$this._decisions = decisions;

  AnswerHelplyApprovalsRequestBuilder() {
    AnswerHelplyApprovalsRequest._defaults(this);
  }

  AnswerHelplyApprovalsRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _decisions = $v.decisions?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AnswerHelplyApprovalsRequest other) {
    _$v = other as _$AnswerHelplyApprovalsRequest;
  }

  @override
  void update(void Function(AnswerHelplyApprovalsRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AnswerHelplyApprovalsRequest build() => _build();

  _$AnswerHelplyApprovalsRequest _build() {
    _$AnswerHelplyApprovalsRequest _$result;
    try {
      _$result =
          _$v ??
          _$AnswerHelplyApprovalsRequest._(decisions: _decisions?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'decisions';
        _decisions?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AnswerHelplyApprovalsRequest',
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
