import 'dart:ui';
import 'package:aqar_bazar/constants.dart';
import 'package:aqar_bazar/models/best_deals_model.dart';
import 'package:aqar_bazar/models/single_property_response.dart';
import 'package:aqar_bazar/providers/comments_provider.dart';
import 'package:aqar_bazar/providers/request_property_provider.dart';
import 'package:aqar_bazar/providers/single_property_provider.dart';
import 'package:aqar_bazar/screens/property/comments.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../Property types/house.dart';
import '../Property types/house.dart';
import '../Property types/house.dart';
import '../filter/search_result_model.dart';
import 'package:http/http.dart' as http;

class PropertyPage extends StatefulWidget {
  Property propertyInfo;
  Datum property;
  SingleProperty singleProperty;

  PropertyPage({this.property});

  @override
  _PropertyPageState createState() => _PropertyPageState();
}

class _PropertyPageState extends State<PropertyPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<SinglePropertyProvider>(context, listen: false)
        .getPropertyInfo(widget.property.viewLink);
    Provider.of<CommentsProvider>(context,listen: false).getComments(1, widget.property.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    var singleProperty =
        Provider.of<SinglePropertyProvider>(context).singleProperty;
    print('single property : ' + widget.property.viewLink);
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
                                      color: Colors.black87, fontSize: 20),
                                  maxLines: 2,
                                ),
                                width: width * 0.9,
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
                            'Summary',
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
                          child: RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.grey[600]),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: singleProperty.description,
                                  ),
                                ]),
                          ),
                        ),
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
                                'Photos',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'See All',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Theme.of(context).primaryColor,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 5,
                          child: ListView.builder(
                            itemCount: bestDeals.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              var destination = bestDeals[index];
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 5),
                                width: 200,
                                child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  color: Colors.blue,
                                  child: Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.asset(
                                          destination.image,
                                          fit: BoxFit.cover,
                                          width: 300,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              6,
                                        ),
                                      ),
                                    ],
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
                                            'Details',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Number of Bedrooms',
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
                                              Text('Number of Bathrooms',
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
                                        height: 15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Price',
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
                                        height: 35,
                                      ),
                                      singleProperty.isBooked
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
                                                            'already booked',
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
                                                    Container(
                                                      child: Center(
                                                        child: RaisedButton(
                                                          // padding: EdgeInsets.symmetric(
                                                          //     horizontal:
                                                          //     MediaQuery.of(context)
                                                          //         .size
                                                          //         .width /
                                                          //         4,
                                                          //     vertical: 12),
                                                          onPressed: () {},
                                                          child: Text(
                                                            'cancel book',
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
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Center(
                                              child: RaisedButton(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            4,
                                                    vertical: 12),
                                                onPressed: () async {
                                                  Provider.of<RequestPropertyProvider>(
                                                          context,
                                                          listen: false)
                                                      .requestProperty(
                                                          singleProperty.id
                                                              .toString()
                                                              .trim());
                                                  bool booked = await Provider
                                                              .of<RequestPropertyProvider>(
                                                                  context,
                                                                  listen: false)
                                                          .succressResponse !=
                                                      null;
                                                  if (booked) {
                                                    final snackBar = SnackBar(
                                                        content: Text(Provider
                                                                .of<RequestPropertyProvider>(
                                                                    context)
                                                            .succressResponse
                                                            .success));

                                                    Scaffold.of(context)
                                                        .showSnackBar(snackBar);
                                                  }
                                                },
                                                child: Text(
                                                  'Book Now',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
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
                            'Comments',
                            style: TextStyle(color: fBlue, fontSize: 20),
                          ),
                        ),
                      Provider.of<CommentsProvider>(context).isLoading()?Center(child: CircularProgressIndicator(backgroundColor: darkBlue,)):
                      Comments(commentsResponse: Provider.of<CommentsProvider>(context).commentsResponse,propertyInfo: widget.singleProperty,),
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
                color: Color(0x9499f9f9),
                elevation: 10,
                child: SizedBox(
                    height: expandedHeight / 3,
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
                                width: width * 0.8,
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
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor nulla pariatur. Excepteur sint ',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
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
                                'Book Now',
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
            child: CircleAvatar(
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
