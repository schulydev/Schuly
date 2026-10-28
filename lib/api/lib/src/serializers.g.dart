// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers =
    (Serializers().toBuilder()
          ..add(AbsenceDto.serializer)
          ..add(AbsenceType.serializer)
          ..add(AccountExportDto.serializer)
          ..add(AddGradeToExamCommand.serializer)
          ..add(AddMyGradeCommand.serializer)
          ..add(AgendaEntryDto.serializer)
          ..add(AgendaEntryType.serializer)
          ..add(AppDto.serializer)
          ..add(ApplicationUserDto.serializer)
          ..add(BeginTwoFactorRequest.serializer)
          ..add(ChangeEmailRequest.serializer)
          ..add(ChangePasswordRequest.serializer)
          ..add(ClassDto.serializer)
          ..add(ClassMemberDto.serializer)
          ..add(CompleteRequest.serializer)
          ..add(ConfirmTwoFactorRequest.serializer)
          ..add(Cookie.serializer)
          ..add(CreateAbsenceCommand.serializer)
          ..add(CreateAgendaEntryCommand.serializer)
          ..add(CreateApplicationUserCommand.serializer)
          ..add(CreateClassCommand.serializer)
          ..add(CreateExamCommand.serializer)
          ..add(CreateMySchoolCommand.serializer)
          ..add(CreateSchoolCommand.serializer)
          ..add(CreateSchoolSystemCommand.serializer)
          ..add(CreateSchoolUserCommand.serializer)
          ..add(CreateTeacherCommand.serializer)
          ..add(DisableTwoFactorRequest.serializer)
          ..add(EnrolStudentCommand.serializer)
          ..add(ErrorResponse.serializer)
          ..add(ExamDto.serializer)
          ..add(ExamType.serializer)
          ..add(ExternalLinkResponse.serializer)
          ..add(ExternalLoginExchangeRequest.serializer)
          ..add(ExternalLoginResponse.serializer)
          ..add(ExternalProviderResponse.serializer)
          ..add(ForgotPasswordRequest.serializer)
          ..add(GradeDto.serializer)
          ..add(InstallPluginRequest.serializer)
          ..add(LinkExternalLoginRequest.serializer)
          ..add(LinkedAccountDto.serializer)
          ..add(LoginRequest.serializer)
          ..add(LogoutRequest.serializer)
          ..add(MicrosoftCalendarAccount.serializer)
          ..add(MicrosoftCalendarEvent.serializer)
          ..add(MicrosoftCalendarFeed.serializer)
          ..add(MySchoolDto.serializer)
          ..add(NotificationPreferencesDto.serializer)
          ..add(OdaorgStatelessAgendaEvent.serializer)
          ..add(OdaorgStatelessData.serializer)
          ..add(OdaorgStatelessExam.serializer)
          ..add(OdaorgStatelessGrade.serializer)
          ..add(OdaorgStatelessRequest.serializer)
          ..add(OdaorgStatelessUserInfo.serializer)
          ..add(PluginDto.serializer)
          ..add(PluginTaskStatus.serializer)
          ..add(ProblemDetails.serializer)
          ..add(PushResult.serializer)
          ..add(ReencryptStudentDocumentsResult.serializer)
          ..add(RefreshRequest.serializer)
          ..add(RegenerateRecoveryCodesRequest.serializer)
          ..add(RegisterDeviceTokenCommand.serializer)
          ..add(RegisterRequest.serializer)
          ..add(ResetPasswordRequest.serializer)
          ..add(Roles.serializer)
          ..add(SchoolDto.serializer)
          ..add(SchoolSystemDto.serializer)
          ..add(SchoolSystemLoginFieldDto.serializer)
          ..add(SchoolUserDto.serializer)
          ..add(SchoolUserSummaryDto.serializer)
          ..add(SemesterReportDto.serializer)
          ..add(SemesterSubjectGradeDto.serializer)
          ..add(StatelessLoginRequest.serializer)
          ..add(StatelessRefreshRequest.serializer)
          ..add(StepUpChallengeResponse.serializer)
          ..add(StepUpResponse.serializer)
          ..add(StepUpVerifyRequest.serializer)
          ..add(StudentDocumentDto.serializer)
          ..add(TeacherDto.serializer)
          ..add(TokenResponse.serializer)
          ..add(TrustedDeviceSummary.serializer)
          ..add(TwoFactorChallengeResponse.serializer)
          ..add(TwoFactorEnrolmentCompleted.serializer)
          ..add(TwoFactorEnrolmentStarted.serializer)
          ..add(TwoFactorStatus.serializer)
          ..add(UnifiedLoginRequest.serializer)
          ..add(UnlinkExternalLoginRequest.serializer)
          ..add(UpdateAbsenceCommand.serializer)
          ..add(UpdateAgendaEntryCommand.serializer)
          ..add(UpdateApplicationUserCommand.serializer)
          ..add(UpdateClassCommand.serializer)
          ..add(UpdateExamCommand.serializer)
          ..add(UpdateMyGradeCommand.serializer)
          ..add(UpdateNotificationPreferencesCommand.serializer)
          ..add(UpdateSchoolCommand.serializer)
          ..add(UpdateSchoolSystemCommand.serializer)
          ..add(UpdateSchoolUserCommand.serializer)
          ..add(UpdateTeacherCommand.serializer)
          ..add(UserClassDto.serializer)
          ..add(UserState.serializer)
          ..add(ValidationErrorResponse.serializer)
          ..add(VerifyEmailRequest.serializer)
          ..add(VerifyTwoFactorRequest.serializer)
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(AbsenceDto)]),
            () => ListBuilder<AbsenceDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(GradeDto)]),
            () => ListBuilder<GradeDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(AbsenceDto)]),
            () => ListBuilder<AbsenceDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(GradeDto)]),
            () => ListBuilder<GradeDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(UserClassDto)]),
            () => ListBuilder<UserClassDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(ClassMemberDto)]),
            () => ListBuilder<ClassMemberDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(AgendaEntryDto)]),
            () => ListBuilder<AgendaEntryDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(ExamDto)]),
            () => ListBuilder<ExamDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(Cookie)]),
            () => ListBuilder<Cookie>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(GradeDto)]),
            () => ListBuilder<GradeDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(MicrosoftCalendarAccount),
            ]),
            () => ListBuilder<MicrosoftCalendarAccount>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(MicrosoftCalendarEvent),
            ]),
            () => ListBuilder<MicrosoftCalendarEvent>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(OdaorgStatelessGrade),
            ]),
            () => ListBuilder<OdaorgStatelessGrade>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(OdaorgStatelessExam),
            ]),
            () => ListBuilder<OdaorgStatelessExam>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(OdaorgStatelessAgendaEvent),
            ]),
            () => ListBuilder<OdaorgStatelessAgendaEvent>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(SchoolSystemLoginFieldDto),
            ]),
            () => ListBuilder<SchoolSystemLoginFieldDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(SchoolSystemLoginFieldDto),
            ]),
            () => ListBuilder<SchoolSystemLoginFieldDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(SchoolSystemLoginFieldDto),
            ]),
            () => ListBuilder<SchoolSystemLoginFieldDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(SchoolUserDto)]),
            () => ListBuilder<SchoolUserDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(AgendaEntryDto)]),
            () => ListBuilder<AgendaEntryDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(SemesterReportDto),
            ]),
            () => ListBuilder<SemesterReportDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(StudentDocumentDto),
            ]),
            () => ListBuilder<StudentDocumentDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(LinkedAccountDto)]),
            () => ListBuilder<LinkedAccountDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(SchoolUserSummaryDto),
            ]),
            () => ListBuilder<SchoolUserSummaryDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(SemesterSubjectGradeDto),
            ]),
            () => ListBuilder<SemesterSubjectGradeDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltMap, const [
              const FullType(String),
              const FullType(String),
            ]),
            () => MapBuilder<String, String>(),
          ))
        .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
