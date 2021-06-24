import 'package:brew/constants/brewconstants.dart';
import 'package:brew/helper/platforminfo.dart';
import 'package:brew/logger/brewlogger.dart';
import 'package:brew/models/brewauthenticationrequest.dart';
import 'package:brew/models/brewprofile.dart';
import 'package:brew/models/page/pagerequest.dart';
import 'package:brew/models/page/pageresponse.dart';
import 'package:brew/services/pageloadservice.dart';
import 'package:brew/services/userauthservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxInt loginSuccess = 1.obs;
  bool isFaceID =
      (PlatformInfo.isIOS() || PlatformInfo.isAndroid()) ? true : false;
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final LocalAuthentication auth = LocalAuthentication();
  PageResponse? pageResponse;
  String? sideBarPath;
  int? length;
  String? title;
  Controls? passwordControl;
  @override
  void onInit() async {
    logger.d(
        '******************** Inside the onInit of LOGIN CONTROLLER ***************');
    super.onInit();
    nameController.text = '';
    Get.lazyPut(() => PageloadService());
    PageRequest request = new PageRequest(collectionName: 'brewlogin');
    late Future<Response> pageResponse = Get.find<PageloadService>()
        .fetchPage(BrewConstants.fetchPageUrl, request);
    await pageResponse.then((response) {
      logger.d('response : ' + response.body.toString());
      this.pageResponse = PageResponse.fromJson(response.body);
      logger.d('pageResponse : ' + this.pageResponse!.data!.collectionName!);

      this.sideBarPath = (this
          .pageResponse!
          .data!
          .controls!
          .firstWhere((control) => (control.type == 'sidebar'))
          .imageurl);

      if (null != this.pageResponse &&
          null != this.pageResponse!.data &&
          null != this.pageResponse!.data!.controls) {
        this.length = this.pageResponse!.data!.controls!.length + 1;
      }

      if (PlatformInfo.isIOS() || PlatformInfo.isAndroid()) {
        this.passwordControl = this.pageResponse!.data!.controls!.firstWhere(
            (control) =>
                (control.type == 'text' && control.name == 'password'));
        getSecureStorageForMobileDevices(this.passwordControl!);
      }
      ever(loginSuccess, (val) {
        logger.d('loginSuccess : ' + val.toString());
        if (val == 1) {
          Get.toNamed('signup');
        }
      });
    });
    update();
  }

  void getSecureStorageForMobileDevices(Controls control) async {
    try {
      logger.d('getSecureStorageForMobileDevices');
      String? isUsingBio = await storage.read(key: 'wantsTouchId');
      String? storedEmail = await storage.read(key: 'email');
      String? storedPassword = await storage.read(key: 'password');

      if (null != isUsingBio && isUsingBio.isNotEmpty) {
        isFaceID = true;
        update();
      } else {
        isFaceID = false;
        update();
      }

      if (null != storedEmail && storedEmail.isNotEmpty) {
        nameController.text = storedEmail;
      }
      if (null != storedPassword && storedPassword.isNotEmpty) {
        passwordController.text = storedPassword;
      }
      update();
      if (null != storedEmail &&
          storedEmail.isNotEmpty &&
          null != storedPassword &&
          storedPassword.isNotEmpty &&
          isFaceID &&
          PlatformInfo.isIOS()) {
        logger.d('storedEmail : ' +
            storedEmail +
            ': storedPassword : ' +
            storedPassword +
            ' : isFaceID : ' +
            isFaceID.toString());
        authenticate(storedEmail, storedPassword, isFaceID, control);
      }
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

  void login(Controls control) async {
    if (loginFormKey.currentState!.validate()) {
      BrewAuthenticationRequest request = BrewAuthenticationRequest(
          email: nameController.text,
          password: passwordController.text,
          returnSecureToken: true);

      late Future<Response> userProfile =
          Get.find<UserAuthService>().authenticateUser(request, true);

      await userProfile.then((responseObj) {
        logger.d("d Status Code : " + responseObj.body.toString());
        if (responseObj.statusCode == 200 || responseObj.statusCode == 201) {
          BrewProfile obj = BrewProfile.fromJson(responseObj.body);
          loginSuccessChange(obj, control);

          logger.d('val : ' + loginSuccess.obs.value.toString());
        } else {
          logger.d("error Status Code : " + responseObj.body.toString());
          loginSuccess = 0.obs;
          update();
        }
      });
    }
  }

  void loginSuccessChange(BrewProfile profile, Controls control) async {
    final prefs = await SharedPreferences.getInstance();
    // final SharedPreferences prefs = await _prefs;
    String? email = prefs.getString('email');
    if (null == email || email.trim() == '') {
      prefs.clear();
    }
    prefs.setString('email', profile.email);
    prefs.setString('displayName', profile.displayName);

    logger.d('inside update');
    loginSuccess = 1.obs;
    // Get.off(BrewDashboard());
    Get.toNamed(control.route!);
    update();
  }

  @override
  void onClose() {
    logger.d(
        '*********************************** CLOSE IS GETTING INVOKED **********************************');
    // nameController.dispose();
    // passwordController.dispose();
    // loginFormKey.
    super.onClose();
    super.dispose();
  }

  // @override
  // void dispose() {
  //   logger.d(
  //       '*********************************** CLOSE IS GETTING DISPOSE **********************************');
  //   nameController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }

  void authenticate(
      String email, String password, bool isBio, Controls control) async {
    logger.d('Login Controller authenticate method : ' +
        'email : ' +
        email +
        ' : password : ' +
        ' : isBio : ' +
        isBio.toString());
    try {
      final canCheck = await auth.canCheckBiometrics;
      logger.i('authenticate method ' + canCheck.toString());
      if (canCheck) {
        List<BiometricType> availableBiometrics =
            await auth.getAvailableBiometrics();
        if (PlatformInfo.isAndroid() &&
            availableBiometrics.contains(BiometricType.fingerprint)) {
          readBiometrics(email, password, isBio, PlatformInfo.isIOS(), auth,
              storage, control);
        } else if (PlatformInfo.isIOS() &&
            availableBiometrics.contains(BiometricType.face)) {
          readBiometrics(email, password, isBio, PlatformInfo.isIOS(), auth,
              storage, control);
        }
      } else {
        // Can't check
        print('cant check');
      }
    } on PlatformException catch (e) {
      logger.e(e);
    }
  }

  void readBiometrics(
      email,
      password,
      bool isBio,
      bool isIOS,
      LocalAuthentication auth,
      FlutterSecureStorage storage,
      Controls control) async {
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
            loginSuccessChange(obj, control);
            writeBiometrics(nameController.text, passwordController.text,
                isBio.toString(), storage, auth, PlatformInfo.isIOS());
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

  void writeBiometrics(
      String email,
      String password,
      String wantsTouchId,
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
