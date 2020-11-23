import 'package:aqar_bazar/constants.dart';
import 'package:aqar_bazar/localization/app_localization.dart';
import 'package:aqar_bazar/models/best_deals_model.dart';
import 'package:aqar_bazar/providers/search_result_provider.dart';
import 'package:aqar_bazar/providers/user_requests_provider.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/widgets/best_deals.dart';
import 'package:aqar_bazar/screens/filter/search_result_model.dart';
import 'package:aqar_bazar/screens/my_bookings/requested_item_card.dart';
import 'package:aqar_bazar/screens/property/property.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResultScreen extends StatefulWidget {
  List<Datum> searchList ;
  String type;
  String furnished;
  String price;
  String capacity;
  String rooms;

  SearchResultScreen({this.searchList,this.furnished,this.type,this.price,this.capacity,this.rooms});

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  String title = 'Search Result';
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


    textController = TextEditingController();
    prevTitle = title;
    con = ScrollController();
    con.addListener(() {
      if (con.offset >= con.position.maxScrollExtent &&
          !con.position.outOfRange) {

         Provider.of<SearchResultProvider>(context,listen: false).filter(furnished: widget.furnished,type: widget.type,rooms: widget.rooms,capacity: widget.capacity,price: widget.price,page: page+1);
        setState(() {

          //title = "reached the bottom";
        });
      }else if (con.offset <= con.position.minScrollExtent &&
          !con.position.outOfRange) {
        setState(() {
         // title = "reached the top";
        });
      } else {
        setState(() {
         // title = prevTitle;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var searchProvider = Provider.of<SearchResultProvider>(context);

    return Scaffold(
      backgroundColor: widget.searchList ==null?Colors.white:null,
      appBar: AppBar(
        title: Text(Applocalizations.of(context).translate("search_result")),
      ),
      body:

      searchProvider.isFirstLoading()?Center(child: CircularProgressIndicator(backgroundColor: darkBlue,)):
          searchProvider.filterData.isEmpty?Center(child: Container(child: Image.asset('assets/images/emtysearch.png'),)):
      Column(
        children: <Widget>[

          Expanded(
            child: ListView.builder(
              controller: con,
              // itemExtent: itemSize,
              itemCount: searchProvider.filterData.length,
              itemBuilder: (context, index) {
                // return RequestedItemCard(request: searchProvider.filterData[index],itemIndex: index,);
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PropertyPage(
                              property: searchProvider.filterData[index]
                            )));
                  },
                    child: DealsCard(propertyData: searchProvider.filterData[index],));
              },
            ),
          ),
          searchProvider.isLoading()? Padding(
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
