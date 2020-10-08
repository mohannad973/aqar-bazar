import 'package:aqar_bazar/Utils/colors.dart';
import 'package:aqar_bazar/models/best_deals_model.dart';
import 'package:aqar_bazar/screens/property_list_screen/property_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:aqar_bazar/Utils/decorations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HouseScreen extends StatefulWidget {
  Property propertyInfo;
  HouseScreen({this.propertyInfo});
  @override
  _HouseScreenState createState() => _HouseScreenState();
}

class _HouseScreenState extends State<HouseScreen> {
  Color bookIconBackgroundColor = Colors.white;
  Color _bookIconColor;

  @override
  Widget build(BuildContext context) {
    var info = widget.propertyInfo;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 15.0,
              ),
              child: CircleAvatar(
                backgroundColor: bookIconBackgroundColor,
                child: IconButton(
                  icon: Icon(Icons.book, color: _bookIconColor),
                  onPressed: () {
                    setState(() {});
                  },
                ),
              ),
            )
          ],
          // backgroundColor: Colors.transparent,
          // iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          title: Text(
            'Property Info',
            style: TextStyle(
              fontSize: 18,
              // color: Colors.black,
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ImageSlider(),
            ),
            SizedBox(height: 15),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(

                    widget.propertyInfo.name,
                    style: textStyleSemiBold()
                        .copyWith(color: Colors.black, fontSize: 28),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Theme.of(context).primaryColor,
                        ),
                        Text(info.location),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.black87,
                              offset: Offset(2, 4),
                            ),
                          ]),
                      width: width,
                      height: height / 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Price',
                                  style: textStyleSemiBold(),
                                ),
                                Text(
                                  widget.propertyInfo.price,
                                  style: textStyleSemiBold().copyWith(
                                    color: iconColor(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(),
                            Center(
                                child: Text('Details',
                                    style: textStyleSemiBold())),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  iconTextRow(
                                    FontAwesomeIcons.bed,
                                    '4',
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  iconTextRow(
                                      FontAwesomeIcons.utensilSpoon, '1'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  iconTextRow(
                                      FontAwesomeIcons.bookMedical, '2'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  iconTextRow(
                                      FontAwesomeIcons.video, 'Available'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  iconTextRow(
                                      FontAwesomeIcons.shieldAlt, 'N/A'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  iconTextRow(
                                      FontAwesomeIcons.broom, 'Available'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  iconTextRow(FontAwesomeIcons.dungeon, 'N/A'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  iconTextRow(
                                      FontAwesomeIcons.parking, 'Available'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: RaisedButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width / 4,
                                    vertical: 12),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PropertyListScreen()));
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
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Row iconTextRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor(),
          size: 22,
        ),
        SizedBox(
          width: 12,
        ),
        Text(
          text,
          style: TextStyle(
            color: numbersColor(),
          ),
        )
      ],
    );
  }
}

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext contextn, int index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.asset(
            bestDeals[index].image,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            fit: BoxFit.fitHeight,
          ),
        );
      },
      itemCount: bestDeals.length,
      viewportFraction: 0.8,
      itemHeight: MediaQuery.of(context).size.height / 2,
      itemWidth: MediaQuery.of(context).size.width,
      pagination: SwiperPagination(
        builder: DotSwiperPaginationBuilder(
          activeColor: iconColor(),
        ),
        margin: EdgeInsets.all(50),
      ),
      autoplay: true,
      layout: SwiperLayout.TINDER,
    );
  }
}
