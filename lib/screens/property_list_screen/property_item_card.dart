import 'package:aqar_bazar/screens/filter/search_result_model.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

Widget propertyCard(BuildContext context,Datum propertyItem) {


 var price = propertyItem.price;
 var width = MediaQuery.of(context).size.width;
 var height = MediaQuery.of(context).size.height;

  return Container(

    height: 170,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),

      child: Container(
        decoration: new BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200],
              blurRadius: 2.0, // has the effect of softening the shadow
              spreadRadius: 2.0, // has the effect of extending the shadow
              offset: Offset(
                5.0, // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            )
          ],
        ),
        child: Container(
          color: Colors.white24,
          child: Row(
            children: [
              Container(
                height: 170,
                width: width * 0.3,
                child: FittedBox(
                    fit: BoxFit.fill,

                    child: Image.network(propertyItem.thumbnail)),
              ),
              SizedBox(
                width: 6,
              ),
              Container(
                width: width*0.35,
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(propertyItem.title,maxLines: 3,),

                    Text(propertyItem.address),
                    // Row(children: [
                    //   Icon(Icons.hotel,color: Colors.blue,),
                    //   Text("1"),
                    //   Icon(Icons.beach_access),
                    //   Text("2")
                    // ],),
                    SmoothStarRating(

                        allowHalfRating: false,
                        onRated: (v) {
                        },
                        starCount: 5,
                        rating: propertyItem.rate.toDouble(),
                        size: 20.0,
                        isReadOnly:true,
                        color: Colors.blue,
                        borderColor: Colors.blue,
                        spacing:0.0
                    )


                  ],
                ),
              ),
              Spacer(),
              Padding(

                padding: const EdgeInsets.all(8.0),
                child: Text(" \$$price",style: TextStyle(fontSize: 20,color: Colors.green),),
              )
            ],
          ),
        ),
      ),


    ),
  );
}
