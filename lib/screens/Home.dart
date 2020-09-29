import 'package:aqar_bazar/models/slider_images.dart';
import 'package:aqar_bazar/screens/profile/profile_screen.dart';
import 'package:aqar_bazar/screens/search_screen.dart';
import 'package:aqar_bazar/widgets/best_deals.dart';
import 'package:aqar_bazar/widgets/exploreList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _swiperContainerHeight = 400.0;
  int _selectedIndex = 0;
  TextStyle _blackBold = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    fontSize: 20,
  );
  List<IconData> _icons = [
    FontAwesomeIcons.hotel,
    FontAwesomeIcons.houseUser,
    FontAwesomeIcons.car,
    FontAwesomeIcons.carBattery
  ];
  Widget _customScrollView() {
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
                ? Theme.of(context).primaryColor
                : Theme.of(context).accentColor,
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
                ? Theme.of(context).accentColor
                : Theme.of(context).primaryColor,
          ),
        ),
      );
    }

    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: _swiperContainerHeight,
            floating: false,
            pinned: true,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Padding(
                padding: EdgeInsets.all(0.0),
                child: Container(
                  height: 35,
                  child: TextField(
                    style: TextStyle(
                      fontSize: 10,
                    ),
                    decoration: inputDecoration().copyWith(hintText: 'Search'),
                  ),
                ),
              ),
              background: Swiper(
                itemCount: _images.length,
                itemBuilder: (BuildContext context, int index) => Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: _swiperContainerHeight,
                      color: Colors.black,
                      child: Image.network(
                        _images[index].imageUrl,
                        width: MediaQuery.of(context).size.width,
                        height: _swiperContainerHeight,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _images[index].title,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 35),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Container(
                            child: Text(
                              _images[index].title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                autoplay: true,
              ),
            ),
          ),
        ];
      },
      body: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _icons
                  .asMap()
                  .entries
                  .map((MapEntry map) => _iconRow(map.key))
                  .toList(),
            ),
            ExploreList(),
            SizedBox(height: 15),
            BestDeals(),
          ],
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: _customScrollView(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          elevation: 4.0,
          child: Icon(Icons.search),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchScreen()));
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
      ),
    );
  }
}

InputDecoration inputDecoration() {
  return InputDecoration(
    prefixIcon: Icon(Icons.search),
    contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
    fillColor: Colors.grey[200],
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[400], width: 0.5),
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue[600], width: 0.5),
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
  );
}
