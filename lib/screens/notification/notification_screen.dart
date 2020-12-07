import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/localization/app_localization.dart';
import 'package:aqar_bazar/providers/notification_provider.dart';
import 'package:aqar_bazar/providers/user_requests_provider.dart';
import 'package:aqar_bazar/screens/my_bookings/requested_item_card.dart';
import 'package:aqar_bazar/screens/notification/components/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../test.dart';

class NotificationScreen extends StatefulWidget {

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  String local;
  final itemSize = 80.0;
  SessionManager sessionManager = SessionManager();

  _getLocal() async{
    local =await sessionManager.getLocale();
  }

  @override
  void initState() {
    super.initState();
    // Provider.of<UserRequestProvider>(context,listen: false).getAllRequests(1);
    _getLocal();
    Provider.of<NotificationProvider>(context,listen: false).getNotes();

  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
     var notificationProvider = Provider.of<NotificationProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(Applocalizations.of(context).translate("notification")),
      ),
      body:

      notificationProvider.isLoading()?Center(child: CircularProgressIndicator(backgroundColor: darkBlue,)):
      notificationProvider.allNotification.isEmpty?
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height:height-200 ,
            width: width,
            child: Image.asset('assets/images/empty-lst.jpg'),
          ),
          Text(Applocalizations.of(context).translate('empty-notification'))
        ],
      )
          :
      Column(
        children: <Widget>[

          Expanded(
            child: ListView.builder(

              // itemExtent: itemSize,
              itemCount: notificationProvider.allNotification.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TestScreen()));
                  },
                    child: NotificationCard(notification: notificationProvider.allNotification[index],local: local,));
                  // RequestedItemCard(request: userRequestProvider.allRequestsList[index],itemIndex: index,);
              },
            ),
          ),
        ],
      ),

    );
  }

  void dispose(){
    // Don't forget to dispose the ScrollController.
    super.dispose();
  }

}
