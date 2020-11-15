import 'package:aqar_bazar/constants.dart';
import 'package:aqar_bazar/models/comments_response.dart';
import 'package:aqar_bazar/models/single_property_response.dart';
import 'package:aqar_bazar/providers/add_comment_provider.dart';
import 'package:aqar_bazar/providers/comments_provider.dart';
import 'package:aqar_bazar/providers/contact_host_provider.dart';
import 'package:aqar_bazar/screens/filter/search_result_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactHostScreen extends StatefulWidget {
  int propertyId;

   ContactHostScreen({
    this.propertyId,
    Key key,
  }) : super(key: key);



  @override
  _ContactHostScreenState createState() => _ContactHostScreenState();
}

class _ContactHostScreenState extends State<ContactHostScreen> {
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Column(

      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Contact The Host', style: TextStyle(color: fBlue, fontSize: 15),),
        ),
        Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 5,
                controller: messageController,
                decoration: InputDecoration(
                  hintText: 'message',
                  labelText: "Contact Host",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide: new BorderSide(
                    ),
                  ),
                  //fillColor: Colors.green
                ),
              ),

            )
        ),
        Provider.of<ContactHostProvider>(context).isLoading()?Center(child: CircularProgressIndicator(backgroundColor: darkBlue,)):
        Container(
          child: Center(
            child: RaisedButton(
              onPressed: () {
                // print('comment message 1: '+Provider.of<AddComentProvider>(context,listen: false).message);
                // print('11111111');
                Provider.of<ContactHostProvider>(context,listen: false).contactHost(widget.propertyId.toString(), messageController.text);


                   _showToast(context) ;
                  // print('22222222');
                  // print('contact message : '+Provider.of<ContactHostProvider>(context).succsessResponse.success);



              },
              child: Text(
                'Send',
                style: TextStyle(
                  fontWeight:
                  FontWeight
                      .bold,
                  fontSize: 15,
                  color:
                  Colors.white,
                ),
              ),
              color:
              Theme
                  .of(context)
                  .primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius
                      .circular(
                      15)),
            ),
          ),
          width: width * 0.4,
        ),
      ],
    );
  }
}

void _showToast(BuildContext context) {
  final scaffold = Scaffold.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: const Text('Message Sent To Host'),
    ),
  );
}