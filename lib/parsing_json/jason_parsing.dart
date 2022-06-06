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
      appBar: AppBar(
        title: Text("Parsing Json"),
        centerTitle: true,
      ),
    );
  }

  Future getData(){
    var data;
    String url = "https://jsonplaceholder.typicode.com/posts";
    Network network = Network(url);
    data =  network.fetchData();
    return data;
  }
}

class Network {
  final String url;

  Network(this.url);

  Future fetchData() async {
    print("$url");
    Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      //ok
      print(response.body);
      return response.body;
    } else {
      print(response.statusCode);
    }
  }
}
