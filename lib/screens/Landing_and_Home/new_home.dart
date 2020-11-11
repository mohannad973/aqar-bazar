import 'package:aqar_bazar/Utils/colors.dart';
import 'package:aqar_bazar/Utils/decorations.dart';
import 'package:aqar_bazar/models/best_deals_model.dart';
import 'package:aqar_bazar/models/slider_images.dart';
import 'package:aqar_bazar/providers/property_parameters_provider.dart';
import 'package:aqar_bazar/providers/search_params_provider.dart';
import 'package:aqar_bazar/providers/search_result_provider.dart';
import 'package:aqar_bazar/screens/Contact_us/contact_us.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/models/categories.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/models/property_parameters_model.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/widgets/best_deals.dart';
import 'package:aqar_bazar/screens/filter/filter.dart';
import 'package:aqar_bazar/screens/filter/search_result_model.dart';
import 'package:aqar_bazar/screens/profile/profile_screen.dart';
import 'package:aqar_bazar/screens/property_list_screen/property_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../property/property.dart';

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

  List<Category> categoriesList = [];

  List<Datum> homeProperties = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('test1');

    Provider.of<PropertyParametersProvider>(context, listen: false)
        .getPropertyParameters();
    categoriesList =
        Provider.of<PropertyParametersProvider>(context, listen: false)
            .categoriesList;

    //homeProperties = Provider.of<SearchResultProvider>(context,listen: false).data;
  }

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
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.all(8.0),
            children: [
              Center(
                child: DrawerHeader(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: width / 5,
                  ),
                ),
              ),
              GestureDetector(
                child: ListTile(
                  leading: Text(
                    'Home',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        letterSpacing: 0.5),
                  ),
                  trailing:
                      Icon(Icons.home, color: Theme.of(context).primaryColor),
                ),
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(),
              ),
              GestureDetector(
                child: ListTile(
                  leading: Text(
                    'My Bookings',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        letterSpacing: 0.5),
                  ),
                  trailing:
                      Icon(Icons.book, color: Theme.of(context).primaryColor),
                ),
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(),
              ),
              GestureDetector(
                child: ListTile(
                  leading: Text(
                    'Contact Us',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        letterSpacing: 0.5),
                  ),
                  trailing:
                      Icon(Icons.mail, color: Theme.of(context).primaryColor),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ContactUs()));
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(),
              ),
              GestureDetector(
                child: ListTile(
                  leading: Text(
                    'About us',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        letterSpacing: 0.5),
                  ),
                  trailing:
                      Icon(Icons.info, color: Theme.of(context).primaryColor),
                ),
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(),
              ),
              GestureDetector(
                child: ListTile(
                  leading: Text(
                    'Log out',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        letterSpacing: 0.5),
                  ),
                  trailing:
                      Icon(Icons.cancel, color: Theme.of(context).primaryColor),
                ),
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 4.0,
          child: Icon(
            FontAwesomeIcons.list,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () {
            _modalBottomSheet(context, categoriesList);
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
                icon: Icon(Icons.menu, color: Theme.of(context).primaryColor),
                onPressed: () {
                  _scaffoldKey.currentState.openDrawer();
                },
              ),
              IconButton(
                icon: Icon(Icons.search, color: Theme.of(context).primaryColor),
                onPressed: () {
                  Provider.of<SearchParamsProvider>(context, listen: false)
                      .getSearchParams();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FilterScreen()));
                },
              ),
              SizedBox(width: 25),
              IconButton(
                icon: Icon(Icons.book, color: Theme.of(context).primaryColor),
                onPressed: () {},
              ),
              IconButton(
                  icon: Icon(Icons.settings,
                      color: Theme.of(context).primaryColor),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()));
                  }),
            ],
          ),
        ),
        body: FutureBuilder(
          future: Provider.of<SearchResultProvider>(context, listen: false)
              .search(
                  furnished: "",
                  category: "",
                  capacity: "",
                  price: "",
                  bathrooms: "",
                  rooms: "",
                  city: "",
                  type: ""),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ));
            } else {
              return Material(
                child: CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      delegate: HomeScreenCustomSliverAppBar(
                          expandedHeight: height / 2),
                      pinned: true,
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 25, 10, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.globeAmericas,
                              size: 20,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Explore',
                              style: textStyleSemiBold().copyWith(
                                  fontSize: 25, color: Colors.black87),
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            print('taaaaaaped '+ index.toString());
                          //  var list = bestDeals[index];
                          //  print("testing the list : "+list.toString());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PropertyPage(
                                          // propertyInfo: Property(
                                          //   name: list.name,
                                          //   image: list.image,
                                          //   location: list.location,
                                          //   shortAddress: list.shortAddress,
                                          //   price: list.price,
                                          //   propertType: list.propertType,
                                          // ),
                                      property: snapshot.data.data[index],
                                        )));
                          },
                          child: Container(
                            child: DealsCard(propertyData: snapshot.data.data[index],),
                          //     child: Card(
                          //   elevation: 8,
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(15),
                          //   ),
                          //   child: Column(
                          //     children: [
                          //       ClipRRect(
                          //           borderRadius: BorderRadius.circular(15),
                          //           child: Image.network(
                          //             snapshot.data.data[index].thumbnail,
                          //           )),
                          //       Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: Row(
                          //           mainAxisAlignment:
                          //               MainAxisAlignment.spaceBetween,
                          //           children: [
                          //             Row(
                          //               children: [
                          //                 Icon(
                          //                   FontAwesomeIcons.hotel,
                          //                   size: 15,
                          //                   color:
                          //                       Theme.of(context).primaryColor,
                          //                 ),
                          //                 SizedBox(
                          //                   width: 5,
                          //                 ),
                          //                 Container(
                          //                   width: MediaQuery.of(context)
                          //                           .size
                          //                           .width /
                          //                       3,
                          //                   child: Text(
                          //                     snapshot.data.data[index].title,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: TextStyle(
                          //                         fontSize: 18,
                          //                         fontWeight: FontWeight.w500),
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //             Text(
                          //               snapshot.data.data[index].price
                          //                   .toString(),
                          //               style: TextStyle(
                          //                   color:
                          //                       Theme.of(context).primaryColor,
                          //                   fontSize: 22,
                          //                   fontWeight: FontWeight.w600),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: Row(
                          //           mainAxisAlignment:
                          //               MainAxisAlignment.spaceBetween,
                          //           children: [
                          //             Row(
                          //               children: [
                          //                 Icon(
                          //                   Icons.location_on,
                          //                   size: 15,
                          //                   color: Colors.red[900],
                          //                 ),
                          //                 Text(
                          //                     snapshot.data.data[index].address,
                          //                     style: TextStyle(
                          //                         color: Colors.red[900])),
                          //               ],
                          //             ),
                          //             Row(
                          //               children: [
                          //                 Icon(
                          //                   Icons.star,
                          //                   size: 15,
                          //                   color: Colors.green[600],
                          //                 ),
                          //                 Text(
                          //                   snapshot.data.data[index].rate
                          //                       .toString(),
                          //                   style: TextStyle(
                          //                       color: Colors.green[600]),
                          //                 ),
                          //               ],
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // )
                          ),
                        );
                      },
                      childCount: snapshot.data.data.length,
                    ))
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

