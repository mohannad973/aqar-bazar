import 'package:aqar_bazar/Common_Widgets/common_widgets.dart';
import 'package:aqar_bazar/models/best_deals_model.dart';
import 'package:aqar_bazar/screens/Property%20types/house.dart';
import 'package:aqar_bazar/screens/property_list_screen/property_item_card.dart';
import 'package:aqar_bazar/screens/property_list_screen/property_model.dart';
import 'package:flutter/material.dart';

import '../property.dart';

class PropertyListScreen extends StatefulWidget {
  @override
  _PropertyListScreenState createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen> {
  List<PropertyModel> property = [
    PropertyModel("assets/images/beechwood-home.png", "name", "description", "location", 5, 2, 250.0, 3.5),
    PropertyModel(
        "image", "name2", "description", "location", 5, 2, 250.0, 3.5),
    PropertyModel("image", "name", "description", "location", 5, 2, 250.0, 3.5),
    PropertyModel(
        "image", "name2", "description", "location", 5, 2, 250.0, 3.5),
    PropertyModel("image", "name", "description", "location", 5, 2, 250.0, 3.5),
    PropertyModel(
        "image", "name2", "description", "location", 5, 2, 250.0, 3.5),
    PropertyModel("image", "name", "description", "location", 5, 2, 250.0, 3.5),
    PropertyModel(
        "image", "name2", "description", "location", 5, 2, 250.0, 3.5),
  ];

  List<String> images = ["assets/images/beechwood-home.png","assets/images/building2.jpg","assets/images/explore_list_images/hotel1.png","assets/images/explore_list_images/hotel14.jpeg"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: buildAppBarWithText(context,"Property Details"),
      body: Container(

        child: ListView.builder(
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  var list = bestDeals[index];
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HouseScreen(
                              propertyInfo: Property(
                                  name: list.name,
                                  image: list.image,
                                  moreImages:
                                  list.moreImages,
                                  price: list.price,
                                  propertType:
                                  list.propertType,
                                  location: list.location,
                                  shortAddress:
                                  list.shortAddress,
                                  rating: list.rating))));
                },
                child: propertyCard(context,images[index]),

              ),
            );
          },
        ),
      ),
    );


  }
}
