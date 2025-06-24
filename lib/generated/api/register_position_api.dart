//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class RegisterPositionApi {
  RegisterPositionApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Creates a RegisterPosition resource.
  ///
  /// Creates a RegisterPosition resource.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] groupName (required):
  ///   RegisterPosition identifier
  ///
  /// * [RegisterPositionJsonld] registerPositionJsonld (required):
  ///   The new RegisterPosition resource
  Future<Response> apiPositionsregisterGroupNamePostWithHttpInfo(String groupName, RegisterPositionJsonld registerPositionJsonld,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/positions/register/{group_name}'
      .replaceAll('{group_name}', groupName);

    // ignore: prefer_final_locals
    Object? postBody = registerPositionJsonld;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/ld+json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Creates a RegisterPosition resource.
  ///
  /// Creates a RegisterPosition resource.
  ///
  /// Parameters:
  ///
  /// * [String] groupName (required):
  ///   RegisterPosition identifier
  ///
  /// * [RegisterPositionJsonld] registerPositionJsonld (required):
  ///   The new RegisterPosition resource
  Future<RegisterPositionJsonld?> apiPositionsregisterGroupNamePost(String groupName, RegisterPositionJsonld registerPositionJsonld,) async {
    final response = await apiPositionsregisterGroupNamePostWithHttpInfo(groupName, registerPositionJsonld,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'RegisterPositionJsonld',) as RegisterPositionJsonld;
    
    }
    return null;
  }
}
