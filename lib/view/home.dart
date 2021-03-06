import 'package:api_practice/view/jason_parsing.dart';
import 'package:api_practice/view/json_parsing_map.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Example"),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              //constraints: BoxConstraints(maxHeight: 150.0),
              child: TabBar(
                  labelColor: Colors.red,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Colors.red,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      text: "Parsing Simple JSON",
                    ),
                    Tab(
                      text: "Parsing JSON Map",
                    ),
                  ]),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  JsonParsing(),
                  JsonParsingMap()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
