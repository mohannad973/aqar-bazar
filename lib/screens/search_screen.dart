import 'package:aqar_bazar/screens/property.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(delegate: SearchSliver()),
        SliverToBoxAdapter(
          child: Container(),
        )
      ],
    );
  }
}

class SearchSliver extends SliverPersistentHeaderDelegate {
  SearchSliver();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {}

  @override
  // TODO: implement maxExtent
  double get maxExtent => 200;

  @override
  // TODO: implement minExtent
  double get minExtent => 200;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}
