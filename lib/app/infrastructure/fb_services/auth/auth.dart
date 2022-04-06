import 'dart:convert';

import '../../../data/api_keys.dart';
import '../../../model/http_exeption_model.dart';
import 'package:http/http.dart' as http;

class Auth {
  Uri? url;
  void createUrlForAuth(String urlChangedPart) {
    url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlChangedPart?key=$apiKey');
  }

  Future<Map<String, dynamic>> autenticate(
      String email, String password) async {
    try {

      final jsonResponse = await http.post(url!,
          body: json.encode({
            'returnSecureToken': true,
            'email': email,
            'password': password,
          }));

      Map<String, dynamic> decodedResponse = json.decode(jsonResponse.body);
      if (decodedResponse['error'] != null) {
        throw HttpExeption(message: decodedResponse['error']['message']);
      }
      return decodedResponse;
    } catch (error) {
      throw error;
    }
  }
}
