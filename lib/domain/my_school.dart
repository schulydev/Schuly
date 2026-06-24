import 'package:schuly_api/schuly_api.dart';

import '../config/oidc_config.dart';

/// A school the signed-in user belongs to, from `GET /api/schools/my-schools`.
/// Carries the school name plus the user's identity (full name + email) at
/// that school - what the account switcher displays. [provider] is the catalog
/// system key, and [pluginBasePath] its plugin route - both discovered from the
/// backend catalog, never hardcoded.
class MySchool {
  final String id;
  final String name;
  final String? email;
  final String? fullName;
  final String provider;
  /// Catalog plugin base path backing this school (accounts/sync/status).
  final String? pluginBasePath;
  /// The plugin account id backing this school (for triggering a sync).
  final String? pluginAccountId;
  /// Backend-supplied, fully-resolved URLs (null if not provided).
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
