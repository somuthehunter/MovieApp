import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:movie_app/core/errors/http_exception.dart';
import 'package:movie_app/core/utilities/logger.dart';

class ApiClient {
  final Dio client;

  ApiClient(this.client);

  String get baseUrl => 'https://api.themoviedb.org/3/';

  Future<dynamic> get(String endpoint,
      {Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    return _sendRequest('GET', endpoint,
        headers: headers, queryParameters: queryParameters);
  }

  Future<dynamic> post(String endpoint,
      {Map<String, String>? headers,
      dynamic body,
      Map<String, dynamic>? queryParameters}) async {
    return _sendRequest('POST', endpoint,
        headers: headers, body: body, queryParameters: queryParameters);
  }

  Future<dynamic> put(String endpoint,
      {Map<String, String>? headers,
      dynamic body,
      Map<String, dynamic>? queryParameters}) async {
    return _sendRequest('PUT', endpoint,
        headers: headers, body: body, queryParameters: queryParameters);
  }

  Future<dynamic> delete(String endpoint,
      {Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    return _sendRequest('DELETE', endpoint,
        headers: headers, queryParameters: queryParameters);
  }

  Future<dynamic> _sendRequest(String method, String endpoint,
      {Map<String, String>? headers,
      dynamic body,
      Map<String, dynamic>? queryParameters}) async {
    // If header is null then initializing the header
    // with Content-type key
    if (headers == null) {
      headers = {
        'Content-Type': 'application/json',
      };
      // If header is not null then putting the Content-type key
      // with a value 'application/json'
    } else {
      headers['Content-Type'] = 'application/json';
    }

    final fullUrl = '$baseUrl$endpoint';

    try {
      final response = await _makeRequest(method, fullUrl,
          headers: headers, body: body, queryParameters: queryParameters);
      if (response.statusCode == HttpStatus.ok) {
        Logger.info('${response.data}');
        return response.data;
      } else {
        Logger.error(response.data);
        _checkException(response);
      }
    } catch (e) {
      Logger.error(e.toString());
      rethrow;
    }
  }

  Future<Response> _makeRequest(String method, String url,
      {Map<String, String>? headers,
      Map<String, dynamic>? queryParameters,
      dynamic body}) {
    Logger.info('TYPE: $method URL:$url\n HEADERS: $headers \n BODY: $body');
    switch (method) {
      case 'GET':
        return client.get(url,
            queryParameters: queryParameters,
            options: Options(headers: headers));
      case 'POST':
        return client.post(url,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            data: json.encode(body));
      case 'PUT':
        return client.put(url,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            data: json.encode(body));
      case 'DELETE':
        return client.delete(url,
            queryParameters: queryParameters,
            options: Options(headers: headers));
      default:
        throw UnsupportedError('Unsupported HTTP method: $method');
    }
  }

  void _checkException(Response response) {
    Map<String, dynamic> errorResponse = jsonDecode(response.data);
    final message = errorResponse['message'];
    final code = errorResponse['status'];
    switch (response.statusCode) {
      case 400:
        throw HttpBadRequest(message: message, errorCode: code.toString());
      case 401:
        throw HttpUnauthorized(message: message, errorCode: code.toString());
      case 404:
        throw HttpNotFound(message: message, errorCode: code.toString());
      default:
        throw HttpRequestFailure(
            message: message,
            errorCode: response.statusCode.toString(),
            code: response.statusCode.toString());
    }
  }
}
