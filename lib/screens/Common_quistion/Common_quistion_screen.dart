import 'package:aqar_bazar/Common_Widgets/common_widgets.dart';
import 'package:aqar_bazar/Utils/decorations.dart';
import 'package:aqar_bazar/localization/app_localization.dart';
import 'package:flutter/material.dart';

class CommonQuestionScreen extends StatefulWidget {
  @override
  _CommonQuestionScreenState createState() => _CommonQuestionScreenState();
}

class _CommonQuestionScreenState extends State<CommonQuestionScreen> {
  List<Item> _books = generateItems(10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "How Can We Help ?",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextField(
                  //     style: TextStyle(
                  //       fontSize: 15,
                  //     ),
                  //     decoration:
                  //         inputDecoration().copyWith(hintText: 'Search'),
                  //   ),
                  // ),
                ],
              ),
              height: 100,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).primaryColor
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(Applocalizations.of(context).translate("common_questions"),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: _buildPanel(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _books[index].isExpanded = !isExpanded;
        });
      },
      children: _books.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue,style: TextStyle(color: Colors.blue,fontSize: 20),),
            );
          },
          body: ListTile(
            title: Text(item.expandedValue),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'sed ut perspiciatis unde',
      expandedValue: 'Usu habeo equidem sanctus no. Suas summo id sed, erat erant oporteat cu pri. In eum omnes molestie. Sed ad debet scaevola, In eum omnes molestieUsu habeo equidem sanctus no. Suas summo id sed, erat erant oporteat cu pri. In eum omnes molestie. Sed ad debet scaevola, In eum omnes molestieUsu habeo equidem sanctus no. Suas summo id sed, eratUsu habeo equidem sanctus no. Suas summo id sed, erat erant oporteat cu pri. In eum omnes molestie. Sed ad debet scaevola, In eum omnes molestieUsu habeo equidem sanctus no. Suas summo id sed, erat erant oporteat cu pri. In eum omnes molestie. Sed ad debet scaevola, In eum omnes molestieUsu habeo equidem sanctus no. Suas summo id sed, erat erant oporteat cu pri. In eum omnes molestieUsu habeo equidem sanctus no. Suas summo id sed, erat erant oporteat cu pri. In eum omnes molestie. Sed ad debet scaevola, In eum omnes molestieUsu habeo equidem sanctus no. Suas summo id sed, erat erant oporteat cu pri. In eum omnes molestie. Sed ad debet scaevola, In eum omnes molestieUsu habeo equidem sanctus no. Suas summo id sed, erat erant oporteat cu pri. In eum omnes molestieUsu habeo equidem sanctus non eum omnes molestieUsu habeo equidem sanctus no. Suas summo id sed, erat erant oporteat cu pri. In eum omnes . In eum omnes molestie',
    );
  });
}
