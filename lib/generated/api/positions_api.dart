//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class PositionsApi {
  PositionsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Retrieves a Positions resource.
  ///
  /// Retrieves a Positions resource.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] groupName (required):
  ///   Positions identifier
  Future<Response> apiPositionsGroupNameGetWithHttpInfo(String groupName,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/positions/{group_name}'
      .replaceAll('{group_name}', groupName);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Retrieves a Positions resource.
  ///
  /// Retrieves a Positions resource.
  ///
  /// Parameters:
  ///
  /// * [String] groupName (required):
  ///   Positions identifier
  Future<PositionsJsonld?> apiPositionsGroupNameGet(String groupName,) async {
    final response = await apiPositionsGroupNameGetWithHttpInfo(groupName,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PositionsJsonld',) as PositionsJsonld;
    
    }
    return null;
  }
}