void _modalBottomSheet(context, List<Category> catList) {
  double _avatarRadius = 40;
  showModalBottomSheet(
      context: context,
      builder: (BuildContext buildContext) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Image.asset(
                        'assets/images/logo1.png',
                        height: _avatarRadius - 10,
                      ),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 12),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: catList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              GestureDetector(
                                child: Text(
                                  catList[index].name,
                                  style: textStyleSemiBold()
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                                onTap: () {
                                  Provider.of<SearchResultProvider>(context,
                                          listen: false)
                                      .search(
                                          furnished: "",
                                          category: "",
                                          capacity: "",
                                          price: "",
                                          bathrooms: "",
                                          rooms: "",
                                          city: "",
                                          type: "");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PropertyListScreen()));
                                  print("*/*/*/**/*/" +
                                      catList[index].id.toString());
                                },
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              index != catList.length
                                  ? Divider()
                                  : SizedBox(
                                      height: 8,
                                    ),
                            ],
                          );
                        }),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}

class HomeScreenCustomSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  HomeScreenCustomSliverAppBar({@required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    double _circleAvatarRad = 50;
    List<SliderImages> _images = [
      SliderImages(
        title: 'Hey there',
        imageUrl: 'assets/images/home1.jpg',
      ),
      SliderImages(
        title: 'This is a beautiful Image',
        imageUrl: 'assets/images/home4.png',
      ),
      SliderImages(
        title: 'this is another Great Image',
        imageUrl: 'assets/images/home5.png',
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
                activeColor: Theme.of(context).primaryColor),
            margin: EdgeInsets.all(50),
          ),
          autoplay: true,
          itemCount: _images.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(children: [
              Image.asset(
                _images[index].imageUrl,
                width: width,
                height: height / 2,
                fit: BoxFit.cover,
              ),
              Container(
                width: width,
                height: height / 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black12],
                    stops: [0, 10],
                    begin: Alignment.topRight,
                  ),
                ),
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
          bottom: expandedHeight - 100 - shrinkOffset,
          left: width / 4,
          right: width / 4,
          top: 15,
          child: Center(
            child: CircleAvatar(
              radius: _circleAvatarRad,
              backgroundColor: Colors.white,
              child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Image.asset(
                    'assets/images/logo1.png',
                    height: _circleAvatarRad - 10,
                  )),
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
