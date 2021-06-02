import 'package:brew/logger/brewlogger.dart';
import 'package:brew/models/menu/menuresponse.dart';
import 'package:brew/models/menu/sidebar.dart';
import 'package:brew/services/menuservice.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  List<Sidebarnav>? menu;

  @override
  void onInit() async {
    super.onInit();
    late Future<Response> appMenu = Get.find<MenuService>().getAppMenu();
    await appMenu.then((menu) {
      MenuResponse obj = MenuResponse.fromJson(menu.body);
      this.menu = obj.data[0].sidebarnav;
      update();
      if (this.menu != null) {
        // logger.d('menu : ' + this.menu.toString());
        this.menu!.forEach((element) {
          logger.d(element.displayName);
        });
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    // super.dispose();
  }
}
