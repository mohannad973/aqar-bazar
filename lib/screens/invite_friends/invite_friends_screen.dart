import 'package:aqar_bazar/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:share/share.dart';

class InviteFriends extends StatefulWidget {
  @override
  _InviteFriendsState createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),

      body: Column(
       // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 50,
          ),
          Image.asset('assets/images/invitefriends.png'),
          SizedBox(height: 10,),
          Text(
            Applocalizations.of(context)
                .translate("invite_your_frnds"),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),
          ),
          SizedBox(height: 15,),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(Applocalizations.of(context)
                  .translate("invite_your_frnds_disc"),style: TextStyle(fontSize: 20),overflow: TextOverflow.ellipsis,maxLines: 2,textAlign: TextAlign.center,)),
            ),
          ),
          SizedBox(height: 50,),
          RaisedButton.icon(
              onPressed: (){
                // FlutterShare.share(
                //   title: 'Share',
                //   linkUrl: 'shareUrl',
                // );
                print('share11111111111');
                share(context,'test share');
              },
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context)
                      .size
                      .width /
                      3,
                  vertical: 10),

              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
              label: Text(
                Applocalizations.of(context)
                    .translate("share"),
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(15.0),
              ))
        ],
      ),
    );
  }
  void share(BuildContext context,String text){
    final String title = 'description';
    Share.share(title,subject: text,);

  }
}
