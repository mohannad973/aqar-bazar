import 'package:aqar_bazar/Utils/colors.dart';
import 'package:aqar_bazar/Utils/decorations.dart';
import 'package:aqar_bazar/Utils/secure_storage.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/constants.dart';
import 'package:aqar_bazar/localization/app_localization.dart';
import 'package:aqar_bazar/models/best_deals_model.dart';
import 'package:aqar_bazar/models/slider_images.dart';
import 'package:aqar_bazar/providers/all_properties_provider.dart';
import 'package:aqar_bazar/providers/login_provider.dart';
import 'package:aqar_bazar/providers/notification_provider.dart';
import 'package:aqar_bazar/providers/property_parameters_provider.dart';
import 'package:aqar_bazar/providers/search_params_provider.dart';
import 'package:aqar_bazar/providers/search_result_provider.dart';
import 'package:aqar_bazar/providers/show_all_properties_provider.dart';
import 'package:aqar_bazar/screens/Auth/login.dart';
import 'package:aqar_bazar/screens/Contact_us/contact_us.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/models/categories.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/models/property_parameters_model.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/properties_by_type.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/show_all_properties_screen.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/widgets/best_deals.dart';
import 'package:aqar_bazar/screens/favourites/favourites_screen.dart';
import 'package:aqar_bazar/screens/filter/filter.dart';
import 'package:aqar_bazar/screens/filter/search_result_model.dart';
import 'package:aqar_bazar/screens/my_bookings/my_bookings_screen.dart';
import 'package:aqar_bazar/screens/profile/profile_screen.dart';
import 'package:aqar_bazar/screens/property_list_screen/property_list_screen.dart';
import 'package:aqar_bazar/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
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

  ScrollController con;

  String _progress = "0%";
  ScrollController _controller;
  int page = 1;
  SecureStorage secureStorage = SecureStorage();
  bool successLogin = false;

  _performLogin() async{
    print('pr1');
    String email = await secureStorage.readEmail('email');
    String  pass = await secureStorage.readPass('pass');

    print('pr2 '+email + " "+ pass);

    final bool user = await Provider
        .of<LogInProvider>(
        context,
        listen: false)
        .logIn(email, pass);
    print('pr3 '+user.toString());
    if(user){
      successLogin = true;

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _performLogin();
    Provider.of<AllPropertiesProvider>(context, listen: false)
        .getAllProperties(1);

    con = ScrollController();
    _controller = ScrollController();
    _controller.addListener(() {
      if (con.offset >= con.position.maxScrollExtent &&
          !con.position.outOfRange) {
        print('controller%1');
        Provider.of<AllPropertiesProvider>(context, listen: false)
            .getAllProperties(page += 1);
        setState(() {});
      } else if (con.offset <= con.position.minScrollExtent &&
          !con.position.outOfRange) {
        print('controller%2');
        setState(() {});
      } else {
        print('controller%3');
        setState(() {});
      }
    });

    Provider.of<PropertyParametersProvider>(context, listen: false)
        .getPropertyParameters();
    categoriesList =
        Provider.of<PropertyParametersProvider>(context, listen: false)
            .categoriesList;

    //homeProperties = Provider.of<SearchResultProvider>(context,listen: false).data;
  }

  @override
  Widget build(BuildContext context) {
    var allPropertiesProvider = Provider.of<AllPropertiesProvider>(context);
    List<Datum> list = allPropertiesProvider.allProperties;
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
                // GestureDetector(
                //   child: ListTile(
                //     leading: Text(
                //       Applocalizations.of(context).translate("home"),
                //       style: TextStyle(
                //           fontSize: 18,
                //           color: Colors.grey[600],
                //           letterSpacing: 0.5),
                //     ),
                //     trailing:
                //         Icon(Icons.home, color: Theme.of(context).primaryColor),
                //   ),
                //   onTap: () {},
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                GestureDetector(
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TestScreen()));
                      },
                      child: Text(
                        Applocalizations.of(context).translate("my_bookings"),
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                            letterSpacing: 0.5),
                      ),
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
                      Applocalizations.of(context).translate("Contact_us"),
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
                // GestureDetector(
                //   child: ListTile(
                //     leading: Text(
                //       Applocalizations.of(context).translate("about_us"),
                //       style: TextStyle(
                //           fontSize: 18,
                //           color: Colors.grey[600],
                //           letterSpacing: 0.5),
                //     ),
                //     trailing:
                //         Icon(Icons.info, color: Theme.of(context).primaryColor),
                //   ),
                //   onTap: () {},
                // ),

                GestureDetector(
                  child: ListTile(
                    leading: Text(
                      Applocalizations.of(context).translate("log_out"),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                          letterSpacing: 0.5),
                    ),
                    trailing: Icon(Icons.cancel,
                        color: Theme.of(context).primaryColor),
                  ),
                  onTap: () {
                    secureStorage.deleteAllSecureStorage();
                    SessionManager sessionManager = SessionManager();
                    // sessionManager.clearSessionManager();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LogIn()));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
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
                  icon:
                  Icon(Icons.search, color: Theme.of(context).primaryColor),
                  onPressed: () {
                    Provider.of<SearchParamsProvider>(context, listen: false)
                        .getSearchParams();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FilterScreen()));
                  },
                ),
                SizedBox(width: 25),
                IconButton(
                  icon: Icon(Icons.favorite_border, color: Theme.of(context).primaryColor),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FavouritesScreen()));
                  },
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
          body: (allPropertiesProvider.isFirstLoading() || Provider.of<LogInProvider>(context).isLoading()  )
              ? Center(
              child: CircularProgressIndicator(
                backgroundColor: fBlue,
              ))
              : Builder(builder: (context) {
            final _scr = PrimaryScrollController.of(context);
            _scr.addListener(() {
              if (_scr.position.pixels == _scr.position.maxScrollExtent) {
                // Provider.of<AllPropertiesProvider>(context,
                //         listen: false)
                //     .getAllProperties(page += 1);
              }
            });

            return CustomScrollView(
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
                          Applocalizations.of(context)
                              .translate("Explore"),
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
                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              index == 0
                                  ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 18, right: 18, bottom: 4),
                                child: GestureDetector(
                                  onTap: (){

                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowAllProperties()));
                                  },
                                  child: Text(
                                    Applocalizations.of(context).translate("show-all"),
                                    style: TextStyle(
                                        color: fBlue, fontSize: 18),
                                  ),
                                ),
                              )
                                  : Container(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PropertyPage(
                                            property: list[index],
                                          )));
                                },
                                child: DealsCard(
                                  propertyData: list[index],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      childCount: list.length,
                    ))
              ],
            );
          })),
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
                                  catList[index].name==null?"":catList[index].name,
                                  style: textStyleSemiBold()
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                                onTap: () {
                                  // Provider.of<SearchResultProvider>(context,
                                  //         listen: false)
                                  //     .search(
                                  //         furnished: "",
                                  //         category: "",
                                  //         capacity: "",
                                  //         price: "",
                                  //         bathrooms: "",
                                  //         rooms: "",
                                  //         city: "",
                                  //         type: "");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PropertiesByTypeScreen(propertyType: catList[index].id,propertyTypeName: catList[index].name,)));

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
        title: '',
        imageUrl: 'assets/images/home1.jpg',
      ),
      SliderImages(
        title: '',
        imageUrl: 'assets/images/home4.png',
      ),
      SliderImages(
        title: '',
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

// Widget build(BuildContext context) {
//   return Scaffold(
//     body: NestendScrollView(
//       headerSliverBuilder: (BuildContext context, bool value) {
//         return <Widget>[
//           SliverAppBar(),
//         ];
//       },
//       body: SafeArea(
//         child: Builder(
//           builder: (context) {
//             final _scr = PrimaryScrollController.of(context);
//             _scr.addListener(() {
//               if (_scr.position.pixels == _scr.position.maxScrollExtent) {
//                 print('At DOWNW!!!');
//               }
//             });
//
//             return CustomScrollView(
//               controller: _scr,
//               slivers: <Widget>[
//                 SliverOverlapAbsorber(
//                   handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
//                     context,
//                   ),
//                 ),
//                 SliverList(
//                   delegate: SliverChildListDelegate(
//                     List.generate(100, (int index) {
//                       return Text('ITEM -> $index');
//                     }),
//                   ),
//                 )
//               ],
//             );
//           },
//         ),
//       ),
//     ),
//   );
// }
