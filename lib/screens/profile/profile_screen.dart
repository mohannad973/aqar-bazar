import 'package:aqar_bazar/screens/change_password/change_password_screen.dart';
import 'package:aqar_bazar/screens/invite_friends/invite_friends_screen.dart';
import 'package:aqar_bazar/screens/profile/profile_list_item.dart';
import 'package:aqar_bazar/screens/settings/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.white70,
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'assets/images/free-profile-photo-whatsapp-4.png'),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Mohannad Youssef',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'MohannadYoussef93@gmail.com',
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangePasswordScreen()),
                            );
                          },
                          child: profileListItem(
                              'change password', LineAwesomeIcons.lock)),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InviteFriends()),
                          );
                        },
                        child: profileListItem(
                          'Invite Friends',
                          LineAwesomeIcons.person_entering_booth,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      profileListItem(
                          'Credits & Coupons', LineAwesomeIcons.gift),
                      SizedBox(
                        height: 20,
                      ),
                      profileListItem('Help Center', LineAwesomeIcons.info),
                      SizedBox(
                        height: 20,
                      ),
                      profileListItem('Payments', LineAwesomeIcons.money_bill),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsScreen()),
                            );
                          },
                          child: profileListItem('Settings', Icons.settings)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
