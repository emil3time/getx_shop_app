import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:getx_shop_app/app/infrastructure/fb_services/auth/auth.dart';
import 'package:getx_shop_app/app/model/http_exeption_model.dart';
import 'package:getx_shop_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

enum AuthMode { signup, login }

Map<String, dynamic> authResponse = {};

class AutchController extends GetxController {
  var auth = Auth();

  final GlobalKey<FormState> formKey = GlobalKey();

  final passwordController = TextEditingController();

  Rx<AuthMode> authMode = AuthMode.login.obs;

  Map<String, String> authData = {
    'email': '',
    'password': '',
  };

  var isLoading = false.obs;

  Future<void> submitUserAuthentication() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();

    isLoading.value = true;

    try {
      if (authMode.value == AuthMode.login) {
        // Log user in
        auth.createUrlForAuth('signInWithPassword');
        authResponse =
            await auth.autenticate(authData['email']!, authData['password']!);
      } else {
        // Sign user up
        auth.createUrlForAuth('signUp');
        authResponse =
            await auth.autenticate(authData['email']!, authData['password']!);
      }
    } on HttpExeption catch (httpErrorMessage) {
      var errorMessage = 'Autentication failed';

      if (httpErrorHandling(httpErrorMessage) != null) {
        errorMessage = httpErrorHandling(httpErrorMessage)!;
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

  String? httpErrorHandling(HttpExeption httpErrorMessage) {
    if (httpErrorMessage.toString().contains('EMAIL_EXISTS')) {
      return 'The email address is already in use by another account.';
    } else if (httpErrorMessage.message.contains('OPERATION_NOT_ALLOWED')) {
      return ' Password sign-in is disabled for this project.';
    } else if (httpErrorMessage
        .toString()
        .contains('TOO_MANY_ATTEMPTS_TRY_LATER')) {
      return ' We have blocked all requests from this device due to unusual activity. Try again later.';
    } else if (httpErrorMessage.message.contains('EMAIL_NOT_FOUND')) {
      return ' There is no user record corresponding to this identifier. The user may have been deleted.';
    } else if (httpErrorMessage.message.contains('INVALID_PASSWORD')) {
      return ' The password is invalid or the user does not have a password.';
    } else if (httpErrorMessage.message.contains('USER_DISABLED')) {
      return ' The user account has been disabled by an administrator.';
    } else {
      return null;
    }
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


  DateTime? _expiryTime;

  String? getToken() {
    if (_expiryTime != null &&
        authResponse['idToken'] != null &&
        _expiryTime!.isAfter(DateTime.now())) {
      return authResponse['idToken'];
    }
    return null;
  }

  bool get isAutch {
    return authResponse['idToken'] != null;
  }

/*    token = decodedResponse['idToken'];
    _userId = decodedResponse['localId'];
    _expiryTime = DateTime.now().add(Duration(
        seconds: int.parse(decodedResponse['expiresIn']),
      ));
 */

}

    // final decodedResponse = json.decode(response.body);
    // token = decodedResponse['idToken'];
    // refreshToken = decodedResponse['refreshToken'];
    // userId = decodedResponse['localId'];
    // expiryTime = decodedResponse['expiresIn'];
    // print(decodedResponse['expiresIn']);