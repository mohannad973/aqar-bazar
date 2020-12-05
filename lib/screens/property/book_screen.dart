import 'package:aqar_bazar/localization/app_localization.dart';
import 'package:aqar_bazar/models/best_deals_model.dart';
import 'package:aqar_bazar/models/single_property_response.dart';
import 'package:aqar_bazar/providers/book_property_provider.dart';
import 'package:aqar_bazar/providers/request_property_provider.dart';
import 'package:aqar_bazar/providers/single_property_provider.dart';
import 'package:aqar_bazar/screens/filter/search_result_model.dart';
import 'package:aqar_bazar/screens/property/property.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class BookScreen extends StatefulWidget {
  Datum property;
  SingleProperty singleProperty;


  BookScreen({this.property,this.singleProperty});

  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  String fromText='';
  String toText='';
  String fillDate='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.property
              .title,
          style: TextStyle(
              fontSize:
              15,
              color: Colors
                  .white),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Image(
                  image: NetworkImage(widget.property.thumbnail),
                  fit: BoxFit.fill,
                  // height: double.infinity,
                  width: double.infinity,
                  // alignment: Alignment.center,
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.5,

              ),
              SizedBox(
                height: 10,
              ),


              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 20, horizontal: 25),
                  child: AspectRatio(
                    aspectRatio: 1.5,
                    child: Container(
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 8.0,
                                ),
                                child: Text(
                                  Applocalizations.of(context)
                                      .translate("pick-date"),
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .primaryColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        child: Center(
                                          child:
                                          RaisedButton(
                                            onPressed:
                                                () async {

                                              final DateTime picked = await showDatePicker(
                                                  fieldHintText: "from",
                                                  context: context,
                                                  initialDate:
                                                  DateTime.now(),
                                                  firstDate:
                                                  DateTime(2000),
                                                  lastDate:
                                                  DateTime(2025));

                                              if (picked != null && picked != fromDate) {

                                                setState(() {

                                                  fromText = picked.toString().substring(0,10);
                                                  fromDate = picked;

                                                });
                                              }
                                              print('fromDate '+ fromDate.toString());

                                            },
                                            child: Text(
                                              Applocalizations.of(
                                                  context)
                                                  .translate(
                                                  "start-date"),
                                              style:
                                              TextStyle(
                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                                fontSize:
                                                15,
                                                color: Colors
                                                    .white,
                                              ),
                                            ),
                                            color: Theme.of(
                                                context)
                                                .primaryColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    15)),
                                          ),
                                        ),
                                        width: MediaQuery.of(context).size.width * 0.4,
                                      ),
                                      SizedBox(height: 8,),
                                      Text(fromText,style: TextStyle(fontSize: 15,color: fBlue),)
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        child: Center(
                                          child:
                                          RaisedButton(
                                            onPressed:
                                                () async {
                                              final DateTime picked = await showDatePicker(
                                                  fieldHintText: "to",
                                                  context: context,
                                                  initialDate:
                                                  DateTime.now(),
                                                  firstDate:
                                                  DateTime(2000),
                                                  lastDate:
                                                  DateTime(2025));

                                              if (picked != null && picked != toDate) {

                                                setState(() {
                                                  toText = picked.toString().substring(0,10);
                                                  toDate = picked;
                                                  // toText = toDate.toString().substring(0,10);
                                                });
                                              }
                                              print('toData '+ toDate.toString());

                                            },
                                            child: Text(

                                              Applocalizations.of(
                                                  context)
                                                  .translate(
                                                  "end-date"),
                                              style:
                                              TextStyle(
                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                                fontSize:
                                                15,
                                                color: Colors
                                                    .white,
                                              ),
                                            ),
                                            color: Theme.of(
                                                context)
                                                .primaryColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    15)),
                                          ),
                                        ),
                                        width: MediaQuery.of(context).size.width * 0.4,
                                      ),
                                      SizedBox(height: 8,),
                                      Text(toText,style: TextStyle(fontSize: 15,color: fBlue),)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20,),
                            Provider.of<BookPropertyProvider>(context).isLoading()?Center(child: CircularProgressIndicator(backgroundColor: fBlue,)):
                            Center(
                              child: RaisedButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                    MediaQuery.of(
                                        context)
                                        .size
                                        .width /
                                        4,
                                    vertical: 12),
                                onPressed: () async {



                                  if((fromText != '' && fromText != null) && (toText != '' && toText != null)){
                                   var booked = Provider.of<BookPropertyProvider>(
                                        context,
                                        listen: false)
                                        .bookProperty(widget.property.id.toString(),fromText,toText,widget.property.price.toString(),widget.singleProperty.sellingType.toString());



                                    print('book999 '+booked.toString());
                                    if (await booked) {
                                      print('booked 7777');
                                      Provider.of<SinglePropertyProvider>(context,listen: false).singleProperty.isBooked=true;
                                      Provider
                                          .of<BookPropertyProvider>(
                                          context,
                                          listen: false)
                                          .succressResponse= null;
                                      // final snackBar = SnackBar(
                                      //     content: Text(Provider
                                      //         .of<BookPropertyProvider>(
                                      //         context)
                                      //         .succressResponse
                                      //         .success));
                                      //
                                      // Scaffold.of(context)
                                      //     .showSnackBar(snackBar);

                                      fillDate = '';
                                      Provider
                                          .of<BookPropertyProvider>(
                                          context,
                                          listen: false)
                                          .succressResponse =
                                      null;
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PropertyPage(property:widget.property,)));
                                    }
                                  }else{
                                    setState(() {
                                      fillDate = Applocalizations.of(context).translate("fillDate");
                                    });
                                  }



                                },
                                child: Text(
                                  Applocalizations.of(
                                      context)
                                      .translate(
                                      "book_now"),
                                  style: TextStyle(
                                    fontWeight:
                                    FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                color: Theme.of(context)
                                    .primaryColor,
                                shape:
                                RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        15)),
                              ),
                            ),
                            SizedBox(height: 5,),
                            (fillDate != null && fillDate !='')? Center(child: Text(fillDate,style: TextStyle(fontSize: 15,color: Colors.red),)):Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
