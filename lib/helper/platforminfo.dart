import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformInfo {static bool isWeb() {
  return kIsWeb;
}

static bool isIOS() {
  return getCurrentPlatformType().toString() == 'PlatformType.iOS';
}

static bool isAndroid() {
  return getCurrentPlatformType().toString() == 'PlatformType.Android' ;
}

static PlatformType getCurrentPlatformType() {
  if (kIsWeb) {
    return PlatformType.Web;
  }
  if (Platform.isMacOS) {
    return PlatformType.MacOS;
  }
  if (Platform.isFuchsia) {
    return PlatformType.Fuchsia;
  }
  if (Platform.isLinux) {
    return PlatformType.Linux;
  }
  if (Platform.isWindows) {
    return PlatformType.Windows;
  }
  if (Platform.isIOS) {
    return PlatformType.iOS;
  }
  if (Platform.isAndroid) {
    return PlatformType.Android;
  }
  return PlatformType.Unknown;
}

}

enum PlatformType {
  Web,
  iOS,
  Android,
  MacOS,
  Fuchsia,
  Linux,
  Windows,
  Unknown
}
