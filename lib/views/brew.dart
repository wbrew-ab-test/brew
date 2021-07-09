// import 'package:brew/bindings/brewbind.dart';
// import 'package:brew/views/brewdashboard.dart';
import 'package:brew/bindings/brewbind.dart';
import 'package:brew/views/brewdashboard.dart';
import 'package:brew/views/brewlogin.dart';
import 'package:brew/views/brewmentorsignup.dart';
import 'package:brew/views/brewprofile.dart';
// import 'package:brew/views/brewmentorsignup.dart';
// import 'package:brew/views/brewprofile.dart';
import 'package:brew/views/brewsignup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
// import 'package:get/get.dart';

class Brew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // title: 'Login',
      unknownRoute: GetPage(name: '/', page: () => BrewLogin()),
      initialRoute: '/',
      initialBinding: BrewBind(),
      getPages: [
        GetPage(
          name: '/',
          page: () => BrewLogin(),
        ),
        GetPage(name: '/signup', page: () => BrewSignup()),
        GetPage(name: '/mentorSignup', page: () => BrewMentorSignup()),
        GetPage(name: '/dashboard', page: () => BrewDashboard()),
        GetPage(name: '/profile', page: () => BrewProfile()),
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return GetMaterialApp(
  //     title: 'Login',
  //     initialRoute: '/',
  //     routes: {
  //       '/': (context) => BrewLogin(),
  //       '/signup': (context) => BrewSignup()
  //     },
  //   );
  // }
}
