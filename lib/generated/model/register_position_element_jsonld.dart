//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RegisterPositionElementJsonld {
  /// Returns a new [RegisterPositionElementJsonld] instance.
  RegisterPositionElementJsonld({
    this.atContext,
    this.atId,
    this.atType,
    this.name = '',
    this.lat = '',
    this.lon = '',
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

  String name;

  String lat;

  String lon;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RegisterPositionElementJsonld &&
    other.atContext == atContext &&
    other.atId == atId &&
    other.atType == atType &&
    other.name == name &&
    other.lat == lat &&
    other.lon == lon;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (atContext == null ? 0 : atContext!.hashCode) +
    (atId == null ? 0 : atId!.hashCode) +
    (atType == null ? 0 : atType!.hashCode) +
    (name.hashCode) +
    (lat.hashCode) +
    (lon.hashCode);

  @override
  String toString() => 'RegisterPositionElementJsonld[atContext=$atContext, atId=$atId, atType=$atType, name=$name, lat=$lat, lon=$lon]';

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
      json[r'name'] = this.name;
      json[r'lat'] = this.lat;
      json[r'lon'] = this.lon;
    return json;
  }

  /// Returns a new [RegisterPositionElementJsonld] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RegisterPositionElementJsonld? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "RegisterPositionElementJsonld[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "RegisterPositionElementJsonld[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return RegisterPositionElementJsonld(
        atContext: ConstraintViolationJsonldJsonldContext.fromJson(json[r'@context']),
        atId: mapValueOfType<String>(json, r'@id'),
        atType: mapValueOfType<String>(json, r'@type'),
        name: mapValueOfType<String>(json, r'name') ?? '',
        lat: mapValueOfType<String>(json, r'lat') ?? '',
        lon: mapValueOfType<String>(json, r'lon') ?? '',
      );
    }
    return null;
  }

  static List<RegisterPositionElementJsonld> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <RegisterPositionElementJsonld>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RegisterPositionElementJsonld.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RegisterPositionElementJsonld> mapFromJson(dynamic json) {
    final map = <String, RegisterPositionElementJsonld>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RegisterPositionElementJsonld.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RegisterPositionElementJsonld-objects as value to a dart map
  static Map<String, List<RegisterPositionElementJsonld>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<RegisterPositionElementJsonld>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = RegisterPositionElementJsonld.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

