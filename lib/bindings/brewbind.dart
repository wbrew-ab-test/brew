import 'package:brew/controllers/logincontroller.dart';
import 'package:brew/controllers/signupcontroller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

/// This class holds the binding for application.
class BrewBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => SignupController());
  }
}
