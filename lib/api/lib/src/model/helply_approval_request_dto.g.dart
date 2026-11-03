// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helply_approval_request_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HelplyApprovalRequestDto extends HelplyApprovalRequestDto {
  @override
  final String approvalId;
  @override
  final String toolLabel;
  @override
  final String summary;
  @override
  final BuiltList<HelplyApprovalDetailDto> details;
  @override
  final bool destructive;
  @override
  final BuiltList<HelplyApprovalDetailDto> arguments;
  @override
  final String risk;
  @override
  final BuiltList<String> riskReasons;

  factory _$HelplyApprovalRequestDto([
    void Function(HelplyApprovalRequestDtoBuilder)? updates,
  ]) => (HelplyApprovalRequestDtoBuilder()..update(updates))._build();

  _$HelplyApprovalRequestDto._({
    required this.approvalId,
    required this.toolLabel,
    required this.summary,
    required this.details,
    required this.destructive,
    required this.arguments,
    required this.risk,
    required this.riskReasons,
  }) : super._();
  @override
  HelplyApprovalRequestDto rebuild(
    void Function(HelplyApprovalRequestDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HelplyApprovalRequestDtoBuilder toBuilder() =>
      HelplyApprovalRequestDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HelplyApprovalRequestDto &&
        approvalId == other.approvalId &&
        toolLabel == other.toolLabel &&
        summary == other.summary &&
        details == other.details &&
        destructive == other.destructive &&
        arguments == other.arguments &&
        risk == other.risk &&
        riskReasons == other.riskReasons;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, approvalId.hashCode);
    _$hash = $jc(_$hash, toolLabel.hashCode);
    _$hash = $jc(_$hash, summary.hashCode);
    _$hash = $jc(_$hash, details.hashCode);
    _$hash = $jc(_$hash, destructive.hashCode);
    _$hash = $jc(_$hash, arguments.hashCode);
    _$hash = $jc(_$hash, risk.hashCode);
    _$hash = $jc(_$hash, riskReasons.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HelplyApprovalRequestDto')
          ..add('approvalId', approvalId)
          ..add('toolLabel', toolLabel)
          ..add('summary', summary)
          ..add('details', details)
          ..add('destructive', destructive)
          ..add('arguments', arguments)
          ..add('risk', risk)
          ..add('riskReasons', riskReasons))
        .toString();
  }
}

class HelplyApprovalRequestDtoBuilder
    implements
        Builder<HelplyApprovalRequestDto, HelplyApprovalRequestDtoBuilder> {
  _$HelplyApprovalRequestDto? _$v;

  String? _approvalId;
  String? get approvalId => _$this._approvalId;
  set approvalId(String? approvalId) => _$this._approvalId = approvalId;

  String? _toolLabel;
  String? get toolLabel => _$this._toolLabel;
  set toolLabel(String? toolLabel) => _$this._toolLabel = toolLabel;

  String? _summary;
  String? get summary => _$this._summary;
  set summary(String? summary) => _$this._summary = summary;

  ListBuilder<HelplyApprovalDetailDto>? _details;
  ListBuilder<HelplyApprovalDetailDto> get details =>
      _$this._details ??= ListBuilder<HelplyApprovalDetailDto>();
  set details(ListBuilder<HelplyApprovalDetailDto>? details) =>
      _$this._details = details;

  bool? _destructive;
  bool? get destructive => _$this._destructive;
  set destructive(bool? destructive) => _$this._destructive = destructive;

  ListBuilder<HelplyApprovalDetailDto>? _arguments;
  ListBuilder<HelplyApprovalDetailDto> get arguments =>
      _$this._arguments ??= ListBuilder<HelplyApprovalDetailDto>();
  set arguments(ListBuilder<HelplyApprovalDetailDto>? arguments) =>
      _$this._arguments = arguments;

  String? _risk;
  String? get risk => _$this._risk;
  set risk(String? risk) => _$this._risk = risk;

  ListBuilder<String>? _riskReasons;
  ListBuilder<String> get riskReasons =>
      _$this._riskReasons ??= ListBuilder<String>();
  set riskReasons(ListBuilder<String>? riskReasons) =>
      _$this._riskReasons = riskReasons;

  HelplyApprovalRequestDtoBuilder() {
    HelplyApprovalRequestDto._defaults(this);
  }

  HelplyApprovalRequestDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _approvalId = $v.approvalId;
      _toolLabel = $v.toolLabel;
      _summary = $v.summary;
      _details = $v.details.toBuilder();
      _destructive = $v.destructive;
      _arguments = $v.arguments.toBuilder();
      _risk = $v.risk;
      _riskReasons = $v.riskReasons.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HelplyApprovalRequestDto other) {
    _$v = other as _$HelplyApprovalRequestDto;
  }

  @override
  void update(void Function(HelplyApprovalRequestDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HelplyApprovalRequestDto build() => _build();

  _$HelplyApprovalRequestDto _build() {
    _$HelplyApprovalRequestDto _$result;
    try {
      _$result =
          _$v ??
          _$HelplyApprovalRequestDto._(
            approvalId: BuiltValueNullFieldError.checkNotNull(
              approvalId,
              r'HelplyApprovalRequestDto',
              'approvalId',
            ),
            toolLabel: BuiltValueNullFieldError.checkNotNull(
              toolLabel,
              r'HelplyApprovalRequestDto',
              'toolLabel',
            ),
            summary: BuiltValueNullFieldError.checkNotNull(
              summary,
              r'HelplyApprovalRequestDto',
              'summary',
            ),
            details: details.build(),
            destructive: BuiltValueNullFieldError.checkNotNull(
              destructive,
              r'HelplyApprovalRequestDto',
              'destructive',
            ),
            arguments: arguments.build(),
            risk: BuiltValueNullFieldError.checkNotNull(
              risk,
              r'HelplyApprovalRequestDto',
              'risk',
            ),
            riskReasons: riskReasons.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'details';
        details.build();

        _$failedField = 'arguments';
        arguments.build();

        _$failedField = 'riskReasons';
        riskReasons.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HelplyApprovalRequestDto',
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
