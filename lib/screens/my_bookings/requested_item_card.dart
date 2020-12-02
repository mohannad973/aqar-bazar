import 'package:aqar_bazar/constants.dart';
import 'package:aqar_bazar/localization/app_localization.dart';
import 'package:aqar_bazar/models/user_requests_response.dart';
import 'package:aqar_bazar/providers/cancel_request_provider.dart';
import 'package:aqar_bazar/providers/payment_provider.dart';
import 'package:aqar_bazar/providers/user_requests_provider.dart';
import 'package:aqar_bazar/screens/my_bookings/pay_pal_webView.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestedItemCard extends StatefulWidget {
  Request request;
  int itemIndex;
  int index=-1;
  RequestedItemCard({this.request,this.itemIndex});

  @override
  _RequestedItemCardState createState() => _RequestedItemCardState();
}

class _RequestedItemCardState extends State<RequestedItemCard> {
  @override
  Widget build(BuildContext context) {
    print('request '+widget.request.toString());
    var width = MediaQuery.of(context).size.width;
    var userRequestProvider = Provider.of<UserRequestProvider>(context);
    var cancelRequestProvider = Provider.of<CancelRequestProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 170,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: width,
            decoration: new BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[200],
                  blurRadius: 2.0, // has the effect of softening the shadow
                  spreadRadius: 2.0, // has the effect of extending the shadow
                  offset: Offset(
                    5.0, // horizontal, move right 10
                    5.0, // vertical, move down 10
                  ),
                )
              ],
            ),
            child: Container(
              color: Colors.white24,
              child: Row(
                children: [
                  Container(
                    height: 170,
                    width: width * 0.3,
                    child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(widget.request.thumbnail)),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Container(
                    width: width * 0.45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: AutoSizeText(
                                widget.request.title==null?'':widget.request.title,
                                maxLines: 3,
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                style: TextStyle(),
                              ),
                              width: width * 0.45,
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(Applocalizations.of(context).translate("from"),),
                            Text(widget.request.from == null
                                ? '-'
                                : widget.request.from.toString().substring(0, 10)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(Applocalizations.of(context).translate("to"),),
                            Text(widget.request.to == null
                                ? '-'
                                : widget.request.to.toString().substring(0, 10)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(Applocalizations.of(context).translate("status"),),
                            Text(widget.request.status),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: width * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          " \$${widget.request.amount}",
                          style: TextStyle(fontSize: 20, color: Colors.green),
                        ),
                        Container(
                          child: Center(
                            child: RaisedButton(
                              onPressed:widget.request.payNow == null?null :() {
                                Provider.of<PaymentProvider>(context,listen: false).pay('66', "2000");
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>PayPalScreen()));

                              },
                              child: Text(
                                Applocalizations.of(context).translate("pay"),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                          width: width * 0.3,
                        ),
                        Container(
                          child: Center(
                            child: (cancelRequestProvider.isLoading() && widget.index == widget.itemIndex)?Center(child: CircularProgressIndicator(backgroundColor: fBlue,)):RaisedButton(
                              onPressed:widget.request.status == Applocalizations.of(context).translate("cancelled") ?null : () async{
                                int index;
                                index = userRequestProvider.allRequestsList.indexOf(widget.request);
                                setState(() {
                                  widget.index = index;
                                });
                                bool cancelled = await cancelRequestProvider.cancelRequest(widget.request.id.toString());

                                if(cancelled){
                                  userRequestProvider.allRequestsList[index].status='cancelled';
                                }else{

                                }



                              },
                              child: Text(
                                Applocalizations.of(context).translate("cancel"),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                          width: width * 0.2,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
