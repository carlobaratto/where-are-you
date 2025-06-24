//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PositionRecordResponseJsonld {
  /// Returns a new [PositionRecordResponseJsonld] instance.
  PositionRecordResponseJsonld({
    this.atContext,
    this.atId,
    this.atType,
    this.group = '',
    this.name = '',
    this.datetime = '',
    this.lat = '',
    this.lon = '',
    this.minutes = 0,
    this.color = '',
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

  String group;

  String name;

  String datetime;

  String lat;

  String lon;

  int minutes;

  String color;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PositionRecordResponseJsonld &&
    other.atContext == atContext &&
    other.atId == atId &&
    other.atType == atType &&
    other.group == group &&
    other.name == name &&
    other.datetime == datetime &&
    other.lat == lat &&
    other.lon == lon &&
    other.minutes == minutes &&
    other.color == color;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (atContext == null ? 0 : atContext!.hashCode) +
    (atId == null ? 0 : atId!.hashCode) +
    (atType == null ? 0 : atType!.hashCode) +
    (group.hashCode) +
    (name.hashCode) +
    (datetime.hashCode) +
    (lat.hashCode) +
    (lon.hashCode) +
    (minutes.hashCode) +
    (color.hashCode);

  @override
  String toString() => 'PositionRecordResponseJsonld[atContext=$atContext, atId=$atId, atType=$atType, group=$group, name=$name, datetime=$datetime, lat=$lat, lon=$lon, minutes=$minutes, color=$color]';

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
      json[r'group'] = this.group;
      json[r'name'] = this.name;
      json[r'datetime'] = this.datetime;
      json[r'lat'] = this.lat;
      json[r'lon'] = this.lon;
      json[r'minutes'] = this.minutes;
      json[r'color'] = this.color;
    return json;
  }

  /// Returns a new [PositionRecordResponseJsonld] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PositionRecordResponseJsonld? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PositionRecordResponseJsonld[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PositionRecordResponseJsonld[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PositionRecordResponseJsonld(
        atContext: ConstraintViolationJsonldJsonldContext.fromJson(json[r'@context']),
        atId: mapValueOfType<String>(json, r'@id'),
        atType: mapValueOfType<String>(json, r'@type'),
        group: mapValueOfType<String>(json, r'group') ?? '',
        name: mapValueOfType<String>(json, r'name') ?? '',
        datetime: mapValueOfType<String>(json, r'datetime') ?? '',
        lat: mapValueOfType<String>(json, r'lat') ?? '',
        lon: mapValueOfType<String>(json, r'lon') ?? '',
        minutes: mapValueOfType<int>(json, r'minutes') ?? 0,
        color: mapValueOfType<String>(json, r'color') ?? '',
      );
    }
    return null;
  }

  static List<PositionRecordResponseJsonld> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PositionRecordResponseJsonld>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PositionRecordResponseJsonld.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PositionRecordResponseJsonld> mapFromJson(dynamic json) {
    final map = <String, PositionRecordResponseJsonld>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PositionRecordResponseJsonld.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PositionRecordResponseJsonld-objects as value to a dart map
  static Map<String, List<PositionRecordResponseJsonld>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PositionRecordResponseJsonld>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PositionRecordResponseJsonld.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

