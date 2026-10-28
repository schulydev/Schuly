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
import 'package:schuly_api/src/model/account_export_dto.dart';
import 'package:schuly_api/src/model/add_grade_to_exam_command.dart';
import 'package:schuly_api/src/model/add_my_grade_command.dart';
import 'package:schuly_api/src/model/agenda_entry_dto.dart';
import 'package:schuly_api/src/model/agenda_entry_type.dart';
import 'package:schuly_api/src/model/app_dto.dart';
import 'package:schuly_api/src/model/application_user_dto.dart';
import 'package:schuly_api/src/model/begin_two_factor_request.dart';
import 'package:schuly_api/src/model/change_email_request.dart';
import 'package:schuly_api/src/model/change_password_request.dart';
import 'package:schuly_api/src/model/class_dto.dart';
import 'package:schuly_api/src/model/class_member_dto.dart';
import 'package:schuly_api/src/model/complete_request.dart';
import 'package:schuly_api/src/model/confirm_two_factor_request.dart';
import 'package:schuly_api/src/model/cookie.dart';
import 'package:schuly_api/src/model/create_absence_command.dart';
import 'package:schuly_api/src/model/create_agenda_entry_command.dart';
import 'package:schuly_api/src/model/create_application_user_command.dart';
import 'package:schuly_api/src/model/create_class_command.dart';
import 'package:schuly_api/src/model/create_exam_command.dart';
import 'package:schuly_api/src/model/create_my_school_command.dart';
import 'package:schuly_api/src/model/create_school_command.dart';
import 'package:schuly_api/src/model/create_school_system_command.dart';
import 'package:schuly_api/src/model/create_school_user_command.dart';
import 'package:schuly_api/src/model/create_teacher_command.dart';
import 'package:schuly_api/src/model/disable_two_factor_request.dart';
import 'package:schuly_api/src/model/enrol_student_command.dart';
import 'package:schuly_api/src/model/error_response.dart';
import 'package:schuly_api/src/model/exam_dto.dart';
import 'package:schuly_api/src/model/exam_type.dart';
import 'package:schuly_api/src/model/external_link_response.dart';
import 'package:schuly_api/src/model/external_login_exchange_request.dart';
import 'package:schuly_api/src/model/external_login_response.dart';
import 'package:schuly_api/src/model/external_provider_response.dart';
import 'package:schuly_api/src/model/forgot_password_request.dart';
import 'package:schuly_api/src/model/grade_dto.dart';
import 'package:schuly_api/src/model/install_plugin_request.dart';
import 'package:schuly_api/src/model/link_external_login_request.dart';
import 'package:schuly_api/src/model/linked_account_dto.dart';
import 'package:schuly_api/src/model/login_request.dart';
import 'package:schuly_api/src/model/logout_request.dart';
import 'package:schuly_api/src/model/microsoft_calendar_account.dart';
import 'package:schuly_api/src/model/microsoft_calendar_event.dart';
import 'package:schuly_api/src/model/microsoft_calendar_feed.dart';
import 'package:schuly_api/src/model/my_school_dto.dart';
import 'package:schuly_api/src/model/notification_preferences_dto.dart';
import 'package:schuly_api/src/model/odaorg_stateless_agenda_event.dart';
import 'package:schuly_api/src/model/odaorg_stateless_data.dart';
import 'package:schuly_api/src/model/odaorg_stateless_exam.dart';
import 'package:schuly_api/src/model/odaorg_stateless_grade.dart';
import 'package:schuly_api/src/model/odaorg_stateless_request.dart';
import 'package:schuly_api/src/model/odaorg_stateless_user_info.dart';
import 'package:schuly_api/src/model/plugin_dto.dart';
import 'package:schuly_api/src/model/plugin_task_status.dart';
import 'package:schuly_api/src/model/problem_details.dart';
import 'package:schuly_api/src/model/push_result.dart';
import 'package:schuly_api/src/model/reencrypt_student_documents_result.dart';
import 'package:schuly_api/src/model/refresh_request.dart';
import 'package:schuly_api/src/model/regenerate_recovery_codes_request.dart';
import 'package:schuly_api/src/model/register_device_token_command.dart';
import 'package:schuly_api/src/model/register_request.dart';
import 'package:schuly_api/src/model/reset_password_request.dart';
import 'package:schuly_api/src/model/roles.dart';
import 'package:schuly_api/src/model/school_dto.dart';
import 'package:schuly_api/src/model/school_system_dto.dart';
import 'package:schuly_api/src/model/school_system_login_field_dto.dart';
import 'package:schuly_api/src/model/school_user_dto.dart';
import 'package:schuly_api/src/model/school_user_summary_dto.dart';
import 'package:schuly_api/src/model/semester_report_dto.dart';
import 'package:schuly_api/src/model/semester_subject_grade_dto.dart';
import 'package:schuly_api/src/model/stateless_login_request.dart';
import 'package:schuly_api/src/model/stateless_refresh_request.dart';
import 'package:schuly_api/src/model/step_up_challenge_response.dart';
import 'package:schuly_api/src/model/step_up_response.dart';
import 'package:schuly_api/src/model/step_up_verify_request.dart';
import 'package:schuly_api/src/model/student_document_dto.dart';
import 'package:schuly_api/src/model/teacher_dto.dart';
import 'package:schuly_api/src/model/token_response.dart';
import 'package:schuly_api/src/model/trusted_device_summary.dart';
import 'package:schuly_api/src/model/two_factor_challenge_response.dart';
import 'package:schuly_api/src/model/two_factor_enrolment_completed.dart';
import 'package:schuly_api/src/model/two_factor_enrolment_started.dart';
import 'package:schuly_api/src/model/two_factor_status.dart';
import 'package:schuly_api/src/model/unified_login_request.dart';
import 'package:schuly_api/src/model/unlink_external_login_request.dart';
import 'package:schuly_api/src/model/update_absence_command.dart';
import 'package:schuly_api/src/model/update_agenda_entry_command.dart';
import 'package:schuly_api/src/model/update_application_user_command.dart';
import 'package:schuly_api/src/model/update_class_command.dart';
import 'package:schuly_api/src/model/update_exam_command.dart';
import 'package:schuly_api/src/model/update_my_grade_command.dart';
import 'package:schuly_api/src/model/update_notification_preferences_command.dart';
import 'package:schuly_api/src/model/update_school_command.dart';
import 'package:schuly_api/src/model/update_school_system_command.dart';
import 'package:schuly_api/src/model/update_school_user_command.dart';
import 'package:schuly_api/src/model/update_teacher_command.dart';
import 'package:schuly_api/src/model/user_class_dto.dart';
import 'package:schuly_api/src/model/user_state.dart';
import 'package:schuly_api/src/model/validation_error_response.dart';
import 'package:schuly_api/src/model/verify_email_request.dart';
import 'package:schuly_api/src/model/verify_two_factor_request.dart';

