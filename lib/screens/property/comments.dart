import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/models/comments_response.dart';
import 'package:aqar_bazar/models/single_property_response.dart';
import 'package:aqar_bazar/providers/comments_provider.dart';
import 'package:aqar_bazar/providers/like_comment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class Comments extends StatefulWidget {
  CommentsResponse commentsResponse;
  List<Comment> commentList;
  SingleProperty propertyInfo;

  Comments({this.commentsResponse, this.propertyInfo,this.commentList});

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  ScrollController _commentsScrolController = ScrollController();
  int pageNumber;
  bool initial = true;
  String likeBtn = 'like';


  getMoreComments(BuildContext context) {
    pageNumber += 1;
    if (!widget.commentsResponse.nextPageUrl == null) {
      Provider.of<CommentsProvider>(context, listen: false)
          .getComments(pageNumber + 1, widget.propertyInfo.id.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // Provider.of<LikeCommentProvider>(context).likeComentResponse = null;
    pageNumber = 1;
    _commentsScrolController.addListener(() {
      if (_commentsScrolController.position.pixels ==
          _commentsScrolController.position.maxScrollExtent) {
        getMoreComments(context);
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;



    print('null tester ' +
        (Provider.of<CommentsProvider>(context).commentsList.isEmpty)
            .toString());

   return Padding(
      padding: const EdgeInsets.only(bottom:8.0),
      child: ListView.builder(
          shrinkWrap: true,
          controller: _commentsScrolController,
          physics: ClampingScrollPhysics(),
          itemCount: Provider.of<CommentsProvider>(context).commentsList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: lightGrey,
                    borderRadius: BorderRadius.circular(15)),
                width: width * 0.7,
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Provider.of<CommentsProvider>(context)
                                    .commentsList[index]
                                    .comment,
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'one day ago',
                                      style: TextStyle(color: fBlue),
                                    ),
                                    VerticalDivider(),
                                    GestureDetector(
                                      onTap: ()async{
                                          Provider.of<LikeCommentProvider>(context,listen: false).likeComment( Provider.of<CommentsProvider>(context,listen: false)
                                              .commentsList[index].id.toString());

                                          if(Provider.of<LikeCommentProvider>(context).likeComentResponse != null){
                                            setState(() {
                                               likeBtn = Provider.of<LikeCommentProvider>(context).likeComentResponse.btn;

                                            });
                                          }

                                      },
                                      child: Text(
                                        Provider.of<LikeCommentProvider>(context).likeComentResponse==null?
                                        'like' :  Provider.of<LikeCommentProvider>(context,).likeBtn ,
                                        style: TextStyle(color: fBlue),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.favorite,
                            color: Colors.green,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
//
// ListView.builder(
// controller: _commentsScrolController,
// shrinkWrap: true,
// physics: ClampingScrollPhysics(),
// itemCount: Provider.of<CommentsProvider>(context).commentsList.length,
// itemBuilder: (BuildContext context, int index){
// Padding(
// padding: const EdgeInsets.all(20.0),
// child: Container(
// decoration: BoxDecoration(
// color: lightGrey,
// borderRadius: BorderRadius.circular(15)),
// width: width * 0.7,
// height: 100,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Padding(
// padding: const EdgeInsets.all(20.0),
// child: Row(
// crossAxisAlignment: CrossAxisAlignment.end,
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text(
// Provider.of<CommentsProvider>(context)
//     .commentsList[0]
//     .comment,
// style: TextStyle(color: Colors.black),
// ),
// SizedBox(
// height: 10,
// ),
// IntrinsicHeight(
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceEvenly,
// children: [
// Text(
// 'one day ago',
// style: TextStyle(color: fBlue),
// ),
// VerticalDivider(),
// Text(
// 'like',
// style: TextStyle(color: fBlue),
// ),
// ],
// ),
// ),
// ],
// ),
// Icon(
// Icons.favorite,
// color: Colors.green,
// )
// ],
// ),
// )
// ],
// ),
// ),
// );
// }
//
// );