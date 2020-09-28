import 'dart:ui';

import 'package:aqar_bazar/models/best_deals_model.dart';
import 'package:aqar_bazar/models/places.dart';
import 'package:aqar_bazar/widgets/best_deals.dart';
import 'package:aqar_bazar/widgets/exploreList.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PropertyPage extends StatefulWidget {
  Property propertyInfo;
  PropertyPage({this.propertyInfo});

  @override
  _PropertyPageState createState() => _PropertyPageState();
}

class _PropertyPageState extends State<PropertyPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: CustomSliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height,
                  propertyInfo: widget.propertyInfo),
              pinned: true,
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              ExploreList(),
              BestDeals(),
            ]))
          ],
        ),
      ),
    );
  }
}

class CustomSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  Property propertyInfo;

  CustomSliverAppBar(
      {@required this.expandedHeight, @required this.propertyInfo});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Image.asset(
          propertyInfo.image,
          fit: BoxFit.cover,
        ),
        Positioned(
          left: 15,
          bottom: 15,
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: Text(
              propertyInfo.name,
              style: TextStyle(
                  color: Colors.white,
                  shadows: [
                    Shadow(
                        color: Colors.black,
                        blurRadius: 2,
                        offset: Offset(0, 3.0))
                  ],
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 1.8 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 14,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Color(0x9499f9f9),
                elevation: 10,
                child: SizedBox(
                    height: expandedHeight / 3,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                propertyInfo.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                propertyInfo.price,
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                propertyInfo.shortAddress,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Icon(
                                Icons.location_on,
                                color: Theme.of(context).primaryColor,
                                size: 15,
                              ),
                              Text(
                                propertyInfo.location,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor nulla pariatur. Excepteur sint ',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: FlatButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 4,
                                  vertical: 12),
                              onPressed: () {},
                              child: Text(
                                'Book Now',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => expandedHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => kToolbarHeight + 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
