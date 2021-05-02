import 'package:http/http.dart' as http;

import 'api.dart';
import 'http_helpers/open_client.dart';

class Service {
  static final _config = Api();
  String baseURL = _config.baseURL;

  ///signup
  Future<http.Response> register(
      {Map<String, dynamic> registrationData}) async {
    final _data = await OpenClient(data: registrationData)
        .post(_config.baseURL + 'auth/signup');
    print('Message from Registration: $_data');
    return _data;
  }

  ///login
  Future<http.Response> login({Map<String, String> loginData}) async {
    final _data =
        await OpenClient(data: loginData).post(_config.baseURL + 'auth/login');
    print('Message from login: $_data');
    return _data;
  }

  ///forgot password
  Future<http.Response> forgotPassword({Map<String, String> data}) async {
    final _data =
        await OpenClient(data: data).post(_config.baseURL + 'auth/recover');
    print('Message from forgot password: $_data');
    return _data;
  }
}
