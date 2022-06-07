import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class JsonParsing extends StatefulWidget {
  const JsonParsing({Key? key}) : super(key: key);

  @override
  State<JsonParsing> createState() => _JsonParsingState();
}

class _JsonParsingState extends State<JsonParsing> {
  Future? data;

  @override
  void initState() {
    super.initState();
    data = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                //return Text(snapshot.data[0]["title"]);
                //return Text(snapshot.data[0]["userId"].toString());
                return createListView(snapshot.data, context);
              } else if (snapshot.hasError) {
                return Icon(Icons.error_outline);
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}

Future getData() {
  var data;
  String url = "https://jsonplaceholder.typicode.com/posts";
  Network network = Network(url);
  data = network.fetchData();
  /*data.then((value){
      print(value);                    //show all data from JSON.
      print(value[0]);                //id 1 mean 0 index value will show.
      print(value[0] ['title']);     //only title will show (into the JSON).
    });*/
  return data;
}

Widget createListView(List data, BuildContext context) {
  //data type is list. cause we are getting data from JSON as a list
  // and also listViewBuilder require a list
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, int index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Divider(
              height: 5.0,
            ),
            ListTile(
                title: Text("${data[index]['title']}"),
                subtitle: Text("${data[index]['body']}"),
                leading: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 23,
                      child: Text(
                        "${data[index]['id']}",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                )),
          ],
        );
      });
}

class Network {
  final String url;

  Network(this.url);

  Future fetchData() async {
    //print("$url");
    Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      //ok
      //print(response.body[0]);
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
