import 'package:aqar_bazar/constants.dart';
import 'package:aqar_bazar/localization/app_localization.dart';
import 'package:aqar_bazar/providers/user_requests_provider.dart';
import 'package:aqar_bazar/screens/my_bookings/requested_item_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
class MyBookingsScreen extends StatefulWidget {

  @override
  _MyBookingsScreenState createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  ScrollController _controller;

  String message='lnlknl';

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      print('scrollTest1');
      setState(() {
        message = "reach the bottom";
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent ) {
      print('scrollTest2');
      setState(() {

        message = "reach the top";
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    _controller = ScrollController();
    // _controller.addListener(_scrollListener);
    _controller.addListener(() {
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        print('scrollTest1');
        setState(() {
          message = "reached the bottom";
        });
      }else if (_controller.offset <= _controller.position.minScrollExtent &&
          !_controller.position.outOfRange) {
        print('scrollTest2');

        setState(() {
          message = "reached the top";
        });
      } else {
        setState(() {
          message = 'last else';
        });
      }
    });
    super.initState();

    Provider.of<UserRequestProvider>(context,listen: false).getAllRequests(1);
  }

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var userRequestProvider = Provider.of<UserRequestProvider>(context);
    return Scaffold(

      appBar: AppBar(title: Text(Applocalizations.of(context).translate("my_requested_property"),),),
      body:
          userRequestProvider.isLoading()?Center(child: CircularProgressIndicator(backgroundColor: darkBlue,)):
              userRequestProvider.allRequestsList.isEmpty?Center(child: Container(

                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(child: Image.asset('assets/images/empty-box.png'),height: 200,width: 200,),
                    Container(child: Text('Your Favourites list is Empty',style: TextStyle(fontSize: 20,color: Colors.black),),),
                  ],
                ),
              )):

      SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          child: ListView.builder(
              controller: _controller,
               shrinkWrap: true,
              itemCount: userRequestProvider.allRequestsList.length,
              itemBuilder: (BuildContext context, int index) {
              return RequestedItemCard(request: userRequestProvider.allRequestsList[index],);
              }),
        ),
      ),
    );
  }
}
