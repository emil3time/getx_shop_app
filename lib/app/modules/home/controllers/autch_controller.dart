import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:getx_shop_app/app/model/http_exeption_model.dart';
import 'package:getx_shop_app/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../data/api_keys.dart';

enum AuthMode { signup, login }

  String? token;
class AutchController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();
  Rx<AuthMode> authMode = AuthMode.login.obs;
  Map<String, String> authData = {
    'email': '',
    'password': '',
  };
  var isLoading = false.obs;
  final passwordController = TextEditingController();

  Future<void> submitUserAuthentication() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();

    isLoading.value = true;

    try {
      if (authMode.value == AuthMode.login) {
        // Log user in
        await signInWitchEmailAndPassword(
          authData['email'].toString(),
          authData['password'].toString(),
        );
      } else {
        // Sign user up
        await signUpWitchEmailAndPassword(
          authData['email'].toString(),
          authData['password'].toString(),
        );
      }
    } on HttpExeption catch (httpErrorMessage) {
      var errorMessage = 'Autentication failed';
      if (httpErrorMessage.toString().contains('EMAIL_EXISTS')) {
        errorMessage =
            'The email address is already in use by another account.';
      } else if (httpErrorMessage.message.contains('OPERATION_NOT_ALLOWED')) {
        errorMessage = ' Password sign-in is disabled for this project.';
      } else if (httpErrorMessage
          .toString()
          .contains('TOO_MANY_ATTEMPTS_TRY_LATER')) {
        errorMessage =
            ' We have blocked all requests from this device due to unusual activity. Try again later.';
      } else if (httpErrorMessage.message.contains('EMAIL_NOT_FOUND')) {
        errorMessage =
            ' There is no user record corresponding to this identifier. The user may have been deleted.';
      } else if (httpErrorMessage.message.contains('INVALID_PASSWORD')) {
        errorMessage =
            ' The password is invalid or the user does not have a password.';
      } else if (httpErrorMessage.message.contains('USER_DISABLED')) {
        errorMessage =
            ' The user account has been disabled by an administrator.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      final errorMessage = 'Autentication fail. Please try again later';
      _showErrorDialog(errorMessage);
    } finally {
      Get.offAllNamed(Routes.HOME);
    }

    isLoading.value = false;
  }

  void _showErrorDialog(String errorMessage) {
    Get.defaultDialog(
        title: 'Error',
        middleText: errorMessage,
        barrierDismissible: false,
        actions: [
          ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text('OK'))
        ]);
  }

  void switchAuthMode() {
    if (authMode.value == AuthMode.login) {
      authMode.value = AuthMode.signup;
    } else {
      authMode.value = AuthMode.login;
    }
  }

  String refreshToken = '';
  String? _userId;

  DateTime? _expiryTime;

  String?  getToken() {
    if (_expiryTime != null &&
        token != null &&
        _expiryTime!.isAfter(DateTime.now())) {
      return token;
    }
    return null;
  }

  bool get isAutch {
    return token != null;
  }

  Future<void> signUpWitchEmailAndPassword(
      String email, String password) async {
    return _postToAutenticate(email, password, 'signUp');
  }

  Future<void> signInWitchEmailAndPassword(
      String email, String password) async {
    return _postToAutenticate(email, password, 'signInWithPassword');
  }

  Future<void> _postToAutenticate(
      String email, String password, String urlChangedPart) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlChangedPart?key=$apiKey');

    try {
      final response = await http.post(url,
          body: json.encode({
            'returnSecureToken': true,
            'email': email,
            'password': password,
          }));

      final decodedResponse = json.decode(response.body);
      if (decodedResponse['error'] != null) {
        throw HttpExeption(message: decodedResponse['error']['message']);
      }
      token = decodedResponse['idToken'];
      _userId = decodedResponse['localId'];
      _expiryTime = DateTime.now().add(Duration(
        seconds: int.parse(decodedResponse['expiresIn']),
      ));
    } catch (error) {
      throw error;
    }
  }
}

    // final decodedResponse = json.decode(response.body);
    // token = decodedResponse['idToken'];
    // refreshToken = decodedResponse['refreshToken'];
    // userId = decodedResponse['localId'];
    // expiryTime = decodedResponse['expiresIn'];
    // print(decodedResponse['expiresIn']);