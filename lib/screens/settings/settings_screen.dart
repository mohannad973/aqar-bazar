import 'package:aqar_bazar/Utils/decorations.dart';
import 'package:aqar_bazar/providers/preferences_provider.dart';
import 'package:aqar_bazar/screens/settings/preferences_model.dart';
import 'package:aqar_bazar/screens/settings/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<Country> countries = [];
  List<Currency> currencyList=[];

  int _selected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("999999999"+Provider.of<PreferencesProvider>(context,listen:false).currencyList.toString());

    countries = Provider.of<PreferencesProvider>(context,listen:false).countryList;
    currencyList = Provider.of<PreferencesProvider>(context,listen:false).currencyList;


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body:
      Provider.of<PreferencesProvider>(context).isLoading()
          ? Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.blue,
        ),
      )
          :
      Column(
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

  _showDialog() {
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
                          title: Text(countries[index].name),
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

    showDialog(context: context, child: dialog);
  }
}
