
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future getUserData() async {
    var response = await http.get(
      Uri.https("jsonplaceholder.typicode.com", "posts"),
    );
    var jsonData = jsonDecode(response.body);
    List<UserList> users = [];
    for (var u in jsonData) {
      UserList user = UserList(title: u['title'], body: u['body'], id: u['id']);
      users.add(user);
    }
    print(users.length);
    return users;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("User"),
        centerTitle: true,
      ),
      body: Container(
        child: Card(
          child: FutureBuilder(
            future: getUserData(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Text("loading"),
                );
              } else {
                return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                          thickness: 2,
                        ),
                    itemCount: (snapshot.data as dynamic).length,
                    itemBuilder: (context, i) {
                      return Container(
                        child: ListTile(
                          title: Text(
                            (snapshot.data as dynamic)[i].id.toString(),
                          ),
                          subtitle: Text((snapshot.data as dynamic)[i].title),
                        ),
                      );
                    });
              }
            },
          ),
        ),
      ),
    );
  }
}
class UserList {
  final String title, body;
  final int id;

  UserList({required this.title, required this.body, required this.id});
}


