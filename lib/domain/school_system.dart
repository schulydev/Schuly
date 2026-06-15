/// A login provider the backend advertises via `GET /api/app/school-systems`.
/// The app renders the picker (and, later, the login form) from this instead of
/// hardcoding the available systems.
class SchoolSystem {
  final String key;
  final String displayName;
  final String? logoUrl;
  final String? schulwareApiBaseUrl;

  /// How the app drives the login: `oauth-webview` or `credentials`.
  final String loginMethod;
  final bool enabled;
  final int sortOrder;
  final List<SchoolSystemLoginField> loginFields;

  const SchoolSystem({
    required this.key,
    required this.displayName,
    required this.loginMethod,
    this.logoUrl,
    this.schulwareApiBaseUrl,
    this.enabled = true,
    this.sortOrder = 0,
    this.loginFields = const [],
  });

  factory SchoolSystem.fromJson(Map<String, dynamic> json) {
    final fields = (json['loginFields'] as List<dynamic>? ?? [])
        .map((e) => SchoolSystemLoginField.fromJson(e as Map<String, dynamic>))
        .toList();
    return SchoolSystem(
      key: json['key'] as String,
      displayName: json['displayName'] as String,
      logoUrl: json['logoUrl'] as String?,
      schulwareApiBaseUrl: json['schulwareApiBaseUrl'] as String?,
      loginMethod: json['loginMethod'] as String? ?? 'oauth-webview',
      enabled: json['enabled'] as bool? ?? true,
      sortOrder: json['sortOrder'] as int? ?? 0,
      loginFields: fields,
    );
  }
}

/// One input the app renders on a system's login form.
class SchoolSystemLoginField {
  final String key;
  final String label;

  /// Input hint: `url`, `text` or `password`.
  final String type;
  final String? placeholder;
  final String? defaultValue;
  final bool required;

  const SchoolSystemLoginField({
    required this.key,
    required this.label,
    required this.type,
    this.placeholder,
    this.defaultValue,
    this.required = true,
  });

  factory SchoolSystemLoginField.fromJson(Map<String, dynamic> json) {
    return SchoolSystemLoginField(
      key: json['key'] as String,
      label: json['label'] as String,
      type: json['type'] as String? ?? 'text',
      placeholder: json['placeholder'] as String?,
      defaultValue: json['defaultValue'] as String?,
      required: json['required'] as bool? ?? true,
    );
  }
}
