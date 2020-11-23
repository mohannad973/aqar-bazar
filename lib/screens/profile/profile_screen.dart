import 'package:aqar_bazar/constants.dart';
import 'package:aqar_bazar/localization/app_localization.dart';
import 'package:aqar_bazar/providers/preferences_provider.dart';
import 'package:aqar_bazar/providers/user_profile_provider.dart';
import 'package:aqar_bazar/screens/Common_quistion/Common_quistion_screen.dart';
import 'package:aqar_bazar/screens/change_password/change_password_screen.dart';
import 'package:aqar_bazar/screens/invite_friends/invite_friends_screen.dart';
import 'package:aqar_bazar/screens/profile/profile_list_item.dart';
import 'package:aqar_bazar/screens/settings/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<USerProfileProvider>(context, listen: false).getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<USerProfileProvider>(context, listen: false).userProfileResponse;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.white70,
        body: Provider.of<USerProfileProvider>(
          context,
        ).isLoading()
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: darkBlue,
              ))
            : Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    CircleAvatar(
                        radius: 50,
                        backgroundImage: Provider.of<USerProfileProvider>(
                                        context)
                                    .userProfileResponse
                                    .profilePicture ==
                                null
                            ? AssetImage(
                                'assets/images/free-profile-photo-whatsapp-4.png')
                            : Image.network(
                                Provider.of<USerProfileProvider>(context)
                                    .userProfileResponse
                                    .profilePicture)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      user.firstName + ' '+ user.lastName,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      user.email,
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
                                        builder: (context) =>
                                            ChangePasswordScreen()),
                                  );
                                },
                                child: profileListItem(
                                    Applocalizations.of(context).translate("change_password"), LineAwesomeIcons.lock)),
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
                                Applocalizations.of(context).translate("Invite_friends"),
                                LineAwesomeIcons.person_entering_booth,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // profileListItem(
                            //     'Credits & Coupons', LineAwesomeIcons.gift),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            InkWell(
                              child: profileListItem(
                                  Applocalizations.of(context).translate("help"), LineAwesomeIcons.info),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CommonQuestionScreen()),
                                );
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            profileListItem(
                                Applocalizations.of(context).translate("payments"), LineAwesomeIcons.money_bill),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                                onTap: () {
                                  Provider.of<PreferencesProvider>(context,
                                          listen: false)
                                      .getPreferences();
                                  if (Provider.of<PreferencesProvider>(context,
                                              listen: false)
                                          .preferencesResponse !=
                                      null) {
                                    print(
                                        "/////////////////////***********//////32168" +
                                            Provider.of<PreferencesProvider>(
                                                    context,
                                                    listen: false)
                                                .languagesList
                                                .toString());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SettingsScreen()),
                                    );
                                  }
                                },
                                child: profileListItem(
                                    Applocalizations.of(context).translate("settings"), Icons.settings)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }
}
