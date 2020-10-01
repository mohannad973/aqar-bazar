import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

Widget propertyCard(BuildContext context,String url) {

  return Container(

    height: 165,
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
                height: 165,
                width: MediaQuery.of(context).size.width * 0.4,
                child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Image.asset(url)),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("All New Villa "),
                  Text("description"),
                  Text("location"),
                  Row(children: [
                    Icon(Icons.hotel,color: Colors.blue,),
                    Text("1"),
                    Icon(Icons.beach_access),
                    Text("2")
                  ],),
                  SmoothStarRating(
                      allowHalfRating: false,
                      onRated: (v) {
                      },
                      starCount: 5,
                      rating: 4.5,
                      size: 20.0,
                      isReadOnly:true,
                      color: Colors.blue,
                      borderColor: Colors.blue,
                      spacing:0.0
                  )


                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(" \$250",style: TextStyle(fontSize: 20,color: Colors.green),),
              )
            ],
          ),
        ),
      ),


    ),
  );
}
