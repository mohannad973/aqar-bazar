import 'package:aqar_bazar/models/user_requests_response.dart';
import 'package:flutter/material.dart';
class RequestedItemCard extends StatelessWidget {
  Request request;

  RequestedItemCard({this.request});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return   Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 170,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),

          child: Container(
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
                        child: Image.network(request.thumbnail)),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Container(
                    width: width*0.35,
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(request.title,maxLines: 3,),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("from: "),
                            Text(request.from.toString()),
                          ],
                        ),
                        // Row(children: [
                        //   Icon(Icons.hotel,color: Colors.blue,),
                        //   Text("1"),
                        //   Icon(Icons.beach_access),
                        //   Text("2")
                        // ],),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("to: "),
                            Text(request.to.toString()),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("status: "),
                            Text(request.status),
                          ],
                        ),


                      ],
                    ),
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(" \$${request.amount}",style: TextStyle(fontSize: 20,color: Colors.green),),
                      Container(
                        child: Center(
                          child: RaisedButton(
                            onPressed: (){},
                            child: Text(
                              'pay',
                              style: TextStyle(
                                fontWeight:
                                FontWeight
                                    .bold,
                                fontSize: 15,
                                color:
                                Colors.white,
                              ),
                            ),
                            color:
                            Theme.of(context)
                                .primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    15)),
                          ),
                        ),
                        width: width * 0.3,
                      ),
                      Container(
                        child: Center(
                          child: RaisedButton(
                            onPressed: (){},
                            child: Text(
                              'cancel',
                              style: TextStyle(
                                fontWeight:
                                FontWeight
                                    .bold,
                                fontSize: 15,
                                color:
                                Colors.white,
                              ),
                            ),
                            color:
                            Theme.of(context)
                                .primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    15)),
                          ),
                        ),
                        width: width * 0.2,
                      ),

                    ],
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