part 'serializers.g.dart';

@SerializersFor([
  AbsenceDto,
  AbsenceType,
  AccountExportDto,
  AddGradeToExamCommand,
  AddMyGradeCommand,
  AgendaEntryDto,
  AgendaEntryType,
  AppDto,
  ApplicationUserDto,
  BeginTwoFactorRequest,
  ChangeEmailRequest,
  ChangePasswordRequest,
  ClassDto,
  ClassMemberDto,
  CompleteRequest,
  ConfirmTwoFactorRequest,
  Cookie,
  CreateAbsenceCommand,
  CreateAgendaEntryCommand,
  CreateApplicationUserCommand,
  CreateClassCommand,
  CreateExamCommand,
  CreateMySchoolCommand,
  CreateSchoolCommand,
  CreateSchoolSystemCommand,
  CreateSchoolUserCommand,
  CreateTeacherCommand,
  DisableTwoFactorRequest,
  EnrolStudentCommand,
  ErrorResponse,
  ExamDto,
  ExamType,
  ExternalLinkResponse,
  ExternalLoginExchangeRequest,
  ExternalLoginResponse,
  ExternalProviderResponse,
  ForgotPasswordRequest,
  GradeDto,
  InstallPluginRequest,
  LinkExternalLoginRequest,
  LinkedAccountDto,
  LoginRequest,
  LogoutRequest,
  MicrosoftCalendarAccount,
  MicrosoftCalendarEvent,
  MicrosoftCalendarFeed,
  MySchoolDto,
  NotificationPreferencesDto,
  OdaorgStatelessAgendaEvent,
  OdaorgStatelessData,
  OdaorgStatelessExam,
  OdaorgStatelessGrade,
  OdaorgStatelessRequest,
  OdaorgStatelessUserInfo,
  PluginDto,
  PluginTaskStatus,
  ProblemDetails,
  PushResult,
  ReencryptStudentDocumentsResult,
  RefreshRequest,
  RegenerateRecoveryCodesRequest,
  RegisterDeviceTokenCommand,
  RegisterRequest,
  ResetPasswordRequest,
  Roles,
  SchoolDto,
  SchoolSystemDto,
  SchoolSystemLoginFieldDto,
  SchoolUserDto,
  SchoolUserSummaryDto,
  SemesterReportDto,
  SemesterSubjectGradeDto,
  StatelessLoginRequest,
  StatelessRefreshRequest,
  StepUpChallengeResponse,
  StepUpResponse,
  StepUpVerifyRequest,
  StudentDocumentDto,
  TeacherDto,
  TokenResponse,
  TrustedDeviceSummary,
  TwoFactorChallengeResponse,
  TwoFactorEnrolmentCompleted,
  TwoFactorEnrolmentStarted,
  TwoFactorStatus,
  UnifiedLoginRequest,
  UnlinkExternalLoginRequest,
  UpdateAbsenceCommand,
  UpdateAgendaEntryCommand,
  UpdateApplicationUserCommand,
  UpdateClassCommand,
  UpdateExamCommand,
  UpdateMyGradeCommand,
  UpdateNotificationPreferencesCommand,
  UpdateSchoolCommand,
  UpdateSchoolSystemCommand,
  UpdateSchoolUserCommand,
  UpdateTeacherCommand,
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
        const FullType(BuiltList, [FullType(SchoolDto)]),
        () => ListBuilder<SchoolDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(StudentDocumentDto)]),
        () => ListBuilder<StudentDocumentDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(TrustedDeviceSummary)]),
        () => ListBuilder<TrustedDeviceSummary>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(PluginDto)]),
        () => ListBuilder<PluginDto>(),
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
        const FullType(BuiltList, [FullType(AbsenceDto)]),
        () => ListBuilder<AbsenceDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(ApplicationUserDto)]),
        () => ListBuilder<ApplicationUserDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(ExternalProviderResponse)]),
        () => ListBuilder<ExternalProviderResponse>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(PluginTaskStatus)]),
        () => ListBuilder<PluginTaskStatus>(),
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
        const FullType(BuiltList, [FullType(ExternalLoginResponse)]),
        () => ListBuilder<ExternalLoginResponse>(),
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
