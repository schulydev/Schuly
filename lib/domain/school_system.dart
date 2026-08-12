class SchoolSystem {
  final String key;
  final String displayName;
  final String? logoUrl;

  final String? privateAuthStrategy;

  final String? statelessBasePath;

  /// Base path of this system's plugin endpoints (account mode:
  /// accounts/sync/status), e.g. `/api/plugins/<plugin>`. Served by the
  /// catalog because the system key differs from the plugin name.
  final String? pluginBasePath;

  final String loginMethod;
  final bool enabled;
  final int sortOrder;
  final List<SchoolSystemLoginField> loginFields;

  const SchoolSystem({
    required this.key,
    required this.displayName,
    required this.loginMethod,
    this.logoUrl,
    this.privateAuthStrategy,
    this.statelessBasePath,
    this.pluginBasePath,
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
      privateAuthStrategy: json['privateAuthStrategy'] as String?,
      statelessBasePath: json['statelessBasePath'] as String?,
      pluginBasePath: json['pluginBasePath'] as String?,
      loginMethod: json['loginMethod'] as String? ?? 'oauth-webview',
      enabled: json['enabled'] as bool? ?? true,
      sortOrder: json['sortOrder'] as int? ?? 0,
      loginFields: fields,
    );
  }
}

class SchoolSystemLoginField {
  final String key;
  final String label;

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
