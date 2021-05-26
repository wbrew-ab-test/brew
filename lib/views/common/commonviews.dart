import 'package:brew/constants/brewconstants.dart';
import 'package:brew/helper/modedetector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonViews {
  static AppBar getAppBar(String title) {
    return AppBar(
      title: Text(title),
      backgroundColor: BrewConstants.pulseBlue,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(
            Icons.menu,
            color: BrewConstants.white70,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Get.back();
                // Get.offAll(Brew());
              },
              child: Icon(
                Icons.logout,
                color: BrewConstants.white,
                size: 26.0,
              ),
            )),
      ],
    );
  }

  static Container backgroundImage(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Image.asset(
        "assets/loginbackground.png",
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width * 0.65,
        height: MediaQuery.of(context).size.height * .995,
      ),
    );
  }

  static Container pageTitle(BuildContext context, String title) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Text(
        title,
        style: TextStyle(
          color: BrewConstants.pulseBlue,
          fontWeight: FontWeight.w800,
          fontSize: 60,
        ),
      ),
    );
  }

  static Container textFieldControl(
      BuildContext context,
      FocusNode node,
      controller,
      TextEditingController field,
      String labelText,
      bool isSecure) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        obscureText: isSecure,
        controller: field,
        style: TextStyle(
          color: ModeDetector.isDarkMode(context)
              ? BrewConstants.white70
              : BrewConstants.black87,
        ),
        decoration: InputDecoration(
          fillColor: ModeDetector.isDarkMode(context)
              ? BrewConstants.white70
              : BrewConstants.black87,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: BrewConstants.pulseBlue),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: BrewConstants.pulseBlue),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          labelText: labelText,
          labelStyle: TextStyle(
              color: node.hasFocus
                  ? BrewConstants.pulseBlue
                  : ModeDetector.isDarkMode(context)
                      ? BrewConstants.pulseBlue
                      : BrewConstants.black87),
          errorStyle: TextStyle(color: Colors.redAccent),
        ),
        validator: controller.validator,
      ),
    );
  }
}
