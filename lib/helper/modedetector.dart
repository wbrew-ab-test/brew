
import 'package:brew/constants/brewconstants.dart';
import 'package:brew/helper/platforminfo.dart';
import 'package:flutter/material.dart';

class ModeDetector {


  static bool isDarkMode(context) {

    // logger.d('TimelineHelper isAndroid : '
    //     + Platform.isAndroid.toString() +
    //     ' : isIOS :' + Platform.isIOS.toString()
    // );

    bool isDarkTheme = false;
    if(PlatformInfo.isAndroid()) {
      // print(MediaQuery.of(context).platformBrightness);
      isDarkTheme = (MediaQuery.of(
          context).platformBrightness == Brightness.dark) ? true : false;
    } else if (PlatformInfo.isIOS()) {
      // print(MediaQuery.of(context).platformBrightness);
      isDarkTheme = (MediaQuery.of(
          context).platformBrightness == Brightness.dark) ? true : false;
    }
    // logger.d('TimelineHelper isDarkTheme : ' + isDarkTheme.toString());

    return isDarkTheme;
  }

  static dynamic getTabColor(int index, int _currentIndex, BuildContext context) {
    if (isDarkMode(context) && index == _currentIndex) {
      return BrewConstants.white;
    } else if (!isDarkMode(context) && index == _currentIndex) {
      return BrewConstants.indigoAccent;
    } else if (isDarkMode(context) && index != _currentIndex) {
      return BrewConstants.white70;
    } else {
      return BrewConstants.indigo;
    }
  }

  static dynamic getTabTextColor(int index, int _currentIndex, BuildContext context) {
    if (isDarkMode(context) && index == _currentIndex) {
      return BrewConstants.white;
    } else if (!isDarkMode(context) && index == _currentIndex) {
      return BrewConstants.black87;
    } else if (isDarkMode(context) && index != _currentIndex) {
      return BrewConstants.white70;
    } else {
      return BrewConstants.black54;
    }
  }
}