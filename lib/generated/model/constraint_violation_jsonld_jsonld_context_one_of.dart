//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ConstraintViolationJsonldJsonldContextOneOf {
  /// Returns a new [ConstraintViolationJsonldJsonldContextOneOf] instance.
  ConstraintViolationJsonldJsonldContextOneOf({
    required this.atVocab,
    required this.hydra,
  });

  String atVocab;

  ConstraintViolationJsonldJsonldContextOneOfHydraEnum hydra;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ConstraintViolationJsonldJsonldContextOneOf &&
    other.atVocab == atVocab &&
    other.hydra == hydra;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (atVocab.hashCode) +
    (hydra.hashCode);

  @override
  String toString() => 'ConstraintViolationJsonldJsonldContextOneOf[atVocab=$atVocab, hydra=$hydra]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'@vocab'] = this.atVocab;
      json[r'hydra'] = this.hydra;
    return json;
  }

  /// Returns a new [ConstraintViolationJsonldJsonldContextOneOf] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ConstraintViolationJsonldJsonldContextOneOf? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ConstraintViolationJsonldJsonldContextOneOf[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ConstraintViolationJsonldJsonldContextOneOf[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ConstraintViolationJsonldJsonldContextOneOf(
        atVocab: mapValueOfType<String>(json, r'@vocab')!,
        hydra: ConstraintViolationJsonldJsonldContextOneOfHydraEnum.fromJson(json[r'hydra'])!,
      );
    }
    return null;
  }

  static List<ConstraintViolationJsonldJsonldContextOneOf> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ConstraintViolationJsonldJsonldContextOneOf>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ConstraintViolationJsonldJsonldContextOneOf.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ConstraintViolationJsonldJsonldContextOneOf> mapFromJson(dynamic json) {
    final map = <String, ConstraintViolationJsonldJsonldContextOneOf>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ConstraintViolationJsonldJsonldContextOneOf.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ConstraintViolationJsonldJsonldContextOneOf-objects as value to a dart map
  static Map<String, List<ConstraintViolationJsonldJsonldContextOneOf>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ConstraintViolationJsonldJsonldContextOneOf>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ConstraintViolationJsonldJsonldContextOneOf.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    '@vocab',
    'hydra',
  };
}


class ConstraintViolationJsonldJsonldContextOneOfHydraEnum {
  /// Instantiate a new enum with the provided [value].
  const ConstraintViolationJsonldJsonldContextOneOfHydraEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const httpColonSlashSlashWwwPeriodW3PeriodOrgSlashNsSlashHydraSlashCoreHash = ConstraintViolationJsonldJsonldContextOneOfHydraEnum._(r'http://www.w3.org/ns/hydra/core#');

  /// List of all possible values in this [enum][ConstraintViolationJsonldJsonldContextOneOfHydraEnum].
  static const values = <ConstraintViolationJsonldJsonldContextOneOfHydraEnum>[
    httpColonSlashSlashWwwPeriodW3PeriodOrgSlashNsSlashHydraSlashCoreHash,
  ];

  static ConstraintViolationJsonldJsonldContextOneOfHydraEnum? fromJson(dynamic value) => ConstraintViolationJsonldJsonldContextOneOfHydraEnumTypeTransformer().decode(value);

  static List<ConstraintViolationJsonldJsonldContextOneOfHydraEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ConstraintViolationJsonldJsonldContextOneOfHydraEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ConstraintViolationJsonldJsonldContextOneOfHydraEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ConstraintViolationJsonldJsonldContextOneOfHydraEnum] to String,
/// and [decode] dynamic data back to [ConstraintViolationJsonldJsonldContextOneOfHydraEnum].
class ConstraintViolationJsonldJsonldContextOneOfHydraEnumTypeTransformer {
  factory ConstraintViolationJsonldJsonldContextOneOfHydraEnumTypeTransformer() => _instance ??= const ConstraintViolationJsonldJsonldContextOneOfHydraEnumTypeTransformer._();

  const ConstraintViolationJsonldJsonldContextOneOfHydraEnumTypeTransformer._();

  String encode(ConstraintViolationJsonldJsonldContextOneOfHydraEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a ConstraintViolationJsonldJsonldContextOneOfHydraEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ConstraintViolationJsonldJsonldContextOneOfHydraEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'http://www.w3.org/ns/hydra/core#': return ConstraintViolationJsonldJsonldContextOneOfHydraEnum.httpColonSlashSlashWwwPeriodW3PeriodOrgSlashNsSlashHydraSlashCoreHash;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ConstraintViolationJsonldJsonldContextOneOfHydraEnumTypeTransformer] instance.
  static ConstraintViolationJsonldJsonldContextOneOfHydraEnumTypeTransformer? _instance;
}


