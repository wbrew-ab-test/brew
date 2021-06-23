import 'package:brew/constants/brewconstants.dart';
import 'package:brew/controllers/logincontroller.dart';
import 'package:brew/controllers/menucontroller.dart';
import 'package:brew/controllers/signupmentorcontroller.dart';
import 'package:brew/controllers/videoscontroller.dart';
import 'package:brew/helper/modedetector.dart';
import 'package:brew/logger/brewlogger.dart';
import 'package:brew/models/menu/sidebar.dart';
import 'package:brew/models/page/pageresponse.dart';
import 'package:brew/models/video/videoleaf.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          ),
        ),
      ],
    );
  }

  static Container loadBackgroundImage(String? path, BuildContext context) {
    // Controls? control = controller.pageResponse!.data!.controls![0];
    return Container(
      alignment: Alignment.center,
      child: Image.asset(
        path!,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width * 0.65,
        height: MediaQuery.of(context).size.height * .995,
      ),
    );
  }

  static Container backgroundImage(BuildContext context) {
    // Controls? control = controller.pageResponse!.data!.controls![0];
    return Container(
      alignment: Alignment.center,
      child: Image.asset(
        'assets/loginbackground.png',
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
      bool isSecure,
      bool isEnabled) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        enabled: isEnabled,
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
                      // controller.menu![index].displayName,
                      // displayItem(controller.menu![index]),
                      displayItem(controller.menu![index]),
                      style:
                          TextStyle(color: BrewConstants.white, fontSize: 18.0),
                    ),
                    onTap: () {
                      switch (controller.menu![index].navId) {
                        case 'signout':
                          Get.back();
                          // Get.back();
                          break;
                        case 'profile':
                          Get.toNamed('/profile');
                          break;
                        case 'nest':
                          Get.toNamed('/dashboard');
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

  static String displayItem(Sidebarnav nav) {
    if (nav.navId == 'profilename') {
      Future<String> item =
          getValueFromSharedPreferences('displayName').then((value) {
        return value;
      });
      return 'Hi, ' + item.toString();
    } else {
      return nav.displayName;
    }
  }

  static Future<String> getValueFromSharedPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key)!;
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

  static Container richVideoBar(String title) {
    return Container(
      width: double.infinity,
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
            text: title,
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

  static ListView videoList(
      VideosController controller, List<Videoleaf>? videolist) {
    final List<Videoleaf>? items = videolist;
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(0.0),
        itemCount: items!.length,
        itemBuilder: (context, index) {
          final Videoleaf item = items[index];
          return Card(
            child: ListTile(
              title: Text(
                item.title,
                style: TextStyle(
                    color: BrewConstants.black87, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item.subtitle),
              trailing: Icon(Icons.more_vert),
              onTap: () {
                logger.d('item.videourl : ' + item.videourl);
                controller.index = index;
                controller.videoleaf = controller.videolist![index];
                // controller.dispose();
                controller.update();
              },
            ),
          );
        });
  }

  static ListView mockedList() {
    return ListView(
      // scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(0.0),
      children: <Widget>[
        Card(
          // color: Colors.grey[100],
          child: ListTile(
            title: Text('Entry A'),
            trailing: Icon(Icons.more_vert),
            onTap: () {
              logger.d('Testing the tabs');
            },
          ),
        ),
        Card(
          // color: Colors.grey[100],
          child: const ListTile(
            title: Text('Entry B'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          // color: Colors.grey[100],
          child: const ListTile(
            title: Text('Entry A'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          // color: Colors.grey[100],
          child: const ListTile(
            title: Text('Entry B'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          // color: Colors.grey[100],
          child: const ListTile(
            title: Text('Entry A'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          // color: Colors.grey[100],
          child: const ListTile(
            title: Text('Entry B'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          // color: Colors.grey[100],
          child: const ListTile(
            title: Text('Entry A'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          // color: Colors.grey[100],
          child: const ListTile(
            title: Text('Entry B'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          // color: Colors.grey[100],
          child: const ListTile(
            title: Text('Entry A'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          // color: Colors.grey[100],
          child: const ListTile(
            title: Text('Entry B'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          // color: Colors.grey[100],
          child: const ListTile(
            title: Text('Entry A'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          // color: Colors.grey[100],
          child: const ListTile(
            title: Text('Entry B'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          // color: Colors.grey[100],
          child: const ListTile(
            title: Text('Entry A'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          // color: Colors.grey[100],
          child: const ListTile(
            title: Text('Entry B'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          // color: Colors.grey[100],
          child: const ListTile(
            title: Text('Entry A'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          // color: Colors.grey[100],
          child: const ListTile(
            title: Text('Entry B'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
      ],
    );
  }

  static TextButton buttonRoute(
    String label,
    String route,
    double fontSize,
  ) {
    return TextButton(
      onPressed: () {
        Get.toNamed(route);
      },
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          color: BrewConstants.pulseBlue,
        ),
      ),
    );
  }

  static dynamic brewDropdown() {
    return GetBuilder(
      init: SignupMentorController(),
      builder: (SignupMentorController controller) => Container(
        padding: EdgeInsets.all(10.0),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: BrewConstants.pulseBlue)),
          ),
          hint: Text('Experience'),
          value: controller.selectedValue,
          onChanged: (newValue) {
            controller.onSelected(newValue!);
          },
          items: controller.experience.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
