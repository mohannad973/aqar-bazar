import 'package:aqar_bazar/providers/category_list_provider.dart';
import 'package:aqar_bazar/providers/search_result_provider.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/widgets/best_deals.dart';
import 'package:aqar_bazar/screens/filter/search_result_model.dart';
import 'package:aqar_bazar/screens/property/property.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class PropertiesByTypeScreen extends StatefulWidget {
  int propertyType;
  List<Datum> propertiesList;
  String propertyTypeName;

  PropertiesByTypeScreen({this.propertyType,this.propertyTypeName});

  @override
  _PropertiesByTypeScreenState createState() => _PropertiesByTypeScreenState();
}

class _PropertiesByTypeScreenState extends State<PropertiesByTypeScreen> {
  ScrollController con;
  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CategoryListProvider>(context,listen: false).getPropertyByType(category: widget.propertyType.toString(),page: 1);
    con = ScrollController();
    con.addListener(() {
      if (con.offset >= con.position.maxScrollExtent &&
          !con.position.outOfRange) {

        Provider.of<CategoryListProvider>(context,listen: false).getPropertyByType(category: widget.propertyType.toString(),page: page+1);
        setState(() {

          //title = "reached the bottom";
        });
      }else if (con.offset <= con.position.minScrollExtent &&
          !con.position.outOfRange) {

      } else {

      }
    });

  }
  @override
  Widget build(BuildContext context) {
    var propertiesProvider = Provider.of<CategoryListProvider>(context);
    return Scaffold(
      backgroundColor: propertiesProvider.data ==null?Colors.white:null,
      appBar: AppBar(
        title: Text(widget.propertyTypeName),
      ),
      body:

      propertiesProvider.isFirstLoading()?Center(child: CircularProgressIndicator(backgroundColor: darkBlue,)):
      propertiesProvider.data.isEmpty?Center(child: Container(child: Image.asset('assets/images/emtysearch.png'),)):
      Column(
        children: <Widget>[

          Expanded(
            child: ListView.builder(
              controller: con,
              // itemExtent: itemSize,
              itemCount: propertiesProvider.data.length,
              itemBuilder: (context, index) {
                // return RequestedItemCard(request: searchProvider.filterData[index],itemIndex: index,);
                return GestureDetector(
                    onTap: (){
                      print('rr1 '+propertiesProvider.data[index].toString());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PropertyPage(
                                  property: propertiesProvider.data[index]
                              )));
                    },
                    child: DealsCard(propertyData: propertiesProvider.data[index],));
              },
            ),
          ),
          propertiesProvider.isLoading()? Padding(
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
