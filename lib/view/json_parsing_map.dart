import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class JsonParsingMap extends StatefulWidget {
  const JsonParsingMap({Key? key}) : super(key: key);

  @override
  State<JsonParsingMap> createState() => _JsonParsingMapState();
}

class _JsonParsingMapState extends State<JsonParsingMap> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
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
