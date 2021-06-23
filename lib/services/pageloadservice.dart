import 'dart:convert';

import 'package:brew/logger/brewlogger.dart';
import 'package:get/get.dart';

class PageloadService extends GetConnect {
  Future<Response> fetchPage(String serviceUrl, request) {
    logger.d('PageloadService : fetchPage ');
    final String json = jsonEncode(request);
    final url = Uri.parse(serviceUrl);
    logger.d('PageloadService : url ' + url.toString());
    return post(url.toString(), json, contentType: "application/json");
  }
}
