import 'dart:ui';
import 'package:aqar_bazar/constants.dart';
import 'package:aqar_bazar/localization/app_localization.dart';
import 'package:aqar_bazar/models/best_deals_model.dart';
import 'package:aqar_bazar/models/comments_response.dart';
import 'package:aqar_bazar/models/single_property_response.dart';
import 'package:aqar_bazar/providers/add_to_fav_provider.dart';
import 'package:aqar_bazar/providers/cancel_request_provider.dart';
import 'package:aqar_bazar/providers/comments_provider.dart';
import 'package:aqar_bazar/providers/date_provider.dart';
import 'package:aqar_bazar/providers/request_property_provider.dart';
import 'package:aqar_bazar/providers/single_property_provider.dart';
import 'package:aqar_bazar/providers/user_requests_provider.dart';
import 'package:aqar_bazar/screens/filter/search_result_model.dart';
import 'package:aqar_bazar/screens/property/add_comment.dart';
import 'package:aqar_bazar/screens/property/book_screen.dart';
import 'package:aqar_bazar/screens/property/comments.dart';
import 'package:aqar_bazar/screens/property/contact_host_screen.dart';
import 'package:aqar_bazar/screens/property/image_gallery/property_images_screen.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/rich_text_parser.dart';
import 'package:provider/provider.dart';

import '../Property types/house.dart';
import '../Property types/house.dart';
import '../Property types/house.dart';

import 'package:http/http.dart' as http;

class PropertyPage extends StatefulWidget {
  Property propertyInfo;
  Datum property;
  SingleProperty singleProperty;

  int index = -1;
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  String fromText = '';
  String toText = '';

  PropertyPage({this.property});

  @override
  _PropertyPageState createState() => _PropertyPageState();
}

class _PropertyPageState extends State<PropertyPage> {
  List<Comment> commentsList = [];

  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  String fromText = '';
  String toText = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('rr2 ' + widget.property.viewLink);

