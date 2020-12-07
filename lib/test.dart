import 'package:aqar_bazar/providers/user_requests_provider.dart';
import 'package:aqar_bazar/screens/my_bookings/requested_item_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'localization/app_localization.dart';
class TestScreen extends StatefulWidget {
  final List<String> items= List<String>.generate(50, (i) => "Item $i");
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String title = 'My Requested Properties';
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
    Provider.of<UserRequestProvider>(context,listen: false).getAllRequests(1);
    items = widget.items;
    duplicateItems = List.from(items);
    textController = TextEditingController();
    prevTitle = title;
    con = ScrollController();
    con.addListener(() {
      if (con.offset >= con.position.maxScrollExtent &&
          !con.position.outOfRange) {

        Provider.of<UserRequestProvider>(context,listen: false).getAllRequests(page+=1);
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
    var userRequestProvider = Provider.of<UserRequestProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

      return Scaffold(
        appBar: AppBar(
          title: Text(Applocalizations.of(context).translate("my_requested_property")),
        ),
        body:
        userRequestProvider.isFirstLoading()?Center(child: CircularProgressIndicator(backgroundColor: darkBlue,)):
        userRequestProvider.allRequestsList.isEmpty?
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height:height-200 ,
              width: width,
              child: Image.asset('assets/images/empty-lst.jpg'),
            ),
            Text(Applocalizations.of(context).translate('empty-request'))
          ],
        )
            :
        Column(
          children: <Widget>[

            Expanded(
              child: ListView.builder(
                controller: con,
                // itemExtent: itemSize,
                itemCount: userRequestProvider.allRequestsList.length,
                itemBuilder: (context, index) {
                  return RequestedItemCard(request: userRequestProvider.allRequestsList[index],itemIndex: index,);
                },
              ),
            ),
            userRequestProvider.isLoading()? Padding(
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
