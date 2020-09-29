import 'package:flutter/material.dart';

class InviteFriends extends StatefulWidget {
  @override
  _InviteFriendsState createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            'Invite Your Friends',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),
          ),
          SizedBox(height: 15,),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text('are you one of those who makes every thing at the last moment?',style: TextStyle(fontSize: 20),overflow: TextOverflow.ellipsis,maxLines: 2,textAlign: TextAlign.center,)),
            ),
          ),
          SizedBox(height: 50,),
          RaisedButton.icon(
              onPressed: (){
                Navigator.of(context).pop();
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
                "Share",
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
}
