import 'package:schuly_api/schuly_api.dart';

import '../config/oidc_config.dart';

class MySchool {
  final String id;
  final String name;
  final String? email;
  final String? fullName;
  final String provider;
  final String? pluginBasePath;
  final String? pluginAccountId;
  final String? logoUrl;
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
        logoUrl: OidcConfig.resolveUrl(dto.logoUrl),
        profilePictureUrl: OidcConfig.resolveUrl(dto.profilePictureUrl),
      );
}
