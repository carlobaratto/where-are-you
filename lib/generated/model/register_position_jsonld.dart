//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RegisterPositionJsonld {
  /// Returns a new [RegisterPositionJsonld] instance.
  RegisterPositionJsonld({
    this.atContext,
    this.atId,
    this.atType,
    this.position,
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

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  RegisterPositionElementJsonld? position;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RegisterPositionJsonld &&
    other.atContext == atContext &&
    other.atId == atId &&
    other.atType == atType &&
    other.position == position;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (atContext == null ? 0 : atContext!.hashCode) +
    (atId == null ? 0 : atId!.hashCode) +
    (atType == null ? 0 : atType!.hashCode) +
    (position == null ? 0 : position!.hashCode);

  @override
  String toString() => 'RegisterPositionJsonld[atContext=$atContext, atId=$atId, atType=$atType, position=$position]';

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
    if (this.position != null) {
      json[r'position'] = this.position;
    } else {
      json[r'position'] = null;
    }
    return json;
  }

  /// Returns a new [RegisterPositionJsonld] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RegisterPositionJsonld? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "RegisterPositionJsonld[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "RegisterPositionJsonld[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return RegisterPositionJsonld(
        atContext: ConstraintViolationJsonldJsonldContext.fromJson(json[r'@context']),
        atId: mapValueOfType<String>(json, r'@id'),
        atType: mapValueOfType<String>(json, r'@type'),
        position: RegisterPositionElementJsonld.fromJson(json[r'position']),
      );
    }
    return null;
  }

  static List<RegisterPositionJsonld> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <RegisterPositionJsonld>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RegisterPositionJsonld.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RegisterPositionJsonld> mapFromJson(dynamic json) {
    final map = <String, RegisterPositionJsonld>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RegisterPositionJsonld.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RegisterPositionJsonld-objects as value to a dart map
  static Map<String, List<RegisterPositionJsonld>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<RegisterPositionJsonld>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = RegisterPositionJsonld.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

