
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response =
  await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // A 200 OK response means
    // ready to parse the JSON.
    return Album.fromJson(json.decode(response.body));
  } else {
    // If not a 200 ok response
    // means throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<Album> deleteAlbum(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Item Not Deleted!');
  }
}

class Album {
  final int id;
  final String title;

  Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  late Future<Album> _futureAlbum;

  @override
  void initState() {
    super.initState();
    _futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Deletion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('GeeksForGeeks'),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: _futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('${snapshot.data?.title ?? 'Deleted'}'),
                      RaisedButton(
                        child: Text('Delete Data'),
                        onPressed: () {
                          setState(() {
                            _futureAlbum =
                                deleteAlbum(snapshot.data.id.toString());
                          });
                        },
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
// MaterialApp(
// title: 'Data Deletion',
// theme: ThemeData(
// primarySwatch: Colors.blue,
// ),
// home: Scaffold(
// appBar: AppBar(
// title: Text('GeeksForGeeks'),
// backgroundColor: Colors.green,
// ),
// body: Center(
// child: FutureBuilder<Album>(
// future: _futureAlbum,
// builder: (context, snapshot) {
// if (snapshot.connectionState == ConnectionState.done) {
// if (snapshot.hasData) {
// return Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: <Widget>[
// Text('${snapshot.data?.title ?? 'Deleted'}'),
// RaisedButton(
// child: Text('Delete Data'),
// onPressed: () {
// setState(() {
// _futureAlbum =
// deleteAlbum(snapshot.data.id.toString());
// });
// },
// ),
// ],
// );
// } else if (snapshot.hasError) {
// return Text("${snapshot.error}");
// }
// }
// return CircularProgressIndicator();
// },
// ),
// ),
// ),
// )
