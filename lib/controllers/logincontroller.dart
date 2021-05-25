import 'package:brew/helper/platforminfo.dart';
import 'package:brew/logger/brewlogger.dart';
import 'package:brew/models/brewauthenticationrequest.dart';
import 'package:brew/models/brewprofile.dart';
import 'package:brew/services/userauthservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxInt loginSuccess = 0.obs;
  bool isFaceID =
      (PlatformInfo.isIOS() || PlatformInfo.isAndroid()) ? true : false;
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final LocalAuthentication auth = LocalAuthentication();
  @override
  void onInit() {
    nameController.text = '';
    // isFaceID = PlatformInfo.isIOS() || PlatformInfo.isAndroid() ? true : false;
    super.onInit();
    getSecureStorageForMobileDevices();
    // Get.lazyPut(() => UserAuthService());
    ever(loginSuccess, (val) {
      logger.d('loginSuccess : ' + val.toString());
      if (val == 1) {
        Get.toNamed('signup');
      }
    });
  }

  void getSecureStorageForMobileDevices() async {
    try {
      String? email;
      String? password;
      Future<String?> isUsingBio = storage.read(key: 'wantsTouchId');
      await isUsingBio.then((value) {
        if (null != value) {
          logger.d('Value :' + value);
          isFaceID = true;
        } else {
          logger.d('Value : null ');
          isFaceID = false;
        }
        update();
      });
      // final storedEmail = await storage.read(key: 'email');
      // final storedPassword = await storage.read(key: 'password');

      // isFaceID = isUsingBio == 'true';
      // email =
      //     (null != storedEmail && storedEmail.isNotEmpty) ? storedEmail : null;
      // password = (null != storedPassword && storedPassword.isNotEmpty)
      //     ? storedPassword
      //     : null;
      // isFaceID = (isUsingBio == 'true' && null != email && null != password)
      //     ? true
      //     : false;

      // if (null != email) {
      //   nameController.text = email;
      // }
      // if (null != password) {
      //   passwordController.text = password;
      // }
      // if (null != email &&
      //     null != password &&
      //     isFaceID &&
      //     PlatformInfo.isIOS()) {
      //   // authenticate();
      // }
      // logger.i('isFaceID : ' +
      //     isFaceID.toString() +
      //     ' : email : ' +
      //     email.toString() +
      //     ' : password : ' +
      //     password.toString());
    } on PlatformException catch (e) {
      logger.e(e);
    }
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  void login() async {
    if (loginFormKey.currentState!.validate()) {
      BrewAuthenticationRequest request = BrewAuthenticationRequest(
          email: nameController.text,
          password: passwordController.text,
          returnSecureToken: true);

      late Future<Response> userProfile =
          Get.find<UserAuthService>().authenticateUser(request, true);

      await userProfile.then((responseObj) {
        logger.d("Status Code : " + responseObj.body.toString());
        if (responseObj.statusCode == 200) {
          BrewProfile obj = BrewProfile.fromJson(responseObj.body);
          loginSuccessChange();
          logger.d('val : ' + loginSuccess.obs.value.toString());
        }
      });
    }
  }

  void loginSuccessChange() {
    logger.d('inside update');
    loginSuccess = 1.obs;
    Get.toNamed('/dashboard');
    update();
  }

  @override
  void onClose() {
    nameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void authenticate(String email, String password, bool isBio) async {
    final canCheck = await auth.canCheckBiometrics;
    logger.i('authenticate method ' + canCheck.toString());
    try {
      if (canCheck) {
        List<BiometricType> availableBiometrics =
            await auth.getAvailableBiometrics();
        if (PlatformInfo.isAndroid() &&
            availableBiometrics.contains(BiometricType.fingerprint)) {
          readBiometrics(
              email, password, isBio, PlatformInfo.isIOS(), auth, storage);
        } else if (PlatformInfo.isIOS() &&
            availableBiometrics.contains(BiometricType.face)) {
          readBiometrics(
              email, password, isBio, PlatformInfo.isIOS(), auth, storage);
        }
      } else {
        // Can't check
        print('cant check');
      }
    } on PlatformException catch (e) {
      logger.e(e);
    }
  }

  void readBiometrics(email, password, bool isBio, bool isIOS,
      LocalAuthentication auth, FlutterSecureStorage storage) async {
    final authenticated = await auth.authenticate(
        localizedReason: isIOS
            ? 'Enable Face Id to sign in more easily'
            : 'Scan your fingerprint to Authenticate.',
        useErrorDialogs: true,
        stickyAuth: true,
        biometricOnly: true);

    if (authenticated) {
      final storedUserName = email;
      final storedPassword = password;

      if ((null != storedUserName && storedUserName.isNotEmpty) &&
          (null != storedPassword && storedPassword.isNotEmpty)) {
        // signIn(storedUserName, storedPassword, isFaceID, storage);

        BrewAuthenticationRequest request = BrewAuthenticationRequest(
            email: storedUserName.toString(),
            password: storedPassword.toString(),
            returnSecureToken: true);

        late Future<Response> userProfile =
            Get.find<UserAuthService>().authenticateUser(request, true);

        await userProfile.then((responseObj) {
          logger.d("Status Code : " + responseObj.body.toString());
          if (responseObj.statusCode == 200) {
            BrewProfile obj = BrewProfile.fromJson(responseObj.body);
            loginSuccessChange();
            logger.d('val : ' + loginSuccess.obs.value.toString());
          }
        });

        logger.d(storedUserName);
        logger.i('Stored user Name : ' + storedUserName.toString());
      } else {
        logger.i('Inside the else ');
      }
    }
  }

  static writeBiometrics(
      email,
      password,
      wantsTouchId,
      FlutterSecureStorage storage,
      LocalAuthentication auth,
      bool isIOS) async {
    final authenticated = await auth.authenticate(
        localizedReason: isIOS
            ? 'Enable Face Id to sign in more easily'
            : 'Scan your fingerprint to Authenticate.',
        useErrorDialogs: true,
        stickyAuth: true,
        biometricOnly: true);

    if (authenticated) {
      storage.write(key: 'email', value: email);
      storage.write(key: 'password', value: password);
      storage.write(key: 'wantsTouchId', value: wantsTouchId);
    }
  }

  bool bioChanged(bool? isChanged) {
    if (null != isChanged) {
      this.isFaceID = !isChanged;
    }
    return this.isFaceID;
  }
}
