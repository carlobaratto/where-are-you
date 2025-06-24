//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ErrorJsonld {
  /// Returns a new [ErrorJsonld] instance.
  ErrorJsonld({
    this.atContext,
    this.atId,
    this.atType,
    this.title,
    this.detail,
    this.status = 400,
    this.instance,
    this.type,
    this.description,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ConstraintViolationJsonldJsonldContext? atContext;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? atId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? atType;

  /// A short, human-readable summary of the problem.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? title;

  /// A human-readable explanation specific to this occurrence of the problem.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? detail;

  num status;

  /// A URI reference that identifies the specific occurrence of the problem. It may or may not yield further information if dereferenced.
  String? instance;

  /// A URI reference that identifies the problem type
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? type;

  String? description;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ErrorJsonld &&
    other.atContext == atContext &&
    other.atId == atId &&
    other.atType == atType &&
    other.title == title &&
    other.detail == detail &&
    other.status == status &&
    other.instance == instance &&
    other.type == type &&
    other.description == description;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (atContext == null ? 0 : atContext!.hashCode) +
    (atId == null ? 0 : atId!.hashCode) +
    (atType == null ? 0 : atType!.hashCode) +
    (title == null ? 0 : title!.hashCode) +
    (detail == null ? 0 : detail!.hashCode) +
    (status.hashCode) +
    (instance == null ? 0 : instance!.hashCode) +
    (type == null ? 0 : type!.hashCode) +
    (description == null ? 0 : description!.hashCode);

  @override
  String toString() => 'ErrorJsonld[atContext=$atContext, atId=$atId, atType=$atType, title=$title, detail=$detail, status=$status, instance=$instance, type=$type, description=$description]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.atContext != null) {
      json[r'@context'] = this.atContext;
    } else {
      json[r'@context'] = null;
    }
    if (this.atId != null) {
      json[r'@id'] = this.atId;
    } else {
      json[r'@id'] = null;
    }
    if (this.atType != null) {
      json[r'@type'] = this.atType;
    } else {
      json[r'@type'] = null;
    }
    if (this.title != null) {
      json[r'title'] = this.title;
    } else {
      json[r'title'] = null;
    }
    if (this.detail != null) {
      json[r'detail'] = this.detail;
    } else {
      json[r'detail'] = null;
    }
      json[r'status'] = this.status;
    if (this.instance != null) {
      json[r'instance'] = this.instance;
    } else {
      json[r'instance'] = null;
    }
    if (this.type != null) {
      json[r'type'] = this.type;
    } else {
      json[r'type'] = null;
    }
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    return json;
  }

  /// Returns a new [ErrorJsonld] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ErrorJsonld? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ErrorJsonld[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ErrorJsonld[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ErrorJsonld(
        atContext: ConstraintViolationJsonldJsonldContext.fromJson(json[r'@context']),
        atId: mapValueOfType<String>(json, r'@id'),
        atType: mapValueOfType<String>(json, r'@type'),
        title: mapValueOfType<String>(json, r'title'),
        detail: mapValueOfType<String>(json, r'detail'),
        status: num.parse('${json[r'status']}'),
        instance: mapValueOfType<String>(json, r'instance'),
        type: mapValueOfType<String>(json, r'type'),
        description: mapValueOfType<String>(json, r'description'),
      );
    }
    return null;
  }

  static List<ErrorJsonld> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ErrorJsonld>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ErrorJsonld.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ErrorJsonld> mapFromJson(dynamic json) {
    final map = <String, ErrorJsonld>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ErrorJsonld.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ErrorJsonld-objects as value to a dart map
  static Map<String, List<ErrorJsonld>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ErrorJsonld>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ErrorJsonld.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

