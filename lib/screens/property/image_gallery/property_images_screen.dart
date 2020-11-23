import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageGallery extends StatefulWidget {
  List<String> attachments;

  ImageGallery({this.attachments});

  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Property Images'),
        ),
        body: GridView.builder(
            cacheExtent: 9999,
            itemCount: widget.attachments.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: GestureDetector(
                  onTap: () {
                    showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: MaterialLocalizations.of(context)
                            .modalBarrierDismissLabel,
                        barrierColor: Colors.black45,
                        transitionDuration: const Duration(milliseconds: 200),
                        pageBuilder: (BuildContext buildContext,
                            Animation animation,
                            Animation secondaryAnimation) {
                          return Center(
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.8,


                              padding: EdgeInsets.all(10),
                              color: Colors.white,
                              child: Image.network(widget.attachments[index],fit: BoxFit.cover,))
                            );

                        });
                  },
                  child: Container(
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loader.gif',
                      image: widget.attachments[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }));
  }
}
// decoration: new BoxDecoration(
// image: new DecorationImage(
// image: new NetworkImage(
// widget.attachments[index]),
// fit: BoxFit.cover))

Widget alertDialog(String imageUrl) {
  return CupertinoAlertDialog(
    content: Builder(
      builder: (context) {
        // Get available height and width of the build area of this widget. Make a choice depending on the size.
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;

        return Container(
            height: height-400, width: width, child: Image.network(imageUrl,fit: BoxFit.fill,));
      },
    ),
  );
}
