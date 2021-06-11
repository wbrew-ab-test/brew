import 'package:brew/logger/brewlogger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Profile extends StatelessWidget {
  final Size? screenSize;

  Profile({required this.screenSize});
  final String _fullName = "John Frost";
  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: 'Pulse - My Profile',
      primaryColor: Theme.of(context).primaryColor.value,
    ));
    logger.d('scrreensize : ' + this.screenSize!.toString());
    return Stack(
      children: [
        _buildCoverImage(this.screenSize!),
        SafeArea(
          child: Column(children: <Widget>[
            SizedBox(height: screenSize!.height / 6.4),
            _buildProfileImage(),
            _buildFullName(),
            _buildSeparator(this.screenSize!),
          ]),
        ),
      ],
    );
  }

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 4.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/profile_background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/avatar.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 10.0,
          ),
        ),
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      _fullName,
      style: _nameTextStyle,
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.3,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }
}
