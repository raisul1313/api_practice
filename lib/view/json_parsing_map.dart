import 'dart:convert';
import 'package:api_practice/model/Post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class JsonParsingMap extends StatefulWidget {
  const JsonParsingMap({Key? key}) : super(key: key);

  @override
  State<JsonParsingMap> createState() => _JsonParsingMapState();
}

class _JsonParsingMapState extends State<JsonParsingMap> {
  Future<PostList>? data;

  @override
  void initState() {
    super.initState();
    Network network = Network('https://jsonplaceholder.typicode.com/albums');
    data = network.loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: FutureBuilder(
              future: data,
              builder:
                  (BuildContext context, AsyncSnapshot<PostList> snapshot) {
                List<Post>? allPosts;
                if (snapshot.hasData) {
                  allPosts = snapshot.data?.posts;
                  return createListView(allPosts!, context);
                } else if (snapshot.hasError) {
                  return Icon(Icons.error_outline);
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }
}

Widget createListView(List<Post> data, BuildContext context) {
  return Container(
    child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, int index) {
          return Column(
            children: [
              Divider(
                height: 5.0,
              ),
              ListTile(
                title: Text("${data[index].title}"),
                subtitle: Text("${data[index].userId}"),
                leading: CircleAvatar(
                  backgroundColor: Colors.amber,
                  radius: 23,
                  child: Text(
                    "${data[index].id}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          );
        }),
  );
}

class Network {
  final String url;

  Network(this.url);

  Future<PostList> loadPosts() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return PostList.fromJson(jsonDecode(response.body)); //we get json object
    } else {
      throw Exception("failed to get post");
    }
  }
}
