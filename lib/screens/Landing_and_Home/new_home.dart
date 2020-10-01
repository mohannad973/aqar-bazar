import 'package:aqar_bazar/Utils/colors.dart';
import 'package:aqar_bazar/models/best_deals_model.dart';
import 'package:aqar_bazar/models/slider_images.dart';
import 'package:aqar_bazar/screens/profile/profile_screen.dart';
import 'package:aqar_bazar/widgets/best_deals.dart';
import 'package:aqar_bazar/widgets/exploreList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../property.dart';
import 'filter/filter.dart';

class NewHome extends StatefulWidget {
  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  int _selectedIndex = 0;
  List<IconData> _icons = [
    FontAwesomeIcons.hotel,
    FontAwesomeIcons.houseUser,
    FontAwesomeIcons.car,
    FontAwesomeIcons.carBattery
  ];
  @override
  Widget build(BuildContext context) {
    Widget _iconRow(int index) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
          height: _selectedIndex == index ? 60.0 : 50.0,
          width: _selectedIndex == index ? 60.0 : 50.0,
          decoration: BoxDecoration(
            color: _selectedIndex == index
                ? Theme.of(context).accentColor
                : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: Offset(0, 4),
                  color: Colors.grey[400])
            ],
          ),
          child: Icon(
            _icons[index],
            size: _selectedIndex == index ? 25.0 : 20,
            color: _selectedIndex == index
                ? iconColor()
                : Theme.of(context).accentColor,
          ),
        ),
      );
    }

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: iconColor(),
          elevation: 4.0,
          child: Icon(
            Icons.search,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FilterScreen()));
          },
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 4.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
              ),
              IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()));
                  }),
            ],
          ),
        ),
        body: Material(
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate:
                    HomeScreenCustomSliverAppBar(expandedHeight: height / 2),
                pinned: true,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _icons
                        .asMap()
                        .entries
                        .map((MapEntry map) => _iconRow(map.key))
                        .toList(),
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      var list = bestDeals[index];
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PropertyPage(
                                    propertyInfo: Property(
                                      name: list.name,
                                      image: list.image,
                                      location: list.location,
                                      shortAddress: list.shortAddress,
                                      price: list.price,
                                      propertType: list.propertType,
                                    ),
                                  )));
                    },
                    child: Container(
                        child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                bestDeals[index].image,
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.hotel,
                                      size: 15,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      bestDeals[index].name,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Text(
                                  bestDeals[index].price,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 15,
                                      color: Colors.red[900],
                                    ),
                                    Text(bestDeals[index].shortAddress,
                                        style:
                                            TextStyle(color: Colors.red[900])),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 15,
                                      color: Colors.green[600],
                                    ),
                                    Text(
                                      bestDeals[index].rating,
                                      style:
                                          TextStyle(color: Colors.green[600]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                  );
                },
                childCount: bestDeals.length,
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreenCustomSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  HomeScreenCustomSliverAppBar({@required this.expandedHeight});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    List<SliderImages> _images = [
      SliderImages(
        title: 'Hey there',
        imageUrl:
            'https://images.unsplash.com/photo-1502117859338-fd9daa518a9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
      ),
      SliderImages(
        title: 'This is a beautiful Image',
        imageUrl:
            'https://images.unsplash.com/photo-1502943693086-33b5b1cfdf2f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80',
      ),
      SliderImages(
        title: 'this is another Great Image',
        imageUrl:
            'https://images.unsplash.com/photo-1543922596-b3bbaba80649?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
      )
    ];
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Swiper(
          viewportFraction: 1,
          itemHeight: MediaQuery.of(context).size.height / 2,
          itemWidth: MediaQuery.of(context).size.width,
          pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
              activeColor: iconColor(),
            ),
            margin: EdgeInsets.all(50),
          ),
          autoplay: true,
          itemCount: _images.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(children: [
              Image.network(
                _images[index].imageUrl,
                width: width,
                height: height / 2,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: expandedHeight - 150 - shrinkOffset,
                left: 30,
                child: Opacity(
                  opacity: (1 - shrinkOffset / expandedHeight),
                  child: Text(_images[index].title,
                      style:
                          TextStyle(color: Colors.white, fontSize: width / 18)),
                ),
              ),
            ]);
          },
        ),
        Positioned(
          bottom: expandedHeight - 80 - shrinkOffset,
          left: width / 10,
          child: Center(
            child: Container(
              height: 45,
              width: width / 1.2,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        color: Colors.black54,
                        offset: Offset(5.0, 8)),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  children: [
                    Icon(Icons.search, color: iconColor()),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Start Borwsing',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
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
  double get minExtent => kToolbarHeight + 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
