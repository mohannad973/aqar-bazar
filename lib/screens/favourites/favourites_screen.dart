

import 'package:aqar_bazar/localization/app_localization.dart';
import 'package:aqar_bazar/providers/favourites_provider.dart';
import 'package:aqar_bazar/providers/user_requests_provider.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/widgets/best_deals.dart';
import 'package:aqar_bazar/screens/my_bookings/requested_item_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class FavouritesScreen extends StatefulWidget {
  final List<String> items = List<String>.generate(50, (i) => "Item $i");

  @override
  _FavouritesScreen createState() => _FavouritesScreen();
}

class _FavouritesScreen extends State<FavouritesScreen> {
  String title = '';
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
    Provider.of<FavouritesProvider>(context, listen: false).getFav(page: 1);
    items = widget.items;
    duplicateItems = List.from(items);
    textController = TextEditingController();
    prevTitle = title;
    con = ScrollController();
    con.addListener(() {
      if (con.offset >= con.position.maxScrollExtent &&
          !con.position.outOfRange) {
        Provider.of<FavouritesProvider>(context, listen: false)
            .getFav(page: page += 1);
        setState(() {});
      } else if (con.offset <= con.position.minScrollExtent &&
          !con.position.outOfRange) {
        setState(() {});
      } else {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var favouritesProvider = Provider.of<FavouritesProvider>(context,listen:true);

    return Scaffold(
      appBar: AppBar(
        title: Text(Applocalizations.of(context).translate("favourites")),
      ),
      body: favouritesProvider.isFirstLoading()
          ? Center(
              child: CircularProgressIndicator(
              backgroundColor: darkBlue,
            ))
          : favouritesProvider.data.isEmpty
              ? Center(
                  child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset('assets/images/empty-box.png'),
                        height: 200,
                        width: 200,
                      ),
                      Container(
                        child: Text(
                          'Your Favourites list is Empty',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ))
              : Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        controller: con,
                        // itemExtent: itemSize,
                        itemCount: favouritesProvider.data.length,
                        itemBuilder: (context, index) {
                          return DealsCard(
                            fav: true,
                            propertyData: favouritesProvider.data[index],
                          );
                          // return RequestedItemCard(request: userRequestProvider.allRequestsList[index],itemIndex: index,);
                        },
                      ),
                    ),
                    favouritesProvider.isLoading()
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              backgroundColor: darkBlue,
                            ),
                          )
                        : Container()
                  ],
                ),
    );
  }

  void dispose() {
    // Don't forget to dispose the ScrollController.
    con.dispose();
    super.dispose();
  }
}
