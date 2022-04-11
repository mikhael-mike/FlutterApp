import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:quizapp/model/post.dart';

class JsonParsingMap extends StatefulWidget {
  const JsonParsingMap({ Key? key }) : super(key: key);

  @override
  State<JsonParsingMap> createState() => _JsonParsingMapState();
}

class _JsonParsingMapState extends State<JsonParsingMap> {

  late Future<PostList> data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Network network = Network('https://jsonplaceholder.typicode.com/posts');
    data = network.loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PODO'),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
            future: data,
            builder: (context, AsyncSnapshot<PostList> snapshot) {
              List<Post> allPosts;
              if(snapshot.hasData) {
                allPosts = snapshot.data!.posts;
                return createListView(allPosts, context);
              } else {
                return CircularProgressIndicator();
              }
            }
          ),
        ),
      ),
    );
  }

  Widget createListView(List<Post>data, BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, int index) {
          return Column(
            children: <Widget>[
              Divider(height: 5.0,),
              ListTile(
                title: Text('title: ${data[index].title}'),
                subtitle: Text('${data[index].body}'),
                leading: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 23,
                      child: Text('${data[index].id}'),
                    )
                  ],
                ),
              )
            ],
          );
        }
      )
    );
  }
}

class Network {
  final String url;

  Network(this.url);

  Future<PostList> loadPosts() async {

    final Response response = await get(Uri.parse(url));

    if(response.statusCode == 200) {
      return PostList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get posts');
    }


  }

}