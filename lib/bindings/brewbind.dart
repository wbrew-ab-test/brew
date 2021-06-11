import 'package:brew/controllers/logincontroller.dart';
import 'package:brew/controllers/menucontroller.dart';
import 'package:brew/controllers/signupcontroller.dart';
import 'package:brew/controllers/signupmentorcontroller.dart';
import 'package:brew/controllers/videoscontroller.dart';
import 'package:get/get.dart';

/// This class holds the binding for application.
class BrewBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => SignupController());
    Get.lazyPut(() => MenuController());
    Get.lazyPut(() => VideosController());
    Get.lazyPut(() => SignupMentorController()); // Get.put(() => UserAuthService());
  }
}
