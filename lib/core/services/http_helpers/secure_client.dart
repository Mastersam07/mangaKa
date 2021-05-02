import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as inner;

import '../../constants/app_constants.dart';
import 'custom_exception.dart';

class SecureClient {
  SecureClient(this.token);

  String token;

  Future<http.Response> post(String url, Map data,
      {String bodyContentType}) async {
//    if (data == null) throw ('Asset is Required');
    final _token = token ?? '';
    //encode Map to JSON
    final body = json.encode(data);
    final response = await getHttpReponse(
      url,
      body: body,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        'content-type': 'application/json'
      },
      method: HttpMethod.post,
    );

    if (response.headers.containsValue('json'))
      return json.decode(response.body);

    return response;
  }

  Future<http.Response> put(String url, Map data,
      {String bodyContentType}) async {
//    if (data == null) throw ('Asset is Required');
    final _token = token ?? '';
    //encode Map to JSON
    final body = json.encode(data);
    final response = await getHttpReponse(
      url,
      body: body,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        'content-type': 'application/json'
      },
      method: HttpMethod.put,
    );

    if (response.headers.containsValue('json'))
      return json.decode(response.body);

    return response;
  }

  Future<http.Response> delete(String url, Map data,
      {String bodyContentType}) async {
//    if (data == null) throw ('Asset is Required');
    final _token = token ?? '';
    //encode Map to JSON
    final body = json.encode(data);
    final response = await getHttpReponse(
      url,
      body: body,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        'content-type': 'application/json'
      },
      method: HttpMethod.delete,
    );

    if (response.headers.containsValue('json'))
      return json.decode(response.body);

    return response;
  }

  Future<http.Response> get(String url, {Map data}) async {
    http.Response response;
    if (token == null) throw CustomException('Token is Required');
    final _token = token ?? '';
    if (data != null) {
      response = await getHttpReponse(
        url,
        body: data,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $_token',
          'content-type': 'application/json'
        },
        method: HttpMethod.get,
      );
    }
    response = await getHttpReponse(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        'content-type': 'application/json'
      },
      method: HttpMethod.get,
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
      }

      print('URL: $url');
      print('Body: $body');
      print('Response Code: ' + response.statusCode.toString());
      print('Response Body: ' + response.body.toString());

      if (response.statusCode >= 400) {
        // if (response.statusCode == 404) return response.body; // Not Found Message
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

  ///can be used for file upload to the server
  Future<http.Response> multiPartRequest(
      String url, String field, fileName, Map<String, String> data) async {
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(
      {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'content-type': 'application/json'
      },
    );
    request.files.add(await http.MultipartFile.fromPath(field, fileName));
    request.fields.addAll(data);

    final _data = await request.send();
    final response = await http.Response.fromStream(_data);

    /*if(response.statusCode != 200){
      return null;
    }*/
    print('URL: $url');
    print('status code from multipath: ${response.statusCode}');
    print('Response from multipath: ${response.body}');
    print('Response from multipath ----: $response');
    return response;
  }

  ///can be used to upload FIle Array to the server
  Future<http.Response> multiPartRequestArray(
      {String url,
      formThreeDocument,
      billOfLading,
      Map<String, String> data}) async {
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(
      {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'content-type': 'application/json'
      },
    );
    final fileArray = [
      await http.MultipartFile.fromPath('Document', billOfLading),
      await http.MultipartFile.fromPath('Document', formThreeDocument)
    ];
    request.files.addAll(fileArray);
    request.fields.addAll(data);

    final _data = await request.send();
    final response = await http.Response.fromStream(_data);

    /*if(response.statusCode != 200){
      return null;
    }*/
    print('URL: $url');
    print('status code from multipath: ${response.statusCode}');
    print('Response from multipath: ${response.body}');
    print('Response from multipath ----: $response');
    return response;
  }
}

enum HttpMethod { get, post, put, delete }
