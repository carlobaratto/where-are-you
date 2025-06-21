//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ConstraintViolationJson {
  /// Returns a new [ConstraintViolationJson] instance.
  ConstraintViolationJson({
    this.status = 422,
    this.violations = const [],
    this.detail,
    this.type,
    this.title,
    this.instance,
  });

  int status;

  List<ConstraintViolationJsonViolationsInner> violations;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? detail;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? type;

  String? title;

  String? instance;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ConstraintViolationJson &&
    other.status == status &&
    _deepEquality.equals(other.violations, violations) &&
    other.detail == detail &&
    other.type == type &&
    other.title == title &&
    other.instance == instance;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (status.hashCode) +
    (violations.hashCode) +
    (detail == null ? 0 : detail!.hashCode) +
    (type == null ? 0 : type!.hashCode) +
    (title == null ? 0 : title!.hashCode) +
    (instance == null ? 0 : instance!.hashCode);

  @override
  String toString() => 'ConstraintViolationJson[status=$status, violations=$violations, detail=$detail, type=$type, title=$title, instance=$instance]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'status'] = this.status;
      json[r'violations'] = this.violations;
    if (this.detail != null) {
      json[r'detail'] = this.detail;
    } else {
      json[r'detail'] = null;
    }
    if (this.type != null) {
      json[r'type'] = this.type;
    } else {
      json[r'type'] = null;
    }
    if (this.title != null) {
      json[r'title'] = this.title;
    } else {
      json[r'title'] = null;
    }
    if (this.instance != null) {
      json[r'instance'] = this.instance;
    } else {
      json[r'instance'] = null;
    }
    return json;
  }

  /// Returns a new [ConstraintViolationJson] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ConstraintViolationJson? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ConstraintViolationJson[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ConstraintViolationJson[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ConstraintViolationJson(
        status: mapValueOfType<int>(json, r'status') ?? 422,
        violations: ConstraintViolationJsonViolationsInner.listFromJson(json[r'violations']),
        detail: mapValueOfType<String>(json, r'detail'),
        type: mapValueOfType<String>(json, r'type'),
        title: mapValueOfType<String>(json, r'title'),
        instance: mapValueOfType<String>(json, r'instance'),
      );
    }
    return null;
  }

  static List<ConstraintViolationJson> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ConstraintViolationJson>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ConstraintViolationJson.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ConstraintViolationJson> mapFromJson(dynamic json) {
    final map = <String, ConstraintViolationJson>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ConstraintViolationJson.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ConstraintViolationJson-objects as value to a dart map
  static Map<String, List<ConstraintViolationJson>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ConstraintViolationJson>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ConstraintViolationJson.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

