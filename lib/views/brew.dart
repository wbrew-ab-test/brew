

import 'package:brew/bindings/brewbind.dart';
import 'package:brew/views/brewlogin.dart';
import 'package:brew/views/brewsignup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Brew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Login',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => BrewLogin(), binding: BrewBind()),
        GetPage(name: '/signup', page: () => BrewSignup(), binding: BrewBind()),
      ],

    );
  }
}