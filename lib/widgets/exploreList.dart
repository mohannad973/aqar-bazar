import 'package:aqar_bazar/models/places.dart';
import 'package:aqar_bazar/screens/property_list_screen/property_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ExploreList extends StatelessWidget {
  const ExploreList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _blackBold = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
      fontSize: 20,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 1,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              'Explore Top Choices',
              style: _blackBold,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 6,
          child: Center(
            child: ListView.builder(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  Places destination = destinations[index];
                  return Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
                      width: 300,
                      child: Card(
                        elevation: 7,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Colors.blue,
                        child: InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PropertyListScreen()),
                            );
                          },
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  destination.imageUrl,
                                  fit: BoxFit.cover,
                                  width: 300,
                                  height: MediaQuery.of(context).size.height / 6,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(destination.city,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ));
                },
                itemCount: destinations.length),
          ),
        ),
      ],
    );
  }
}
