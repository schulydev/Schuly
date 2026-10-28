import 'package:schuly_api/schuly_api.dart';

import '../config/backend_config.dart';

class MySchool {
  final String id;
  final String name;
  final String? email;
  final String? fullName;
  final String provider;
  final String? pluginBasePath;
  final String? pluginAccountId;
  final String? logoUrl;
  final String? schoolSystemKey;
  final String? profilePictureUrl;

  const MySchool({
    required this.id,
    required this.name,
    this.email,
    this.fullName,
    this.provider = '',
    this.pluginBasePath,
    this.pluginAccountId,
    this.logoUrl,
    this.schoolSystemKey,
    this.profilePictureUrl,
  });

  factory MySchool.fromDto(
    MySchoolDto dto, {
    String provider = '',
    String? pluginBasePath,
    String? pluginAccountId,
  }) =>
      MySchool(
        id: dto.id ?? '',
        name: dto.name.isNotEmpty ? dto.name : 'School',
        email: dto.email,
        fullName: dto.fullName,
        provider: provider,
        pluginBasePath: pluginBasePath,
        pluginAccountId: pluginAccountId,
        logoUrl: BackendConfig.resolveUrl(dto.logoUrl),
        schoolSystemKey: dto.schoolSystemKey,
        profilePictureUrl: BackendConfig.resolveUrl(dto.profilePictureUrl),
      );
}
