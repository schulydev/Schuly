//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:schuly_api/src/date_serializer.dart';
import 'package:schuly_api/src/model/date.dart';

import 'package:schuly_api/src/model/absence_dto.dart';
import 'package:schuly_api/src/model/absence_type.dart';
import 'package:schuly_api/src/model/accept_privacy_notice_command.dart';
import 'package:schuly_api/src/model/account_export_dto.dart';
import 'package:schuly_api/src/model/add_my_grade_command.dart';
import 'package:schuly_api/src/model/agenda_entry_dto.dart';
import 'package:schuly_api/src/model/agenda_entry_type.dart';
import 'package:schuly_api/src/model/answer_helply_approvals_request.dart';
import 'package:schuly_api/src/model/app_dto.dart';
import 'package:schuly_api/src/model/application_user_dto.dart';
import 'package:schuly_api/src/model/begin_two_factor_request.dart';
import 'package:schuly_api/src/model/change_email_request.dart';
import 'package:schuly_api/src/model/change_password_request.dart';
import 'package:schuly_api/src/model/class_dto.dart';
import 'package:schuly_api/src/model/class_member_dto.dart';
import 'package:schuly_api/src/model/confirm_two_factor_request.dart';
import 'package:schuly_api/src/model/create_absence_command.dart';
import 'package:schuly_api/src/model/create_agenda_entry_command.dart';
import 'package:schuly_api/src/model/create_helply_conversation_request.dart';
import 'package:schuly_api/src/model/create_mcp_api_key_command.dart';
import 'package:schuly_api/src/model/create_my_school_command.dart';
import 'package:schuly_api/src/model/created_mcp_api_key_dto.dart';
import 'package:schuly_api/src/model/decide_mcp_authorization_command.dart';
import 'package:schuly_api/src/model/delete_account_request.dart';
import 'package:schuly_api/src/model/disable_two_factor_request.dart';
import 'package:schuly_api/src/model/entity_tag_header_value.dart';
import 'package:schuly_api/src/model/error_response.dart';
import 'package:schuly_api/src/model/exam_dto.dart';
import 'package:schuly_api/src/model/exam_type.dart';
import 'package:schuly_api/src/model/export_ai_app_activity_dto.dart';
import 'package:schuly_api/src/model/export_ai_app_connection_dto.dart';
import 'package:schuly_api/src/model/export_ai_app_key_dto.dart';
import 'package:schuly_api/src/model/export_ai_apps_dto.dart';
import 'package:schuly_api/src/model/export_connected_account_dto.dart';
import 'package:schuly_api/src/model/export_device_dto.dart';
import 'package:schuly_api/src/model/export_external_login_dto.dart';
import 'package:schuly_api/src/model/export_helply_attachment_dto.dart';
import 'package:schuly_api/src/model/export_helply_conversation_dto.dart';
import 'package:schuly_api/src/model/export_helply_dto.dart';
import 'package:schuly_api/src/model/export_notifications_dto.dart';
import 'package:schuly_api/src/model/export_passkey_dto.dart';
import 'package:schuly_api/src/model/export_privacy_notice_dto.dart';
import 'package:schuly_api/src/model/export_queued_notification_dto.dart';
import 'package:schuly_api/src/model/export_security_event_dto.dart';
import 'package:schuly_api/src/model/export_session_dto.dart';
import 'package:schuly_api/src/model/export_sign_in_dto.dart';
import 'package:schuly_api/src/model/file_content_result.dart';
import 'package:schuly_api/src/model/forgot_password_request.dart';
import 'package:schuly_api/src/model/grade_dto.dart';
import 'package:schuly_api/src/model/helply_approval_detail_dto.dart';
import 'package:schuly_api/src/model/helply_approval_request_dto.dart';
import 'package:schuly_api/src/model/helply_attachment_dto.dart';
import 'package:schuly_api/src/model/helply_code_run_dto.dart';
import 'package:schuly_api/src/model/helply_conversation_dto.dart';
import 'package:schuly_api/src/model/helply_conversation_summary_dto.dart';
import 'package:schuly_api/src/model/helply_decision_request.dart';
import 'package:schuly_api/src/model/helply_message_dto.dart';
import 'package:schuly_api/src/model/helply_settings_dto.dart';
import 'package:schuly_api/src/model/helply_status_dto.dart';
import 'package:schuly_api/src/model/helply_tool_activity_dto.dart';
import 'package:schuly_api/src/model/link_action_dto.dart';
import 'package:schuly_api/src/model/link_capability_dto.dart';
import 'package:schuly_api/src/model/link_device_code_dto.dart';
import 'package:schuly_api/src/model/link_done_dto.dart';
import 'package:schuly_api/src/model/link_error_dto.dart';
import 'package:schuly_api/src/model/link_field_dto.dart';
import 'package:schuly_api/src/model/link_field_type_dto.dart';
import 'package:schuly_api/src/model/link_flow_dto.dart';
import 'package:schuly_api/src/model/link_icon_dto.dart';
import 'package:schuly_api/src/model/link_option_dto.dart';
import 'package:schuly_api/src/model/link_otp_dto.dart';
import 'package:schuly_api/src/model/link_provider_account_dto.dart';
import 'package:schuly_api/src/model/link_provider_dto.dart';
import 'package:schuly_api/src/model/link_push_code_dto.dart';
import 'package:schuly_api/src/model/link_redirect_dto.dart';
import 'package:schuly_api/src/model/link_redirect_mode_dto.dart';
import 'package:schuly_api/src/model/link_session_dto.dart';
import 'package:schuly_api/src/model/link_session_status.dart';
import 'package:schuly_api/src/model/link_step_dto.dart';
import 'package:schuly_api/src/model/link_step_kind_dto.dart';
import 'package:schuly_api/src/model/linked_account_dto.dart';
import 'package:schuly_api/src/model/linked_account_status_dto.dart';
import 'package:schuly_api/src/model/login_field_suggestion_dto.dart';
import 'package:schuly_api/src/model/login_request.dart';
import 'package:schuly_api/src/model/logout_request.dart';
import 'package:schuly_api/src/model/mcp_access_level.dart';
import 'package:schuly_api/src/model/mcp_activity_dto.dart';
import 'package:schuly_api/src/model/mcp_api_key_dto.dart';
import 'package:schuly_api/src/model/mcp_authorization_decision_dto.dart';
import 'package:schuly_api/src/model/mcp_authorization_parameters.dart';
import 'package:schuly_api/src/model/mcp_authorization_request_dto.dart';
import 'package:schuly_api/src/model/mcp_connection_dto.dart';
import 'package:schuly_api/src/model/mcp_permission_set.dart';
import 'package:schuly_api/src/model/my_school_dto.dart';
import 'package:schuly_api/src/model/notification_preferences_dto.dart';
import 'package:schuly_api/src/model/privacy_notice_status_dto.dart';
import 'package:schuly_api/src/model/problem_details.dart';
import 'package:schuly_api/src/model/push_result.dart';
import 'package:schuly_api/src/model/refresh_request.dart';
import 'package:schuly_api/src/model/regenerate_recovery_codes_request.dart';
import 'package:schuly_api/src/model/register_device_token_command.dart';
import 'package:schuly_api/src/model/register_request.dart';
import 'package:schuly_api/src/model/rename_helply_conversation_request.dart';
import 'package:schuly_api/src/model/reset_password_request.dart';
import 'package:schuly_api/src/model/roles.dart';
import 'package:schuly_api/src/model/school_dto.dart';
import 'package:schuly_api/src/model/school_system_dto.dart';
import 'package:schuly_api/src/model/school_system_login_field_dto.dart';
import 'package:schuly_api/src/model/school_user_dto.dart';
import 'package:schuly_api/src/model/school_user_summary_dto.dart';
import 'package:schuly_api/src/model/semester_report_dto.dart';
import 'package:schuly_api/src/model/semester_subject_grade_dto.dart';
import 'package:schuly_api/src/model/send_helply_message_request.dart';
import 'package:schuly_api/src/model/session_summary.dart';
import 'package:schuly_api/src/model/start_link_request.dart';
import 'package:schuly_api/src/model/step_up_challenge_response.dart';
import 'package:schuly_api/src/model/step_up_response.dart';
import 'package:schuly_api/src/model/step_up_verify_request.dart';
import 'package:schuly_api/src/model/string_segment.dart';
import 'package:schuly_api/src/model/student_document_dto.dart';
import 'package:schuly_api/src/model/submit_link_request.dart';
import 'package:schuly_api/src/model/teacher_dto.dart';
import 'package:schuly_api/src/model/token_response.dart';
import 'package:schuly_api/src/model/trusted_device_summary.dart';
import 'package:schuly_api/src/model/two_factor_enrolment_completed.dart';
import 'package:schuly_api/src/model/two_factor_enrolment_started.dart';
import 'package:schuly_api/src/model/two_factor_status.dart';
import 'package:schuly_api/src/model/unified_login_request.dart';
import 'package:schuly_api/src/model/update_absence_command.dart';
import 'package:schuly_api/src/model/update_agenda_entry_command.dart';
import 'package:schuly_api/src/model/update_helply_workspace_request.dart';
import 'package:schuly_api/src/model/update_my_grade_command.dart';
import 'package:schuly_api/src/model/update_notification_preferences_command.dart';
import 'package:schuly_api/src/model/user_class_dto.dart';
import 'package:schuly_api/src/model/user_state.dart';
import 'package:schuly_api/src/model/validation_error_response.dart';
import 'package:schuly_api/src/model/verify_email_request.dart';
import 'package:schuly_api/src/model/verify_two_factor_request.dart';

