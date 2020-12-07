import 'package:aqar_bazar/constants.dart';
import 'package:aqar_bazar/models/notification_response_model.dart';
import 'package:aqar_bazar/providers/notification_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class NotificationCard extends StatefulWidget {
  NotificationResponse notification;
  String local;
  NotificationCard({this.notification,this.local});


  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: Container(
          height: height*0.2,
          width: MediaQuery.of(context).size.width * 0.95,
          color: Colors.transparent,
          child: Card(
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        topLeft: Radius.circular(15.0)),
                    child: Image.network(widget.notification.data.head,
                      alignment: Alignment.centerLeft,fit: BoxFit.fitHeight,height: height*0.2,width: width*0.3,)),
                SizedBox(width: 6,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 10,),
                    Container(
                      height: height*0.1,
                      width: MediaQuery.of(context).size.width*0.6,
                      child: Text(
                        (widget.local == '1') ? widget.notification.data.bodyEn:
                        (widget.local == '2' ? widget.notification.data.bodyAr : widget.notification.data.bodyTr),
                        style: TextStyle(fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                    SizedBox(height: 8,),
                    Container(
                      height: height*0.05,
                      width: MediaQuery.of(context).size.width*0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Transform(
                              transform:Matrix4.identity()..scale(0.9),
                              child: Chip(

                                backgroundColor: fBlue,
                                label: Text(
                                  widget.notification.data.time.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),

                          ],),

                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
