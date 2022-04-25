import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:async';
import 'package:getx_shop_app/app/infrastructure/fb_services/auth/auth.dart';
import 'package:getx_shop_app/app/model/http_exeption_model.dart';
import 'package:getx_shop_app/app/modules/home/views/auth_screen.dart';
import 'package:getx_shop_app/app/routes/app_pages.dart';

enum AuthMode { signup, login }

Map<String, dynamic> authResponse = {};
GetStorage? box;

class AutchController extends GetxController {
  var auth = Auth();
  Timer? _existingTimer;

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

      _timerLogout();
      _saveCredentials(box!);
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

  // String? getToken() {
  //   if (_expiryTime != null &&
  //       authResponse['idToken'] != null &&
  //       _expiryTime!.isAfter(DateTime.now())) {
  //     return authResponse['idToken'];
  //   }
  //   return null;
  // }

  RxBool get isAutch {
    if (authResponse['idToken'] != null) {
      return true.obs;
    } else {
      return false.obs;
    }
  }

  void logout() {
    Get.offAll(AuthScreen());
    authResponse = {};
    box!.remove('credentials');
    _existingTimer = null;
    if (_existingTimer != null) {
      _existingTimer!.cancel();
      _existingTimer = null;
    }
  }

  _timerLogout() {
    if (_existingTimer != null) {
      _existingTimer!.cancel();
    }
    var expiresIn = authResponse['expiresIn'];
    var accessExpiryDate =
        DateTime.now().add(Duration(seconds: int.parse(expiresIn)));
    var timeToExpiry = accessExpiryDate.difference(DateTime.now()).inSeconds;

    _existingTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  void _saveCredentials(GetStorage box) async {
    var expiresIn = authResponse['expiresIn'];
    var accessExpiryDate =
        DateTime.now().add(Duration(seconds: int.parse(expiresIn)));
    var credentialsToString = jsonEncode({
      'expiresIn': accessExpiryDate.toIso8601String(),
      'idToken': authResponse['idToken'],
      'localId': authResponse['localId']
    });

    await box.write('credentials', credentialsToString);
  }

  Future<bool> _tryToLogin(GetStorage box) async {
    var credentials = await box.read('credentials');

    if (credentials == null) {
      print('no saved credential');
      return false;
    }
    var decodedCredentials =
        jsonDecode(credentials) /* as Map<String, dynamic> */;
    final expiryDate = DateTime.parse(decodedCredentials['expiresIn']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    authResponse['idToken'] = decodedCredentials['idToken'];
    authResponse['localId'] = decodedCredentials['localId'];
    _timerLogout();

    return true;
  }

  updateIsAuth() {
    isAutch;
    update();
  }

  @override
  void onInit() async {
    box = GetStorage();
    await _tryToLogin(box!);

    super.onInit();
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