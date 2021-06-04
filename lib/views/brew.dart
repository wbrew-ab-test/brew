import 'package:brew/bindings/brewbind.dart';
import 'package:brew/views/brewdashboard.dart';
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
      initialBinding: BrewBind(),
      getPages: [
        GetPage(name: '/', page: () => BrewLogin()),
        GetPage(name: '/signup', page: () => BrewSignup()),
        GetPage(name: '/dashboard', page: () => BrewDashboard())
      ],
    );
  }
}
