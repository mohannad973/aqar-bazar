import 'package:aqar_bazar/models/best_deals_model.dart';
import 'package:aqar_bazar/models/places.dart';
import 'file:///E:/hashtag%20progects/aqar/lib/screens/property/property.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BestDeals extends StatelessWidget {
  const BestDeals({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _blackBold = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
      fontSize: 20,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Best Deals",
            style: _blackBold,
          ),
        ),
        Container(
            padding: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              itemCount: bestDeals.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    // var list = bestDeals[index];
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => PropertyPage(
                    //               propertyInfo: Property(
                    //                 name: list.name,
                    //                 image: list.image,
                    //                 location: list.location,
                    //                 shortAddress: list.shortAddress,
                    //                 price: list.price,
                    //                 propertType: list.propertType,
                    //               ),
                    //             )));
                  },
                  child: Container(
                      child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              bestDeals[index].image,
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.hotel,
                                    size: 15,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    bestDeals[index].name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Text(
                                bestDeals[index].price,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 15,
                                    color: Colors.red[900],
                                  ),
                                  Text(bestDeals[index].shortAddress,
                                      style: TextStyle(color: Colors.red[900])),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 15,
                                    color: Colors.green[600],
                                  ),
                                  Text(
                                    bestDeals[index].rating,
                                    style: TextStyle(color: Colors.green[600]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                );
              },
            ))
      ],
    );
  }
}
