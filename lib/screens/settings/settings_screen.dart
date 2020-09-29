import 'package:aqar_bazar/Utils/decorations.dart';
import 'package:aqar_bazar/screens/settings/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> countries = [
    "Turkey",
    "Emarates",
    "Syria"
  ];
  int _selected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Settings',
              style: textStyleBold(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  settingsItem("Notifications", Icons.notifications),
                  Divider(
                    color: Colors.grey,
                    indent: 10,
                    endIndent: 10,
                  ),
                  InkWell(
                    child: settingsItem("Country", Icons.location_city),
                    onTap: () {
_showDialog();
                    },
                  ),
                  Divider(
                    color: Colors.grey,
                    indent: 10,
                    endIndent: 10,
                  ),
                  settingsItem("Currency", Icons.attach_money),
                  Divider(
                    color: Colors.grey,
                    indent: 10,
                    endIndent: 10,
                  ),
                  settingsItem(
                      "Terms of Services", LineAwesomeIcons.angle_right),
                  Divider(
                    color: Colors.grey,
                    indent: 10,
                    endIndent: 10,
                  ),
                  settingsItem("Privacy Policy", LineAwesomeIcons.angle_right),
                  Divider(
                    color: Colors.grey,
                    indent: 10,
                    endIndent: 10,
                  ),
                  settingsItem(
                      "Give Us Feedbacks", LineAwesomeIcons.angle_right),
                  Divider(
                    color: Colors.grey,
                    indent: 10,
                    endIndent: 10,
                  ),
                  settingsItem("Log out", LineAwesomeIcons.angle_right),
                  Divider(
                    color: Colors.grey,
                    indent: 10,
                    endIndent: 10,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


  _showDialog(){
   AlertDialog dialog = AlertDialog(
      title: Text("Pick Country"),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actions: <Widget>[
        FlatButton(
          child: const Text('CANCEL'),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textColor: Colors.blue,
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        FlatButton(
          child: const Text('OK'),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textColor: Colors.blue,
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
      content: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Divider(),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: countries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RadioListTile(

                          title: Text(countries[index]),
                          value: index,
                          groupValue: _selected,
                          onChanged: (value) {
                            setState(() {
                              _selected = index;
                            });
                          });
                    }),
              ),
            
            ],
          ),
        ),
      ),
    );
   
   showDialog(context: context,child: dialog);
  }
}
