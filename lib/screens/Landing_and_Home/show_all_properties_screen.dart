import 'package:aqar_bazar/localization/app_localization.dart';
import 'package:aqar_bazar/providers/all_properties_provider.dart';
import 'package:aqar_bazar/providers/show_all_properties_provider.dart';
import 'package:aqar_bazar/providers/user_requests_provider.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/widgets/best_deals.dart';
import 'package:aqar_bazar/screens/my_bookings/requested_item_card.dart';
import 'package:aqar_bazar/screens/property/property.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';


class ShowAllProperties extends StatefulWidget {

  @override
  _ShowAllPropertiesState createState() => _ShowAllPropertiesState();
}

class _ShowAllPropertiesState extends State<ShowAllProperties> {
  String title = 'All Properties';
  int page = 1;
  String prevTitle = '';
  List<String> items;
  List<String> duplicateItems;
  TextEditingController textController;
  ScrollController con;
  final itemSize = 80.0;

  @override
  void initState() {
    super.initState();


    Provider.of<ShowAllPropertiesProvider>(context,listen: false).getAllProperties(1);
    textController = TextEditingController();
    prevTitle = title;
    con = ScrollController();
    con.addListener(() {
      if (con.offset >= con.position.maxScrollExtent &&
          !con.position.outOfRange) {

        Provider.of<ShowAllPropertiesProvider>(context,listen: false).getAllProperties(page+=1);
        setState(() {

        });
      }else if (con.offset <= con.position.minScrollExtent &&
          !con.position.outOfRange) {
        setState(() {

        });
      } else {
        setState(() {

        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var allPropertiesProvider = Provider.of<ShowAllPropertiesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('All Properties'),
      ),
      body:
      allPropertiesProvider.isFirstLoading()?Center(child: CircularProgressIndicator(backgroundColor: darkBlue,)):
      Column(
        children: <Widget>[

          Expanded(
            child: ListView.builder(
              controller: con,
              // itemExtent: itemSize,
              itemCount: allPropertiesProvider.propertiesList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PropertyPage(
                              property:  allPropertiesProvider.propertiesList[index],
                            )));
                  },
                  child: DealsCard(
                    propertyData: allPropertiesProvider.propertiesList[index],
                  ),
                );
              },
            ),
          ),
          allPropertiesProvider.isLoading()? Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(backgroundColor: darkBlue,),
          ):Container()
        ],
      ),

    );
  }

  void dispose(){
    // Don't forget to dispose the ScrollController.
    con.dispose();
    super.dispose();
  }

}
