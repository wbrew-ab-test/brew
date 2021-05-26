import 'package:brew/constants/brewconstants.dart';
import 'package:flutter/material.dart';

class BrewMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Align(
              alignment: Alignment.topLeft,
              child: Icon(
                Icons.supervised_user_circle,
                size: 50,
                color: BrewConstants.white,
              ),
            ),
            // Text('Profile',
            //     style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 32.0,
            //         color: BrewConstants.WHITE)),
            decoration: BoxDecoration(
              color: BrewConstants.pulseBlue,
            ),
          ),
          ListTile(
            title: Text(
              BrewConstants.profile,
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) =>
              //           TaskBrew(email: 'em', password: '', wantsTouchId: true),
              //     ));
            },
          ),
          ListTile(
            title: Text(
              'View Tasks',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => TaskBrew(
              //         email: 'em',
              //         password: '',
              //         wantsTouchId: true,
              //       ),
              //     ));
            },
          ),
          ListTile(
            title: Text(
              'Task Details',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => EditTask(),
              //     ));
            },
          ),
          ListTile(
            title: Text(
              BrewConstants.signOut,
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => TimelineLogin(false),
              //     ));
            },
          ),
        ],
      ),
    );
  }
}
