import 'package:brew/constants/brewconstants.dart';
import 'package:brew/controllers/menucontroller.dart';
import 'package:brew/helper/modedetector.dart';
import 'package:brew/logger/brewlogger.dart';
import 'package:brew/views/brewlogin.dart';
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

  static Container populateMenu(MenuController controller) {
    return Container(
      color: BrewConstants.pulseBlue,
      child: Container(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: controller.menu!.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      controller.menu![index].displayName,
                      style:
                          TextStyle(color: BrewConstants.white, fontSize: 18.0),
                    ),
                    onTap: () {
                      switch (controller.menu![index].navId) {
                        case 'signout':
                          // Get.offNamedUntil('/', (_) => false);
                          // Get.to(BrewLogin());
                          Get.back();
                          Get.back();
                          break;
                      }
                    },
                  ),
                  Divider(
                    color: BrewConstants.white,
                  ),
                ],
              );
            }),
      ),
    );
  }

  static Row error(String errorMessage) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          (null != errorMessage) ? errorMessage : 'Error Occurred',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red),
        ),
      ],
    );
  }

  static Container richVideoBar() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [BrewConstants.white, BrewConstants.pulseBlue])),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        // color: Colors.grey,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 0.0),
            left: BorderSide(width: 1.0, color: BrewConstants.black54),
            right: BorderSide(width: 1.0, color: BrewConstants.black54),
            bottom: BorderSide(width: 1.0, color: BrewConstants.black54),
          ),
        ),
        child: RichText(
          text: TextSpan(
            text: 'Video for Introduction.',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            children: [
              //   WidgetSpan(
              //     alignment: PlaceholderAlignment.middle,
              //     child: Icon(
              //       Icons.circle,
              //       size: 18,
              //       color: Colors.blue.shade400,
              //     ),
              //   ),
              //   WidgetSpan(
              //     child: Icon(
              //       Icons.circle,
              //       size: 18,
              //       color: Colors.blue.shade400,
              //     ),
              //   ),
              //   WidgetSpan(
              //     child: Icon(
              //       Icons.circle,
              //       size: 18,
              //       color: Colors.blue.shade400,
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }

  static ListView mockedList() {
    return ListView(
      padding: const EdgeInsets.all(0.0),
      children: <Widget>[
        Container(
          height: 50,
          color: Colors.grey[100],
          child: const Center(child: Text('Entry A')),
        ),
        Container(
          height: 50,
          color: Colors.grey[100],
          child: const Center(child: Text('Entry B')),
        ),
        Container(
          height: 50,
          color: Colors.grey[100],
          child: const Center(child: Text('Entry A')),
        ),
        Container(
          height: 50,
          color: Colors.grey[100],
          child: const Center(child: Text('Entry B')),
        ),
        Container(
          height: 50,
          color: Colors.grey[100],
          child: const Center(child: Text('Entry A')),
        ),
        Container(
          height: 50,
          color: Colors.grey[100],
          child: const Center(child: Text('Entry B')),
        ),
        Container(
          height: 50,
          color: Colors.grey[100],
          child: const Center(child: Text('Entry A')),
        ),
        Container(
          height: 50,
          color: Colors.grey[100],
          child: const Center(child: Text('Entry B')),
        ),
        Container(
          height: 50,
          color: Colors.grey[100],
          child: const Center(child: Text('Entry A')),
        ),
        Container(
          height: 50,
          color: Colors.grey[100],
          child: const Center(child: Text('Entry B')),
        ),
        Container(
          height: 50,
          color: Colors.grey[100],
          child: const Center(child: Text('Entry A')),
        ),
        Container(
          height: 50,
          color: Colors.grey[100],
          child: const Center(child: Text('Entry B')),
        ),
        Container(
          height: 50,
          color: Colors.grey[100],
          child: const Center(child: Text('Entry A')),
        ),
        Container(
          height: 50,
          color: Colors.grey[100],
          child: const Center(child: Text('Entry B')),
        ),
        Container(
          height: 50,
          color: Colors.grey[100],
          child: const Center(child: Text('Entry A')),
        ),
        Container(
          height: 50,
          color: Colors.grey[100],
          child: const Center(child: Text('Entry B')),
        ),
        Container(
          height: 50,
          color: Colors.grey[100],
          child: const Center(child: Text('Entry A')),
        ),
        Container(
          height: 50,
          color: Colors.grey[100],
          child: const Center(child: Text('Entry B')),
        ),
        Container(
          height: 50,
          color: Colors.grey[100],
          child: const Center(child: Text('Entry A')),
        ),
        Container(
          height: 50,
          color: Colors.grey[100],
          child: const Center(child: Text('Entry B')),
        ),
        Container(
          height: 50,
          color: Colors.grey[100],
          child: const Center(child: Text('Entry A')),
        ),
        Container(
          height: 50,
          color: Colors.grey[100],
          child: const Center(child: Text('Entry B')),
        ),
      ],
    );
  }
}
