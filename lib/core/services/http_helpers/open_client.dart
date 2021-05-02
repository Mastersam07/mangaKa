import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as inner;

import '../../constants/app_constants.dart';
import 'custom_exception.dart';

class OpenClient {
  final Map<String, dynamic> data;

  OpenClient({this.data});

  Future<dynamic> get(String url, {String bodyContentType}) async {
    http.Response response;

    if (data != null) {
      response = await getHttpReponse(
        url,
        body: data,
        headers: {
          HttpHeaders.contentTypeHeader: bodyContentType ?? 'application/json',
        },
        method: HttpMethod.get,
      );
    }
    response = await getHttpReponse(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: bodyContentType ?? 'application/json',
      },
      method: HttpMethod.get,
    );

    if (response.headers.containsValue('json'))
      return json.decode(response.body);

    return response;
  }

  Future<dynamic> post(String url, {String bodyContentType}) async {
    //encode Map to JSON
    final body = json.encode(data);

    final response = await getHttpReponse(
      url,
      body: body,
      headers: {
        HttpHeaders.contentTypeHeader: bodyContentType ?? 'application/json',
      },
      method: HttpMethod.post,
    );

    if (response.headers.containsValue('json'))
      return json.decode(response.body);

    return response;
  }

  Future<http.Response> postEncoding(String url) async {
    final response = await getHttpReponse(
      url,
      body: data,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      method: HttpMethod.postEncoding,
    );

    if (response.headers.containsValue('json'))
      return json.decode(response.body);

    return response;
  }

  Future<http.Response> getHttpReponse(
    String url, {
    body,
    Map<String, String> headers,
    HttpMethod method = HttpMethod.get,
  }) async {
    final _client = getClient();
    http.Response response;
    try {
      switch (method) {
        case HttpMethod.post:
          response = await _client.post(
            url,
            body: body,
            headers: headers,
          );
          break;
        case HttpMethod.put:
          response = await _client.put(
            url,
            body: body,
            headers: headers,
          );
          break;
        case HttpMethod.delete:
          response = await _client.delete(
            url,
            headers: headers,
          );
          break;
        case HttpMethod.get:
          response = await _client.get(
            url,
            headers: headers,
          );
          break;
        case HttpMethod.postEncoding:
          response = await http.post(
            url,
            body: body,
            headers: headers,
            encoding: Encoding.getByName('utf-8'),
          );
      }

      print('URL: $url');
      print('Body: $body');
      print('Response Code: ' + response.statusCode.toString());
      print('Response Body: ' + response.body.toString());

      if (response.statusCode >= 400) {
        //if (response.statusCode == 404) return response.body; // Not Found Message
        if (response.statusCode == 401) {} // Not Authorized
        if (devMode)
          throw CustomException('An error occurred: ' + response.body);
      }
    } catch (e) {
      print('Error with URL: $e');
    }

    return response;
  }

  inner.IOClient getClient() {
    const trustSelfSigned = true;
    final httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    final ioClient = inner.IOClient(httpClient);
    return ioClient;
  }
}

enum HttpMethod { get, post, put, delete, postEncoding }