    Provider.of<SinglePropertyProvider>(context, listen: false)
        .getPropertyInfo(widget.property.viewLink);
    Provider.of<CommentsProvider>(context, listen: false)
        .getComments(1, widget.property.id.toString());
  }

  _addCommentToList(Comment comment) {
    commentsList.add(comment);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    var singleProperty =
        Provider.of<SinglePropertyProvider>(context).singleProperty;
    return SafeArea(
      child: Scaffold(
        body: Provider.of<SinglePropertyProvider>(context).isLoading()
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: darkBlue,
              ))
            : Material(
                child: CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      delegate: FullScreenCustomSliverAppBar(
                          expandedHeight: MediaQuery.of(context).size.height,
                          propertyInfo:
                              Provider.of<SinglePropertyProvider>(context)
                                  .singleProperty),
                      pinned: true,
                    ),

                    SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: AutoSizeText(
                                  singleProperty.title,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 18),
                                  maxLines: 3,
                                ),
                                width: width * 0.8,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 18,
                                color: Theme.of(context).primaryColor,
                              ),
                              Text(
                                singleProperty.address,
                                style: TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18.0,
                            vertical: 8.0,
                          ),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 8),
                          child: Text(
                            Applocalizations.of(context).translate("summary"),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 8),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Html(
                                shrinkToFit: true,
                                data: singleProperty.description, //
                                // html string to be parsed

                                useRichText: true,
                                defaultTextStyle: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 8),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Applocalizations.of(context)
                                    .translate("Photos"),
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ImageGallery(
                                                attachments: Provider.of<
                                                            SinglePropertyProvider>(
                                                        context)
                                                    .attachments,
                                              )));
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      Applocalizations.of(context)
                                          .translate("see_all"),
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Icon(
                                      Icons.navigate_next,
                                      color: Theme.of(context).primaryColor,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 5,
                          child: ListView.builder(
                            cacheExtent: 999,
                            itemCount: Provider.of<SinglePropertyProvider>(
                                            context)
                                        .attachments
                                        .length >=
                                    4
                                ? 4
                                : Provider.of<SinglePropertyProvider>(context)
                                    .attachments
                                    .length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              var destination = Provider.of<
                                              SinglePropertyProvider>(context)
                                          .attachments
                                          .length >=
                                      4
                                  ? Provider.of<SinglePropertyProvider>(context)
                                      .attachments
                                      .sublist(0, 4)
                                  : Provider.of<SinglePropertyProvider>(context)
                                      .attachments;
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 5),
                                width: 200,
                                child: GestureDetector(
                                  onTap: () {
                                    showGeneralDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        barrierLabel:
                                            MaterialLocalizations.of(context)
                                                .modalBarrierDismissLabel,
                                        barrierColor: Colors.black45,
                                        transitionDuration:
                                            const Duration(milliseconds: 200),
                                        pageBuilder: (BuildContext buildContext,
                                            Animation animation,
                                            Animation secondaryAnimation) {
                                          return Center(
                                              child: Container(
                                            margin: EdgeInsets.all(8.0),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.8,
                                            padding: EdgeInsets.all(10),
                                            color: Colors.white,
                                            child: FadeInImage.assetNetwork(
                                              placeholder:
                                                  'assets/images/loader.gif',
                                              image: Provider.of<
                                                          SinglePropertyProvider>(
                                                      context)
                                                  .attachments[index],
                                              fit: BoxFit.cover,
                                            ),
                                          ));
                                        });
                                  },
                                  child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: FadeInImage.assetNetwork(
                                          placeholder:
                                              'assets/images/loader.gif',
                                          image: Provider.of<
                                                      SinglePropertyProvider>(
                                                  context)
                                              .attachments[index],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
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
                                                .translate("details"),
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  Applocalizations.of(context)
                                                      .translate("nobed"),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                              Text(
                                                singleProperty.bedroomsNumber
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ]),
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  Applocalizations.of(context)
                                                      .translate("nobath"),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                              Text(
                                                singleProperty.bathroomsNumber
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ]),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  Applocalizations.of(context)
                                                      .translate("price"),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                              Text(
                                                '\$ ' +
                                                    singleProperty.price
                                                        .toString(),
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ]),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      singleProperty.isBooked
                                          // || Provider.of<RequestPropertyProvider>(context).isRequested()
                                          ? Container(
                                              width: width,
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      child: Center(
                                                        child: RaisedButton(
                                                          child: Text(
                                                            Applocalizations.of(
                                                                    context)
                                                                .translate(
                                                                    "already_booked"),
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
                                                      width: width * 0.4,
                                                    ),
                                                    Provider.of<CancelRequestProvider>(
                                                                context)
                                                            .isLoading()
                                                        ? Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                            backgroundColor:
                                                                fBlue,
                                                          ))
                                                        : Container(
                                                            child: Center(
                                                              child:
                                                                  RaisedButton(
                                                                // padding: EdgeInsets.symmetric(
                                                                //     horizontal:
                                                                //     MediaQuery.of(context)
                                                                //         .size
                                                                //         .width /
                                                                //         4,
                                                                //     vertical: 12),
                                                                onPressed:
                                                                    () async {
                                                                  // Provider.of<RequestPropertyProvider>(
                                                                  //     context,
                                                                  //     listen: false)
                                                                  //     .cancelRequest(
                                                                  //     singleProperty.id
                                                                  //         .toString()
                                                                  //         .trim());

                                                                  bool cancelled = await Provider.of<
                                                                              CancelRequestProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .cancelRequest(singleProperty
                                                                          .requestId
                                                                          .toString());

                                                                  if (cancelled) {
                                                                    print(
                                                                        'cancelled7');
                                                                    Provider.of<SinglePropertyProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .singleProperty
                                                                        .isBooked = false;
                                                                    // Provider.of<RequestPropertyProvider>(context).setRequested(false);

                                                                  } else {
                                                                    print(
                                                                        'cancelled8');
                                                                  }
                                                                },
                                                                child: Text(
                                                                  Applocalizations.of(
                                                                          context)
                                                                      .translate(
                                                                          "cancel_book"),
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
                                                            width: width * 0.4,
                                                          )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Provider.of<RequestPropertyProvider>(
                                                      context)
                                                  .isLoading()
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                  backgroundColor: fBlue,
                                                ))
                                              : Center(
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
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      BookScreen(
                                                                        property:
                                                                            widget.property,
                                                                        singleProperty: Provider.of<SinglePropertyProvider>(context)
                                                                            .singleProperty
                                                                        ,
                                                                      )));

                                                      // _showDialog(context, widget.property);
                                                      // final DateTime picked = await showDatePicker(
                                                      //   fieldHintText: "from",
                                                      //     context: context,
                                                      //     initialDate:
                                                      //         DateTime.now(),
                                                      //     firstDate:
                                                      //         DateTime(2000),
                                                      //     lastDate:
                                                      //         DateTime(2025));
                                                      //
                                                      // if (picked != null && picked != fromDate){
                                                      //   setState(() {
                                                      //     fromDate = picked;
                                                      //   });
                                                      //
                                                      //   print('fromDate '+ fromDate.toString());
                                                      // }

                                                      // Provider.of<RequestPropertyProvider>(
                                                      //     context,
                                                      //     listen: false)
                                                      //     .requestProperty(
                                                      //     singleProperty.id
                                                      //         .toString()
                                                      //         .trim());
                                                      // bool booked = await Provider
                                                      //     .of<RequestPropertyProvider>(
                                                      //     context,
                                                      //     listen: false)
                                                      //     .succressResponse !=
                                                      //     null;
                                                      // if (booked) {
                                                      //   Provider.of<SinglePropertyProvider>(context,listen: false).singleProperty.isBooked=true;
                                                      //   final snackBar = SnackBar(
                                                      //       content: Text(Provider
                                                      //           .of<RequestPropertyProvider>(
                                                      //           context)
                                                      //           .succressResponse
                                                      //           .success));
                                                      //
                                                      //   Scaffold.of(context)
                                                      //       .showSnackBar(snackBar);
                                                      // }
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
                                                )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        // Container(
                        //   height: MediaQuery.of(context).size.height,
                        //   width: MediaQuery.of(context).size.width,
                        //   // child: ListView(
                        //   //   // physics: ClampingScrollPhysics(),
                        //   //    shrinkWrap: true,
                        //   // // crossAxisAlignment: CrossAxisAlignment.start,
                        //   //   children: [
                        //   //
                        //   //   ],
                        //   // ),
                        // ),

                        ,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18.0,
                            vertical: 8.0,
                          ),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            Applocalizations.of(context).translate("comments"),
                            style: TextStyle(color: fBlue, fontSize: 20),
                          ),
                        ),

                        Provider.of<CommentsProvider>(context).isLoading()
                            ? Center(
                                child: CircularProgressIndicator(
                                backgroundColor: darkBlue,
                              ))
                            : (Provider.of<CommentsProvider>(context)
                                    .commentsList
                                    .isEmpty
                                ? Container()
                                : Comments(
                                    commentsResponse:
                                        Provider.of<CommentsProvider>(context)
                                            .commentsResponse,
                                    propertyInfo: widget.singleProperty,
                                    commentList:
                                        Provider.of<CommentsProvider>(context)
                                            .commentsList,
                                  )),

                        AddNewComment(
                          propertyId: widget.property.id,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        horizantalLine(),
                        ContactHostScreen(
                          propertyId: widget.property.id,
                        ),
                      ]),
                    ),
                    // SliverToBoxAdapter(
                    //     child: Container(
                    //   height: MediaQuery.of(context).size.height,
                    //   width: MediaQuery.of(context).size.width,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Text(
                    //              singleProperty.title ,
                    //               style: TextStyle(
                    //                   color: Colors.black87, fontSize: 20),
                    //             ),
                    //             Text(
                    //               singleProperty.price.toString(),
                    //               style: TextStyle(
                    //                   color: Colors.black87, fontSize: 30),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //           horizontal: 8,
                    //         ),
                    //         child: Row(
                    //           children: [
                    //
                    //             Icon(
                    //               Icons.location_on,
                    //               size: 18,
                    //               color: Theme.of(context).primaryColor,
                    //             ),
                    //             Text(
                    //              singleProperty.address,
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.w300, fontSize: 12),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       // SizedBox(
                    //       //   height: 10,
                    //       // ),
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //           horizontal: 18.0,
                    //           vertical: 8.0,
                    //         ),
                    //         child: Divider(
                    //           thickness: 1,
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 2,
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //             vertical: 2, horizontal: 8),
                    //         child: Text(
                    //           'Summary',
                    //           style: TextStyle(
                    //               fontSize: 18, fontWeight: FontWeight.w600),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 10,
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //             vertical: 2, horizontal: 8),
                    //         child: RichText(
                    //           text: TextSpan(
                    //               style: TextStyle(color: Colors.grey[600]),
                    //               children: <TextSpan>[
                    //                 TextSpan(
                    //                   text:
                    //                       singleProperty.description,
                    //                 ),
                    //                 TextSpan(
                    //                     text: ' read more',
                    //                     style: TextStyle(
                    //                       color: Theme.of(context).primaryColor,
                    //                     ))
                    //               ]),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 10,
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //             horizontal: 18, vertical: 8),
                    //         child: Divider(
                    //           thickness: 1,
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 10,
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //             horizontal: 8.0, vertical: 5),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Text(
                    //               'Photos',
                    //               style: TextStyle(
                    //                   fontSize: 18, fontWeight: FontWeight.w600),
                    //             ),
                    //             Row(
                    //               children: [
                    //                 Text(
                    //                   'See All',
                    //                   style: TextStyle(
                    //                       color: Theme.of(context).primaryColor,
                    //                       fontWeight: FontWeight.w600),
                    //                 ),
                    //                 Icon(
                    //                   Icons.navigate_next,
                    //                   color: Theme.of(context).primaryColor,
                    //                 )
                    //               ],
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //       Container(
                    //         height: MediaQuery.of(context).size.height / 5,
                    //         child: ListView.builder(
                    //           itemCount: bestDeals.length,
                    //           scrollDirection: Axis.horizontal,
                    //           itemBuilder: (BuildContext context, int index) {
                    //             var destination = bestDeals[index];
                    //             return Container(
                    //               margin: EdgeInsets.symmetric(
                    //                   vertical: 10.0, horizontal: 5),
                    //               width: 200,
                    //               child: Card(
                    //                 elevation: 2,
                    //                 shape: RoundedRectangleBorder(
                    //                   borderRadius: BorderRadius.circular(15),
                    //                 ),
                    //                 color: Colors.blue,
                    //                 child: Stack(
                    //                   alignment: Alignment.bottomLeft,
                    //                   children: [
                    //                     ClipRRect(
                    //                       borderRadius: BorderRadius.circular(15),
                    //                       child: Image.asset(
                    //                         destination.image,
                    //                         fit: BoxFit.cover,
                    //                         width: 300,
                    //                         height: MediaQuery.of(context)
                    //                                 .size
                    //                                 .height /
                    //                             6,
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             );
                    //           },
                    //         ),
                    //       ),
                    //       Center(
                    //         child: Padding(
                    //           padding: EdgeInsets.symmetric(
                    //               vertical: 20, horizontal: 25),
                    //           child: AspectRatio(
                    //             aspectRatio: 1.5,
                    //             child: Container(
                    //               child: Card(
                    //                 elevation: 5,
                    //                 shape: RoundedRectangleBorder(
                    //                   borderRadius: BorderRadius.circular(25),
                    //                 ),
                    //                 child: Column(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   children: [
                    //                     Center(
                    //                       child: Padding(
                    //                         padding: const EdgeInsets.symmetric(
                    //                           horizontal: 0,
                    //                           vertical: 8.0,
                    //                         ),
                    //                         child: Text(
                    //                           'Details',
                    //                           style: TextStyle(
                    //                             color: Theme.of(context)
                    //                                 .primaryColor,
                    //                             fontSize: 18,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     SizedBox(
                    //                       height: 20,
                    //                     ),
                    //                     Padding(
                    //                       padding: const EdgeInsets.symmetric(
                    //                           horizontal: 15),
                    //                       child: Row(
                    //                           mainAxisAlignment:
                    //                               MainAxisAlignment.spaceBetween,
                    //                           children: [
                    //                             Text('Number of Rooms',
                    //                                 style: TextStyle(
                    //                                   fontSize: 15,
                    //                                   fontWeight: FontWeight.w600,
                    //                                 )),
                    //                             Text(
                    //                               '2',
                    //                               style: TextStyle(
                    //                                 color: Theme.of(context)
                    //                                     .primaryColor,
                    //                                 fontWeight: FontWeight.w600,
                    //                               ),
                    //                             ),
                    //                           ]),
                    //                     ),
                    //                     SizedBox(
                    //                       height: 15.0,
                    //                     ),
                    //                     Padding(
                    //                       padding: const EdgeInsets.symmetric(
                    //                           horizontal: 15),
                    //                       child: Row(
                    //                           mainAxisAlignment:
                    //                               MainAxisAlignment.spaceBetween,
                    //                           children: [
                    //                             Text('Number of beds',
                    //                                 style: TextStyle(
                    //                                   fontSize: 15,
                    //                                   fontWeight: FontWeight.w600,
                    //                                 )),
                    //                             Text(
                    //                               '6',
                    //                               style: TextStyle(
                    //                                 color: Theme.of(context)
                    //                                     .primaryColor,
                    //                                 fontWeight: FontWeight.w600,
                    //                               ),
                    //                             ),
                    //                           ]),
                    //                     ),
                    //                     SizedBox(
                    //                       height: 35,
                    //                     ),
                    //                     Center(
                    //                       child: RaisedButton(
                    //                         padding: EdgeInsets.symmetric(
                    //                             horizontal: MediaQuery.of(context)
                    //                                     .size
                    //                                     .width /
                    //                                 4,
                    //                             vertical: 12),
                    //                         onPressed: () {
                    //                           // var list = widget.propertyInfo;
                    //                           // Navigator.push(
                    //                           //     context,
                    //                           //     MaterialPageRoute(
                    //                           //         builder: (context) => HouseScreen(
                    //                           //             propertyInfo: Property(
                    //                           //                 name: list.name,
                    //                           //                 image: list.image,
                    //                           //                 moreImages:
                    //                           //                     list.moreImages,
                    //                           //                 price: list.price,
                    //                           //                 propertType: list
                    //                           //                     .propertType,
                    //                           //                 location:
                    //                           //                     list.location,
                    //                           //                 shortAddress: list
                    //                           //                     .shortAddress,
                    //                           //                 rating:
                    //                           //                     list.rating))));
                    //                         },
                    //                         child: Text(
                    //                           'Book Now',
                    //                           style: TextStyle(
                    //                             fontWeight: FontWeight.bold,
                    //                             fontSize: 15,
                    //                             color: Colors.white,
                    //                           ),
                    //                         ),
                    //                         color: Theme.of(context).primaryColor,
                    //                         shape: RoundedRectangleBorder(
                    //                             borderRadius:
                    //                                 BorderRadius.circular(15)),
                    //                       ),
                    //                     )
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // )),
                  ],
                ),
              ),
      ),
    );
  }

  void _showDialog(BuildContext context, Datum property) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                property.title,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Image(
                      image: NetworkImage(property.thumbnail),
                      fit: BoxFit.fill,
                      // height: double.infinity,
                      width: double.infinity,
                      // alignment: Alignment.center,
                    ),
                    width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(
                    height: 20,
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
                                child: RaisedButton(
                                  onPressed: () async {
                                    final DateTime picked =
                                        await showDatePicker(
                                            fieldHintText: "from",
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2025));

                                    if (picked != null && picked != fromDate) {
                                      Provider.of<DateProvider>(context,
                                              listen: false)
                                          .setFromDate(picked
                                              .toString()
                                              .substring(0, 10));
                                      setState(() {
                                        // fromText = picked.toString().substring(0,10);
                                        fromDate = picked;
                                      });
                                    }
                                    print('fromDate ' + fromDate.toString());
                                  },
                                  child: Text(
                                    Applocalizations.of(context)
                                        .translate("start-date"),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                  color: Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.4,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              Provider.of<DateProvider>(context)
                                          .getFromDate() ==
                                      null
                                  ? ""
                                  : Provider.of<DateProvider>(context).fromDate,
                              style: TextStyle(fontSize: 15, color: fBlue),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              child: Center(
                                child: RaisedButton(
                                  onPressed: () async {
                                    final DateTime picked =
                                        await showDatePicker(
                                            fieldHintText: "to",
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2025));

                                    if (picked != null && picked != toDate) {
                                      Provider.of<DateProvider>(context,
                                              listen: false)
                                          .setToDate(picked
                                              .toString()
                                              .substring(0, 10));
                                      setState(() {
                                        toText =
                                            picked.toString().substring(0, 10);
                                        toDate = picked;
                                        // toText = toDate.toString().substring(0,10);
                                      });
                                    }
                                    print('toData ' + toDate.toString());
                                  },
                                  child: Text(
                                    toText != ''
                                        ? toText
                                        : Applocalizations.of(context)
                                            .translate("end-date"),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                  color: Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.4,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              Provider.of<DateProvider>(context).getToDate() ==
                                      null
                                  ? ""
                                  : Provider.of<DateProvider>(context)
                                      .getToDate(),
                              style: TextStyle(fontSize: 15, color: fBlue),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class FullScreenCustomSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  // Property propertyInfo;
  SingleProperty propertyInfo;

  FullScreenCustomSliverAppBar(
      {@required this.expandedHeight, this.propertyInfo});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Image.network(
          propertyInfo.thumbnail,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: expandedHeight / 1.8 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 14,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Color(0xc95797c4),
                elevation: 10,
                child: SizedBox(
                    height: expandedHeight / 3.5,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: width * 0.7,
                                child: AutoSizeText(
                                  propertyInfo.title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Theme.of(context).primaryColor,
                                size: 15,
                              ),
                              Text(
                                propertyInfo.address,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            ],
                          ),
                          // SizedBox(
                          //   height: 15,
                          // ),
                          // Text(
                          //   'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor nulla pariatur. Excepteur sint ',
                          //   style: TextStyle(
                          //       color: Theme.of(context).primaryColor,
                          //       fontSize: 15,
                          //       fontWeight: FontWeight.w500),
                          // ),
                          SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: FlatButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 4,
                                  vertical: 12),
                              onPressed: () {
                                // var list = propertyInfo;
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => HouseScreen(
                                //             propertyInfo: Property(
                                //                 name: list.name,
                                //                 image: list.image,
                                //                 moreImages: list.moreImages,
                                //                 price: list.price,
                                //                 propertType: list.propertType,
                                //                 location: list.location,
                                //                 shortAddress: list.shortAddress,
                                //                 rating: list.rating))));
                              },
                              child: Text(
                                Provider.of<SinglePropertyProvider>(context)
                                            .singleProperty
                                            .sellingType ==
                                        0
                                    ? Applocalizations.of(context)
                                        .translate("for-rent")
                                    : Applocalizations.of(context)
                                        .translate("for-sell"),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            ),
          ),
        ),
        Positioned(
            top: 15,
            left: 15,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.94,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Provider.of<AddToFavProvider>(context).isLoading()
                      ? CircularProgressIndicator(
                          backgroundColor: fBlue,
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Center(
                            child: IconButton(
                              icon: Icon(
                                Icons.favorite_border,
                              ),
                              onPressed: () async {
                                bool added =
                                    await Provider.of<AddToFavProvider>(context,
                                            listen: false)
                                        .addToFav(propertyInfo.id.toString());
                                if (added) {
                                  _showToast(context);
                                }
                              },
                            ),
                          ),
                        ),
                ],
              ),
            ))
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

Widget horizantalLine() {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 18.0,
      vertical: 8.0,
    ),
    child: Divider(
      thickness: 1,
    ),
  );
}
//
// RichText(
// text: TextSpan(
// style: TextStyle(color: Colors.grey[600]),
// children: <TextSpan>[
// TextSpan(
// text: singleProperty.description,
// ),
// ]),
// ),

void _showToast(BuildContext context) {
  final scaffold = Scaffold.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(Applocalizations.of(context).translate("added-to-fav")),
    ),
  );
}
