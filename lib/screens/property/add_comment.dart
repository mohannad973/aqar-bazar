import 'package:aqar_bazar/constants.dart';
import 'package:aqar_bazar/models/comments_response.dart';
import 'package:aqar_bazar/models/single_property_response.dart';
import 'package:aqar_bazar/providers/add_comment_provider.dart';
import 'package:aqar_bazar/screens/filter/search_result_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewComment extends StatefulWidget {
  int propertyId;
  Function addComment;

  AddNewComment({this.propertyId,this.addComment});

  @override
  _AddNewCommentState createState() => _AddNewCommentState();
}

class _AddNewCommentState extends State<AddNewComment> {
  final TextEditingController commentController = TextEditingController();

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
            'Leave a comment', style: TextStyle(color: fBlue, fontSize: 15),),
        ),
        Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: commentController,
                decoration: InputDecoration(
                  hintText: 'add comment',
                  labelText: "Add Comment",
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
        Provider.of<AddComentProvider>(context).isLoading()?Center(child: CircularProgressIndicator(backgroundColor: darkBlue,)):
        Container(
          child: Center(
            child: RaisedButton(
              onPressed: () {
                    Provider.of<AddComentProvider>(context,listen: false).addComment(widget.propertyId.toString(), commentController.text);
                    if(Provider.of<AddComentProvider>(context).message!= null){
                      widget.addComment(Comment(id: 0,comment: commentController.text,createdAt: DateTime.now(),humanTime: '',totalLikes: 0));
                    }
              },
              child: Text(
                'Comment',
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
