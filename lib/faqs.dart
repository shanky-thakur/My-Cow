import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/util/item_model.dart';

class Faqs extends StatefulWidget {
  const Faqs({super.key});

  @override
  State<Faqs> createState() => _FaqsState();
}

class _FaqsState extends State<Faqs> {
  List<ItemModel> itemData = <ItemModel>[
    ItemModel(
      headerItem: 'Question',
      discription:
          "Answer",
      colorsItem: Colors.black,
    ),
    ItemModel(
      headerItem: 'Question',
      discription:
          "Answer",
      colorsItem: Colors.black,
    ),
    ItemModel(
      headerItem: 'Question',
      discription:
          "Answer",
      colorsItem: Colors.black,
    ),
    ItemModel(
      headerItem: 'Question',
      discription:
          "Answer",
      colorsItem: Colors.black,
    ),
    ItemModel(
      headerItem: 'Question',
      discription: "Answer",
      colorsItem: Colors.black,
    ),
    ItemModel(
      headerItem: 'Question',
      discription:
          "Answer",
      colorsItem: Colors.black,
    ),
    ItemModel(
      headerItem: 'Question',
      discription: "Answer",
      colorsItem: Colors.black,
    ),
    ItemModel(
      headerItem: 'Question',
      discription: "Answer",
      colorsItem: Colors.black,
    ),
    ItemModel(
      headerItem: 'Question',
      discription: "Answer",
      colorsItem: Colors.black,
    ),
    ItemModel(
      headerItem: 'Question',
      discription: "Answer",
      colorsItem: Colors.black,
    ),
    ItemModel(
      headerItem: 'Question',
      discription:
          "Answer",
      colorsItem: Colors.black,
    ),
    ItemModel(
      headerItem: 'Question',
      discription: "Answer",
      colorsItem: Colors.black,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("FAQs", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: itemData.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: ExpansionPanelList(
                animationDuration: const Duration(milliseconds: 500),
                dividerColor: Colors.red,
                expandedHeaderPadding: const EdgeInsets.only(bottom: 0.0),
                elevation: 1,
                children: [
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          itemData[index].headerItem,
                          style: TextStyle(
                            color: itemData[index].colorsItem,
                            fontSize: 18,
                          ),
                        ),
                      );
                    },
                    body: Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            itemData[index].discription,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 15,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    isExpanded: itemData[index].expanded,
                  )
                ],
                expansionCallback: (int item, bool status) {
                  setState(() {
                    itemData[index].expanded = !itemData[index].expanded;
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
