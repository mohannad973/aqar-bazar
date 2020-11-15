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
                  return RequestedItemCard(request: userRequestProvider.allRequestsList[index],);
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

  Widget rowButtons() => Container(
    height: 50.0,
    color: Colors.blue,
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RaisedButton(
            child: Text("up"),
            onPressed: () {
              con.animateTo(con.offset - itemSize,
                  curve: Curves.linear,
                  duration: Duration(milliseconds: 500));
//                  con.jumpTo(con.offset - itemSize);
            },
          ),
          RaisedButton(
            child: Text("down"),
            onPressed: () {
              con.animateTo(con.offset + itemSize,
                  curve: Curves.linear,
                  duration: Duration(milliseconds: 500));
//                  con.jumpTo(con.offset + itemSize);
            },
          )
        ],
      ),
    ),
  );

  Widget searchField() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      onChanged: (value) {
        filterSearchResults(value);
      },
      controller: textController,
      decoration: InputDecoration(
          labelText: "Search",
          hintText: "Search",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)))),
    ),
  );

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }
}
