// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_step_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LinkStepDto extends LinkStepDto {
  @override
  final String id;
  @override
  final LinkStepKindDto kind;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? error;
  @override
  final BuiltList<LinkFieldDto> fields;
  @override
  final LinkOtpDto? otp;
  @override
  final LinkPushCodeDto? pushCode;
  @override
  final LinkDeviceCodeDto? deviceCode;
  @override
  final LinkRedirectDto? redirect;
  @override
  final BuiltList<LinkOptionDto> options;
  @override
  final BuiltList<LinkActionDto> actions;
  @override
  final String? submitLabel;
  @override
  final LinkDoneDto? done;

  factory _$LinkStepDto([void Function(LinkStepDtoBuilder)? updates]) =>
      (LinkStepDtoBuilder()..update(updates))._build();

  _$LinkStepDto._({
    required this.id,
    required this.kind,
    this.title,
    this.description,
    this.error,
    required this.fields,
    this.otp,
    this.pushCode,
    this.deviceCode,
    this.redirect,
    required this.options,
    required this.actions,
    this.submitLabel,
    this.done,
  }) : super._();
  @override
  LinkStepDto rebuild(void Function(LinkStepDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LinkStepDtoBuilder toBuilder() => LinkStepDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LinkStepDto &&
        id == other.id &&
        kind == other.kind &&
        title == other.title &&
        description == other.description &&
        error == other.error &&
        fields == other.fields &&
        otp == other.otp &&
        pushCode == other.pushCode &&
        deviceCode == other.deviceCode &&
        redirect == other.redirect &&
        options == other.options &&
        actions == other.actions &&
        submitLabel == other.submitLabel &&
        done == other.done;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, error.hashCode);
    _$hash = $jc(_$hash, fields.hashCode);
    _$hash = $jc(_$hash, otp.hashCode);
    _$hash = $jc(_$hash, pushCode.hashCode);
    _$hash = $jc(_$hash, deviceCode.hashCode);
    _$hash = $jc(_$hash, redirect.hashCode);
    _$hash = $jc(_$hash, options.hashCode);
    _$hash = $jc(_$hash, actions.hashCode);
    _$hash = $jc(_$hash, submitLabel.hashCode);
    _$hash = $jc(_$hash, done.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LinkStepDto')
          ..add('id', id)
          ..add('kind', kind)
          ..add('title', title)
          ..add('description', description)
          ..add('error', error)
          ..add('fields', fields)
          ..add('otp', otp)
          ..add('pushCode', pushCode)
          ..add('deviceCode', deviceCode)
          ..add('redirect', redirect)
          ..add('options', options)
          ..add('actions', actions)
          ..add('submitLabel', submitLabel)
          ..add('done', done))
        .toString();
  }
}

class LinkStepDtoBuilder implements Builder<LinkStepDto, LinkStepDtoBuilder> {
  _$LinkStepDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  LinkStepKindDto? _kind;
  LinkStepKindDto? get kind => _$this._kind;
  set kind(LinkStepKindDto? kind) => _$this._kind = kind;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _error;
  String? get error => _$this._error;
  set error(String? error) => _$this._error = error;

  ListBuilder<LinkFieldDto>? _fields;
  ListBuilder<LinkFieldDto> get fields =>
      _$this._fields ??= ListBuilder<LinkFieldDto>();
  set fields(ListBuilder<LinkFieldDto>? fields) => _$this._fields = fields;

  LinkOtpDtoBuilder? _otp;
  LinkOtpDtoBuilder get otp => _$this._otp ??= LinkOtpDtoBuilder();
  set otp(LinkOtpDtoBuilder? otp) => _$this._otp = otp;

  LinkPushCodeDtoBuilder? _pushCode;
  LinkPushCodeDtoBuilder get pushCode =>
      _$this._pushCode ??= LinkPushCodeDtoBuilder();
  set pushCode(LinkPushCodeDtoBuilder? pushCode) => _$this._pushCode = pushCode;

  LinkDeviceCodeDtoBuilder? _deviceCode;
  LinkDeviceCodeDtoBuilder get deviceCode =>
      _$this._deviceCode ??= LinkDeviceCodeDtoBuilder();
  set deviceCode(LinkDeviceCodeDtoBuilder? deviceCode) =>
      _$this._deviceCode = deviceCode;

  LinkRedirectDtoBuilder? _redirect;
  LinkRedirectDtoBuilder get redirect =>
      _$this._redirect ??= LinkRedirectDtoBuilder();
  set redirect(LinkRedirectDtoBuilder? redirect) => _$this._redirect = redirect;

  ListBuilder<LinkOptionDto>? _options;
  ListBuilder<LinkOptionDto> get options =>
      _$this._options ??= ListBuilder<LinkOptionDto>();
  set options(ListBuilder<LinkOptionDto>? options) => _$this._options = options;

  ListBuilder<LinkActionDto>? _actions;
  ListBuilder<LinkActionDto> get actions =>
      _$this._actions ??= ListBuilder<LinkActionDto>();
  set actions(ListBuilder<LinkActionDto>? actions) => _$this._actions = actions;

  String? _submitLabel;
  String? get submitLabel => _$this._submitLabel;
  set submitLabel(String? submitLabel) => _$this._submitLabel = submitLabel;

  LinkDoneDtoBuilder? _done;
  LinkDoneDtoBuilder get done => _$this._done ??= LinkDoneDtoBuilder();
  set done(LinkDoneDtoBuilder? done) => _$this._done = done;

  LinkStepDtoBuilder() {
    LinkStepDto._defaults(this);
  }

  LinkStepDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _kind = $v.kind;
      _title = $v.title;
      _description = $v.description;
      _error = $v.error;
      _fields = $v.fields.toBuilder();
      _otp = $v.otp?.toBuilder();
      _pushCode = $v.pushCode?.toBuilder();
      _deviceCode = $v.deviceCode?.toBuilder();
      _redirect = $v.redirect?.toBuilder();
      _options = $v.options.toBuilder();
      _actions = $v.actions.toBuilder();
      _submitLabel = $v.submitLabel;
      _done = $v.done?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LinkStepDto other) {
    _$v = other as _$LinkStepDto;
  }

  @override
  void update(void Function(LinkStepDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LinkStepDto build() => _build();

  _$LinkStepDto _build() {
    _$LinkStepDto _$result;
    try {
      _$result =
          _$v ??
          _$LinkStepDto._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'LinkStepDto', 'id'),
            kind: BuiltValueNullFieldError.checkNotNull(
              kind,
              r'LinkStepDto',
              'kind',
            ),
            title: title,
            description: description,
            error: error,
            fields: fields.build(),
            otp: _otp?.build(),
            pushCode: _pushCode?.build(),
            deviceCode: _deviceCode?.build(),
            redirect: _redirect?.build(),
            options: options.build(),
            actions: actions.build(),
            submitLabel: submitLabel,
            done: _done?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'fields';
        fields.build();
        _$failedField = 'otp';
        _otp?.build();
        _$failedField = 'pushCode';
        _pushCode?.build();
        _$failedField = 'deviceCode';
        _deviceCode?.build();
        _$failedField = 'redirect';
        _redirect?.build();
        _$failedField = 'options';
        options.build();
        _$failedField = 'actions';
        actions.build();

        _$failedField = 'done';
        _done?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'LinkStepDto',
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
