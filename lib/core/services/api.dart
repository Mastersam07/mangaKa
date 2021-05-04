import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/// The service responsible for networking requests
class Api {
  bool isProd;
  String baseURL;

  Api() {
    if (env['DEBUG'] != 'true') {
      isProd = true;
    } else {
      isProd = false;
    }

    if (isProd) {
      baseURL = env['API_BASE_URL_PROD'];
    } else {
      baseURL = env['API_BASE_URL_DEV'];
    }
  }

  var client = http.Client();
}
