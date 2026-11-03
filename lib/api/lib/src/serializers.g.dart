// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers =
    (Serializers().toBuilder()
          ..add(AbsenceDto.serializer)
          ..add(AbsenceType.serializer)
          ..add(AcceptPrivacyNoticeCommand.serializer)
          ..add(AccountExportDto.serializer)
          ..add(AddMyGradeCommand.serializer)
          ..add(AgendaEntryDto.serializer)
          ..add(AgendaEntryType.serializer)
          ..add(AnswerHelplyApprovalsRequest.serializer)
          ..add(AppDto.serializer)
          ..add(ApplicationUserDto.serializer)
          ..add(BeginTwoFactorRequest.serializer)
          ..add(ChangeEmailRequest.serializer)
          ..add(ChangePasswordRequest.serializer)
          ..add(ClassDto.serializer)
          ..add(ClassMemberDto.serializer)
          ..add(ConfirmTwoFactorRequest.serializer)
          ..add(CreateAbsenceCommand.serializer)
          ..add(CreateAgendaEntryCommand.serializer)
          ..add(CreateHelplyConversationRequest.serializer)
          ..add(CreateMcpApiKeyCommand.serializer)
          ..add(CreateMySchoolCommand.serializer)
          ..add(CreatedMcpApiKeyDto.serializer)
          ..add(DecideMcpAuthorizationCommand.serializer)
          ..add(DeleteAccountRequest.serializer)
          ..add(DisableTwoFactorRequest.serializer)
          ..add(EntityTagHeaderValue.serializer)
          ..add(ErrorResponse.serializer)
          ..add(ExamDto.serializer)
          ..add(ExamType.serializer)
          ..add(ExportAiAppActivityDto.serializer)
          ..add(ExportAiAppConnectionDto.serializer)
          ..add(ExportAiAppKeyDto.serializer)
          ..add(ExportAiAppsDto.serializer)
          ..add(ExportConnectedAccountDto.serializer)
          ..add(ExportDeviceDto.serializer)
          ..add(ExportExternalLoginDto.serializer)
          ..add(ExportHelplyAttachmentDto.serializer)
          ..add(ExportHelplyConversationDto.serializer)
          ..add(ExportHelplyDto.serializer)
          ..add(ExportNotificationsDto.serializer)
          ..add(ExportPasskeyDto.serializer)
          ..add(ExportPrivacyNoticeDto.serializer)
          ..add(ExportQueuedNotificationDto.serializer)
          ..add(ExportSessionDto.serializer)
          ..add(ExportSignInDto.serializer)
          ..add(FileContentResult.serializer)
          ..add(ForgotPasswordRequest.serializer)
          ..add(GradeDto.serializer)
          ..add(HelplyApprovalDetailDto.serializer)
          ..add(HelplyApprovalRequestDto.serializer)
          ..add(HelplyAttachmentDto.serializer)
          ..add(HelplyCodeRunDto.serializer)
          ..add(HelplyConversationDto.serializer)
          ..add(HelplyConversationSummaryDto.serializer)
          ..add(HelplyDecisionRequest.serializer)
          ..add(HelplyMessageDto.serializer)
          ..add(HelplySettingsDto.serializer)
          ..add(HelplyStatusDto.serializer)
          ..add(HelplyToolActivityDto.serializer)
          ..add(LinkActionDto.serializer)
          ..add(LinkCapabilityDto.serializer)
          ..add(LinkDeviceCodeDto.serializer)
          ..add(LinkDoneDto.serializer)
          ..add(LinkErrorDto.serializer)
          ..add(LinkFieldDto.serializer)
          ..add(LinkFieldTypeDto.serializer)
          ..add(LinkFlowDto.serializer)
          ..add(LinkIconDto.serializer)
          ..add(LinkOptionDto.serializer)
          ..add(LinkOtpDto.serializer)
          ..add(LinkProviderAccountDto.serializer)
          ..add(LinkProviderDto.serializer)
          ..add(LinkPushCodeDto.serializer)
          ..add(LinkRedirectDto.serializer)
          ..add(LinkRedirectModeDto.serializer)
          ..add(LinkSessionDto.serializer)
          ..add(LinkSessionStatus.serializer)
          ..add(LinkStepDto.serializer)
          ..add(LinkStepKindDto.serializer)
          ..add(LinkedAccountDto.serializer)
          ..add(LinkedAccountStatusDto.serializer)
          ..add(LoginFieldSuggestionDto.serializer)
          ..add(LoginRequest.serializer)
          ..add(LogoutRequest.serializer)
          ..add(McpAccessLevel.serializer)
          ..add(McpActivityDto.serializer)
          ..add(McpApiKeyDto.serializer)
          ..add(McpAuthorizationDecisionDto.serializer)
          ..add(McpAuthorizationParameters.serializer)
          ..add(McpAuthorizationRequestDto.serializer)
          ..add(McpConnectionDto.serializer)
          ..add(McpPermissionSet.serializer)
          ..add(MySchoolDto.serializer)
          ..add(NotificationPreferencesDto.serializer)
          ..add(PrivacyNoticeStatusDto.serializer)
          ..add(ProblemDetails.serializer)
          ..add(PushResult.serializer)
          ..add(RefreshRequest.serializer)
          ..add(RegenerateRecoveryCodesRequest.serializer)
          ..add(RegisterDeviceTokenCommand.serializer)
          ..add(RegisterRequest.serializer)
          ..add(RenameHelplyConversationRequest.serializer)
          ..add(ResetPasswordRequest.serializer)
          ..add(Roles.serializer)
          ..add(SchoolDto.serializer)
          ..add(SchoolSystemDto.serializer)
          ..add(SchoolSystemLoginFieldDto.serializer)
          ..add(SchoolUserDto.serializer)
          ..add(SchoolUserSummaryDto.serializer)
          ..add(SemesterReportDto.serializer)
          ..add(SemesterSubjectGradeDto.serializer)
          ..add(SendHelplyMessageRequest.serializer)
          ..add(StartLinkRequest.serializer)
          ..add(StepUpChallengeResponse.serializer)
          ..add(StepUpResponse.serializer)
          ..add(StepUpVerifyRequest.serializer)
          ..add(StringSegment.serializer)
          ..add(StudentDocumentDto.serializer)
          ..add(SubmitLinkRequest.serializer)
          ..add(TeacherDto.serializer)
          ..add(TokenResponse.serializer)
          ..add(TrustedDeviceSummary.serializer)
          ..add(TwoFactorEnrolmentCompleted.serializer)
          ..add(TwoFactorEnrolmentStarted.serializer)
          ..add(TwoFactorStatus.serializer)
          ..add(UnifiedLoginRequest.serializer)
          ..add(UpdateAbsenceCommand.serializer)
          ..add(UpdateAgendaEntryCommand.serializer)
          ..add(UpdateHelplyWorkspaceRequest.serializer)
          ..add(UpdateMyGradeCommand.serializer)
          ..add(UpdateNotificationPreferencesCommand.serializer)
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
            const FullType(BuiltList, const [
              const FullType(ExportAiAppConnectionDto),
            ]),
            () => ListBuilder<ExportAiAppConnectionDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(ExportAiAppKeyDto),
            ]),
            () => ListBuilder<ExportAiAppKeyDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(ExportAiAppActivityDto),
            ]),
            () => ListBuilder<ExportAiAppActivityDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(ExportDeviceDto)]),
            () => ListBuilder<ExportDeviceDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(ExportQueuedNotificationDto),
            ]),
            () => ListBuilder<ExportQueuedNotificationDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(ExportExternalLoginDto),
            ]),
            () => ListBuilder<ExportExternalLoginDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(ExportPasskeyDto)]),
            () => ListBuilder<ExportPasskeyDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(ExportSessionDto)]),
            () => ListBuilder<ExportSessionDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(ExportSessionDto)]),
            () => ListBuilder<ExportSessionDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(ExportHelplyAttachmentDto),
            ]),
            () => ListBuilder<ExportHelplyAttachmentDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(ExportHelplyConversationDto),
            ]),
            () => ListBuilder<ExportHelplyConversationDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(GradeDto)]),
            () => ListBuilder<GradeDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(HelplyApprovalDetailDto),
            ]),
            () => ListBuilder<HelplyApprovalDetailDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(HelplyApprovalDetailDto),
            ]),
            () => ListBuilder<HelplyApprovalDetailDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(HelplyDecisionRequest),
            ]),
            () => ListBuilder<HelplyDecisionRequest>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(HelplyMessageDto)]),
            () => ListBuilder<HelplyMessageDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(HelplyApprovalRequestDto),
            ]),
            () => ListBuilder<HelplyApprovalRequestDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(HelplyToolActivityDto),
            ]),
            () => ListBuilder<HelplyToolActivityDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(HelplyAttachmentDto),
            ]),
            () => ListBuilder<HelplyAttachmentDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(LinkCapabilityDto),
            ]),
            () => ListBuilder<LinkCapabilityDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(LinkCapabilityDto),
            ]),
            () => ListBuilder<LinkCapabilityDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(LinkFlowDto)]),
            () => ListBuilder<LinkFlowDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(LinkFieldDto)]),
            () => ListBuilder<LinkFieldDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(LinkOptionDto)]),
            () => ListBuilder<LinkOptionDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(LinkActionDto)]),
            () => ListBuilder<LinkActionDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(LinkOptionDto)]),
            () => ListBuilder<LinkOptionDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(LoginFieldSuggestionDto),
            ]),
            () => ListBuilder<LoginFieldSuggestionDto>(),
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
              const FullType(ExportConnectedAccountDto),
            ]),
            () => ListBuilder<ExportConnectedAccountDto>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
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
              const FullType(McpAccessLevel),
            ]),
            () => MapBuilder<String, McpAccessLevel>(),
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
