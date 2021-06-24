import 'package:brew/bindings/brewbind.dart';
import 'package:brew/constants/brewconstants.dart';
import 'package:brew/logger/brewlogger.dart';
import 'package:brew/views/brew.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() async {
  BrewBind().dependencies();

  const String env = String.fromEnvironment('env');
  // List<dynamic> response;
  const String region = (null != env) ? env : 'prod';
  logger.d('Load the env : ' + region);
  runApp(Brew());
}

Future<String> loadAsset(String env) async {
  return jsonDecode(await rootBundle.loadString('assets/cfg/env-' + env));
}
