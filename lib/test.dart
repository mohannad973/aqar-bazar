import 'package:aqar_bazar/providers/user_requests_provider.dart';
import 'package:aqar_bazar/screens/my_bookings/requested_item_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
class TestScreen extends StatefulWidget {
  final List<String> items= List<String>.generate(50, (i) => "Item $i");
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String title = 'Long List';
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

          title = "reached the bottom";
        });
      }else if (con.offset <= con.position.minScrollExtent &&
          !con.position.outOfRange) {
        setState(() {
          title = "reached the top";
        });
      } else {
        setState(() {
          title = prevTitle;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var userRequestProvider = Provider.of<UserRequestProvider>(context);

      return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body:
        userRequestProvider.isFirstLoading()?Center(child: CircularProgressIndicator(backgroundColor: darkBlue,)):
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
