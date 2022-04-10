import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';


class JsonParsingSimple extends StatefulWidget {
  const JsonParsingSimple({ Key? key }) : super(key: key);

  @override
  State<JsonParsingSimple> createState() => _JsonParsingSimpleState();
}

class _JsonParsingSimpleState extends State<JsonParsingSimple> {

  late Future data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = getData();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parsing Json'),
      ),
      body: Container(
        child: FutureBuilder(
          future: getData(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.hasData){
              // info about price
              return Text(snapshot.data[0]['title']);
            }
            return CircularProgressIndicator();
          },
        ),
      ),
      
    );
  }

  Future getData() async {
    var data;
    String url = 'https://dummyjson.com/products';
    Network network = Network(url);

    data = network.fetchData();
    // data.then((value) {
    //   print(value);
    // });
    // print(data);
    return data;
  }
}

class Network {
  final String url;

  Network(this.url);

  Future fetchData() async {
    print('${url}');

    Response response = await get(Uri.parse(url));

    if(response.statusCode == 200) {
      // print(response.body);
      print('Link true');
      return json.encode(response.body);
    } else {
      print(response.statusCode);
    }
  }

}