part 'serializers.g.dart';

@SerializersFor([
  AbsenceDto,
  AbsenceType,
  AcceptPrivacyNoticeCommand,
  AccountExportDto,
  AddMyGradeCommand,
  AgendaEntryDto,
  AgendaEntryType,
  AnswerHelplyApprovalsRequest,
  AppDto,
  ApplicationUserDto,
  BeginTwoFactorRequest,
  ChangeEmailRequest,
  ChangePasswordRequest,
  ClassDto,
  ClassMemberDto,
  ConfirmTwoFactorRequest,
  CreateAbsenceCommand,
  CreateAgendaEntryCommand,
  CreateHelplyConversationRequest,
  CreateMcpApiKeyCommand,
  CreateMySchoolCommand,
  CreatedMcpApiKeyDto,
  DecideMcpAuthorizationCommand,
  DeleteAccountRequest,
  DisableTwoFactorRequest,
  EntityTagHeaderValue,
  ErrorResponse,
  ExamDto,
  ExamType,
  ExportAiAppActivityDto,
  ExportAiAppConnectionDto,
  ExportAiAppKeyDto,
  ExportAiAppsDto,
  ExportConnectedAccountDto,
  ExportDeviceDto,
  ExportExternalLoginDto,
  ExportHelplyAttachmentDto,
  ExportHelplyConversationDto,
  ExportHelplyDto,
  ExportNotificationsDto,
  ExportPasskeyDto,
  ExportPrivacyNoticeDto,
  ExportQueuedNotificationDto,
  ExportSecurityEventDto,
  ExportSessionDto,
  ExportSignInDto,
  FileContentResult,
  ForgotPasswordRequest,
  GradeDto,
  HelplyApprovalDetailDto,
  HelplyApprovalRequestDto,
  HelplyAttachmentDto,
  HelplyCodeRunDto,
  HelplyConversationDto,
  HelplyConversationSummaryDto,
  HelplyDecisionRequest,
  HelplyMessageDto,
  HelplySettingsDto,
  HelplyStatusDto,
  HelplyToolActivityDto,
  LinkActionDto,
  LinkCapabilityDto,
  LinkDeviceCodeDto,
  LinkDoneDto,
  LinkErrorDto,
  LinkFieldDto,
  LinkFieldTypeDto,
  LinkFlowDto,
  LinkIconDto,
  LinkOptionDto,
  LinkOtpDto,
  LinkProviderAccountDto,
  LinkProviderDto,
  LinkPushCodeDto,
  LinkRedirectDto,
  LinkRedirectModeDto,
  LinkSessionDto,
  LinkSessionStatus,
  LinkStepDto,
  LinkStepKindDto,
  LinkedAccountDto,
  LinkedAccountStatusDto,
  LoginFieldSuggestionDto,
  LoginRequest,
  LogoutRequest,
  McpAccessLevel,
  McpActivityDto,
  McpApiKeyDto,
  McpAuthorizationDecisionDto,
  McpAuthorizationParameters,
  McpAuthorizationRequestDto,
  McpConnectionDto,
  McpPermissionSet,
  MySchoolDto,
  NotificationPreferencesDto,
  PrivacyNoticeStatusDto,
  ProblemDetails,
  PushResult,
  RefreshRequest,
  RegenerateRecoveryCodesRequest,
  RegisterDeviceTokenCommand,
  RegisterRequest,
  RenameHelplyConversationRequest,
  ResetPasswordRequest,
  Roles,
  SchoolDto,
  SchoolSystemDto,
  SchoolSystemLoginFieldDto,
  SchoolUserDto,
  SchoolUserSummaryDto,
  SemesterReportDto,
  SemesterSubjectGradeDto,
  SendHelplyMessageRequest,
  SessionSummary,
  StartLinkRequest,
  StepUpChallengeResponse,
  StepUpResponse,
  StepUpVerifyRequest,
  StringSegment,
  StudentDocumentDto,
  SubmitLinkRequest,
  TeacherDto,
  TokenResponse,
  TrustedDeviceSummary,
  TwoFactorEnrolmentCompleted,
  TwoFactorEnrolmentStarted,
  TwoFactorStatus,
  UnifiedLoginRequest,
  UpdateAbsenceCommand,
  UpdateAgendaEntryCommand,
  UpdateHelplyWorkspaceRequest,
  UpdateMyGradeCommand,
  UpdateNotificationPreferencesCommand,
  UserClassDto,
  UserState,
  ValidationErrorResponse,
  VerifyEmailRequest,
  VerifyTwoFactorRequest,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(ExamDto)]),
        () => ListBuilder<ExamDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(SessionSummary)]),
        () => ListBuilder<SessionSummary>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(McpConnectionDto)]),
        () => ListBuilder<McpConnectionDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(StudentDocumentDto)]),
        () => ListBuilder<StudentDocumentDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(McpApiKeyDto)]),
        () => ListBuilder<McpApiKeyDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(TrustedDeviceSummary)]),
        () => ListBuilder<TrustedDeviceSummary>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(SchoolUserDto)]),
        () => ListBuilder<SchoolUserDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(LinkedAccountDto)]),
        () => ListBuilder<LinkedAccountDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(LinkProviderDto)]),
        () => ListBuilder<LinkProviderDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(AbsenceDto)]),
        () => ListBuilder<AbsenceDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(HelplyConversationSummaryDto)]),
        () => ListBuilder<HelplyConversationSummaryDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(LinkProviderAccountDto)]),
        () => ListBuilder<LinkProviderAccountDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(MySchoolDto)]),
        () => ListBuilder<MySchoolDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(SemesterReportDto)]),
        () => ListBuilder<SemesterReportDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(TeacherDto)]),
        () => ListBuilder<TeacherDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(ClassDto)]),
        () => ListBuilder<ClassDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(McpActivityDto)]),
        () => ListBuilder<McpActivityDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(AgendaEntryDto)]),
        () => ListBuilder<AgendaEntryDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(SchoolSystemDto)]),
        () => ListBuilder<SchoolSystemDto>(),
      )
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer())
    ).build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
