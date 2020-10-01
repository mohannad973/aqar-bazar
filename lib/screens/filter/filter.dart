import 'package:aqar_bazar/screens/filter/price_range_slider.dart';
import 'package:aqar_bazar/screens/filter/property_type_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int _rentTypeSelectedIndex = 0;
  int _furnishedTypeSelectedIndex = 0;
  int _propertyTypeSelectedIndex = 0;
  int roomValue = 1;
  int cityValue = 1;
  List<String> _rentType = ["Buy", "Rent"];
  List<String> _furnishedType = ["Furnished", "Unfurnished"];
  RangeValues _values = const RangeValues(100, 600);

  List<PropertyTypeModel> propertyList = [
    PropertyTypeModel(name: "house", iconData: Icons.home),
    PropertyTypeModel(name: "Hotel", iconData: Icons.hotel),
    PropertyTypeModel(name: "office", iconData: Icons.local_post_office),
    PropertyTypeModel(name: "apartment", iconData: Icons.hot_tub),
    PropertyTypeModel(name: "house", iconData: Icons.home),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "Filter",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: Offset(0, 4),
                        color: Color.fromRGBO(226, 229, 235, 1))
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _rentType
                      .asMap()
                      .entries
                      .map((MapEntry map) => _iconRow(map.key, _rentType))
                      .toList(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              dropDownSelectCity(),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: Offset(0, 4),
                        color: Color.fromRGBO(226, 229, 235, 1))
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _furnishedType
                      .asMap()
                      .entries
                      .map((MapEntry map) =>
                          _furnishedRow(map.key, _furnishedType))
                      .toList(),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [

                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'property type',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize:
                        MediaQuery.of(context).size.width > 360 ? 18 : 16,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: propertyList
                    .asMap()
                    .entries
                    .map((MapEntry map) => _propertyType(map.key))
                    .toList(),
              ),
              Divider(
                color: Colors.grey,
                indent: 20,
                endIndent: 20,
              ),
              priceBarFilter(),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [

                    SizedBox(width: 10,),
                    Text("Number of Bedrooms",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ),
              dropDownRoomCount(),
              RaisedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context)
                          .size
                          .width /
                          3,
                      vertical: 10),
                  icon: Icon(
                    Icons.filter_list,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Apply",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(15.0),
                  )),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconRow(int index, List<String> list) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _rentTypeSelectedIndex = index;
        });
      },
      child: Container(
        height: 60.0,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                blurRadius: 1,
                spreadRadius: 1,
                offset: Offset(0, 4),
                color: Color.fromRGBO(226, 229, 235, 1))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: _rentTypeSelectedIndex == index
              ? _selectedContainer(index, list)
              : _unSelectedContainer(index, list),
        ),
      ),
    );
  }

  Widget _selectedContainer(int index, List<String> list) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              blurRadius: 1,
              spreadRadius: 1,
              offset: Offset(0, 4),
              color: Colors.white)
        ],
      ),
      child: Center(
          child: Text(
        list[index],
        style: TextStyle(
            color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
      )),
    );
  }

  Widget _unSelectedContainer(int index, List<String> list) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 1,
              spreadRadius: 1,
              offset: Offset(0, 4),
              color: Color.fromRGBO(226, 229, 235, 1))
        ],
      ),
      child: Center(
          child: Text(
        list[index],
        style: TextStyle(
            color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
      )),
    );
  }

  Widget _locationContainer(String text, IconData icon) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.symmetric(
        horizontal: 40,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(226, 229, 235, 1),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 25,
          ),
          SizedBox(
            width: 50,
          ),
          Text(text,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              )),
          Spacer(),
        ],
      ),
    );
  }

  Widget _furnishedRow(int index, List<String> list) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _furnishedTypeSelectedIndex = index;
        });
      },
      child: Container(
        height: 60.0,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                blurRadius: 1,
                spreadRadius: 1,
                offset: Offset(0, 4),
                color: Color.fromRGBO(226, 229, 235, 1))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: _furnishedTypeSelectedIndex == index
              ? _selectedContainer(index, list)
              : _unSelectedContainer(index, list),
        ),
      ),
    );
  }

  Widget _propertyType(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _propertyTypeSelectedIndex = index;
        });
      },
      child: Column(
        children: [
          Container(
            height: _propertyTypeSelectedIndex == index ? 60.0 : 50.0,
            width: _propertyTypeSelectedIndex == index ? 60.0 : 50.0,
            decoration: BoxDecoration(
              color: _propertyTypeSelectedIndex == index
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
              propertyList[index].iconData,
              size: _propertyTypeSelectedIndex == index ? 25.0 : 20,
              color: _propertyTypeSelectedIndex == index
                  ? Theme.of(context).accentColor
                  : Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              propertyList[index].name,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget priceBarFilter() {
    return Container(
      width: MediaQuery.of(context).copyWith().size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [

                Text(
                  'Price Range',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize:
                          MediaQuery.of(context).size.width > 360 ? 18 : 16,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          RangeSliderView(
            values: _values,
            onChangeRangeValues: (RangeValues values) {
              _values = values;
            },
          ),
          const SizedBox(
            height: 8,
          ),

        ],
      ),
    );
  }

  Widget dropDownRoomCount() {
   return Padding(
     padding: const EdgeInsets.all(20.0),
     child: Container(
       width: MediaQuery.of(context).size.width*0.8,
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(10),
         boxShadow: [
           BoxShadow(
               blurRadius: 1,
               spreadRadius: 1,
               offset: Offset(0, 4),
               color: Color.fromRGBO(226, 229, 235, 1))
         ],
       ),


       child: DropdownButton(
           hint: new Text("Select City"),
           dropdownColor: Color.fromRGBO(226, 229, 235, 1),
           isExpanded: true,
            value: roomValue,
            items: [
              DropdownMenuItem(
                child: Text("0 - 5"),
                value: 1,
              ),
              DropdownMenuItem(
                child: Text("5 - 10"),
                value: 2,
              ),
              DropdownMenuItem(
                  child: Text("10 - 15"),
                  value: 3
              ),
              DropdownMenuItem(
                  child: Text("15 - 20"),
                  value: 4
              )
            ],
            onChanged: (value) {
              setState(() {
                roomValue = value;
              });
            }),
     ),
   );

  }

  Widget dropDownSelectCity() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: MediaQuery.of(context).size.width*0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 1,
                spreadRadius: 1,
                offset: Offset(0, 4),
                color: Color.fromRGBO(226, 229, 235, 1))
          ],
        ),


        child: DropdownButton(

            dropdownColor: Color.fromRGBO(226, 229, 235, 1),
            isExpanded: true,
            value: cityValue,
            items: [
              DropdownMenuItem(
                child: Text("Ankara"),
                value: 1,
              ),
              DropdownMenuItem(
                child: Text("Istanbul"),
                value: 2,
              ),
              DropdownMenuItem(
                  child: Text("Tunceli"),
                  value: 3
              ),
              DropdownMenuItem(
                  child: Text("Cankiri"),
                  value: 4
              )
            ],
            onChanged: (value) {
              setState(() {
                cityValue = value;
              });
            }),
      ),
    );

  }
}
