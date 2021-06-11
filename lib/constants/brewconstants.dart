import 'package:flutter/material.dart';

class BrewConstants {
  static final String title = 'Task Brew';
  static final String loginPageTitle = 'Login';
  static final String signOut = 'Sign out';
  static final String signUp = 'Sign Up';

  static final String editTaskBrewTitle = 'Task Brew Edit';
  static final String viewTimelineTitle = 'Timeline';
  static final String timelineLogin = 'Timeline';
  static final String pulse = 'Pulse';
  static final String student = 'Student';
  static final String mentor = 'Mentor';
  static final String or = "or";
  static final String userName = 'User Name / Email';
  static final String password = 'Password';
  static final String forgotPassword = 'Forgot Password';
  static final String doYouHaveAccount = 'Sign In as ';
  static final String alreadyAccount = 'You already have account?';
  static final String login = 'Login';

  // Color Codes
  static final MaterialColor indigo = Colors.indigo;
  static final Color pulseBlue = const Color(0xffb253251);
  static final Color black87 = Colors.black87;
  static final Color black54 = Colors.black54;
  static final Color white = const Color(0xffE7E6E2);
  static final Color white70 = Colors.white70;

  static final Color darkCheckboxBackground = Colors.white12;
  static final Color darkCheckboxTick = Colors.white70;
  static final Color lightCheckboxBackground = Colors.grey.shade200;
  static final Color lightCheckboxTick = Colors.black54;
  static final Color errorTextColor = Colors.red.shade400;
  static final Color indigoAccent = Colors.indigoAccent;

  static final String taskName = 'Task Name';
  static final String taskDescription = 'Task Description';
  static final String profile = 'Profile';

  // HTTP URL AND KEYS
  static final String loginUrl =
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=';
  static final String signUpUrl =
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=';
  static final String accountAddressUrl =
      'https://identitytoolkit.googleapis.com/v1/accounts:update?key=';
  static final String userLookupUrl =
      'https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=';
  static final String menuUrl =
      'http://192.168.1.6:5001/ng-course-recipe-book-2d135/us-central1/pulse/fetchMenuConfig';
  static final String fetchVideosUrl =
      "http://192.168.1.6:5001/ng-course-recipe-book-2d135/us-central1/pulseVideos/fetchVideos";

  static final String signBrewUpUrl =
      "http://192.168.1.6:5001/ng-course-recipe-book-2d135/us-central1/user/addProfile";
  // static final String menuUrl =
  //     'http://192.168.1.9:5001/ng-course-recipe-book-2d135/us-central1/pulse/fetchMenuConfig';
  static final String httpKey = 'AIzaSyAlVsNtAQuS1uKtUnzapmMu3ZjkujecQsg';

  // Login Screen Error Messages
  static final String loginFailedErrorMessage =
      'Try Again !Authentication Failed.';

  // Login Form Validation Error
  static final String emailTextFieldValidationMessage =
      'User Name is mandatory with minimum of length 6!';
  static final String passwordTextFieldValidationMessage =
      'Please enter your password!';

  // Login Screen Labels
  static final String enabledFaceId = 'Enabled Face ID';
  static final String enableFaceId = 'Enable Face Id ';

  // Sign Up Screen Labels
  static final String displayName = 'Display Name';
  static final String firstName = 'First Name';
  static final String lastName = 'Last Name';
  static final String emailAddress = 'Email Address';
  static final String confirmPassword = 'Confirm Password';

  // Sign Up Screen Error Messages
  static final String firstNameErrorMessage = 'First Name is mandatory field!';
  static final String lastNameErrorMessage = 'Last Name is mandatory field!';
  static final String displayNameErrorMessage =
      'Display Name is mandatory field!';
  static final String emailErrorMessage = 'Email is mandatory field!';
  static final String passwordErrorMessage = 'Password Criteria doesn\'t meet!';
  static final String confirmPasswordErrorMessage =
      'Confirm Password Criteria doesn\'t meet!';

  // Font Size
  static final double headingSize = 24.0;
}
