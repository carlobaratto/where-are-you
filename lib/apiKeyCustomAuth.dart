// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars
import 'generated/api.dart';

class ApiKeyCustomAuth implements Authentication {
  String apiToken;

  ApiKeyCustomAuth({
    required this.apiToken
  });

  @override
  Future<void> applyToParams(List<QueryParam> queryParams, Map<String, String> headerParams,) async {
    if (apiToken.isNotEmpty) {
      headerParams['X-AUTH-TOKEN'] = apiToken;
    }
  }
}
