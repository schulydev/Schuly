// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helply_code_run_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HelplyCodeRunDto extends HelplyCodeRunDto {
  @override
  final String command;
  @override
  final String? output;
  @override
  final int? exitCode;

  factory _$HelplyCodeRunDto([
    void Function(HelplyCodeRunDtoBuilder)? updates,
  ]) => (HelplyCodeRunDtoBuilder()..update(updates))._build();

  _$HelplyCodeRunDto._({required this.command, this.output, this.exitCode})
    : super._();
  @override
  HelplyCodeRunDto rebuild(void Function(HelplyCodeRunDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HelplyCodeRunDtoBuilder toBuilder() =>
      HelplyCodeRunDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HelplyCodeRunDto &&
        command == other.command &&
        output == other.output &&
        exitCode == other.exitCode;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, command.hashCode);
    _$hash = $jc(_$hash, output.hashCode);
    _$hash = $jc(_$hash, exitCode.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HelplyCodeRunDto')
          ..add('command', command)
          ..add('output', output)
          ..add('exitCode', exitCode))
        .toString();
  }
}

class HelplyCodeRunDtoBuilder
    implements Builder<HelplyCodeRunDto, HelplyCodeRunDtoBuilder> {
  _$HelplyCodeRunDto? _$v;

  String? _command;
  String? get command => _$this._command;
  set command(String? command) => _$this._command = command;

  String? _output;
  String? get output => _$this._output;
  set output(String? output) => _$this._output = output;

  int? _exitCode;
  int? get exitCode => _$this._exitCode;
  set exitCode(int? exitCode) => _$this._exitCode = exitCode;

  HelplyCodeRunDtoBuilder() {
    HelplyCodeRunDto._defaults(this);
  }

  HelplyCodeRunDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _command = $v.command;
      _output = $v.output;
      _exitCode = $v.exitCode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HelplyCodeRunDto other) {
    _$v = other as _$HelplyCodeRunDto;
  }

  @override
  void update(void Function(HelplyCodeRunDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HelplyCodeRunDto build() => _build();

  _$HelplyCodeRunDto _build() {
    final _$result =
        _$v ??
        _$HelplyCodeRunDto._(
          command: BuiltValueNullFieldError.checkNotNull(
            command,
            r'HelplyCodeRunDto',
            'command',
          ),
          output: output,
          exitCode: exitCode,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
