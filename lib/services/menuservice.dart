import 'package:brew/constants/brewconstants.dart';
import 'package:brew/logger/brewlogger.dart';
import 'package:get/get.dart';

class MenuService extends GetConnect {
  Future<Response> getAppMenu() {
    logger.d('Inside the menu service...');
    final url = Uri.parse(BrewConstants.menuUrl);
    return get(url.toString(), contentType: "application/json");
  }
}
