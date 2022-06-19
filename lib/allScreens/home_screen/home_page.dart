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
  List<UserList> users = [];
  Future getUserData() async {
    var response = await http.get(
      Uri.https("jsonplaceholder.typicode.com", "posts"),
    );
    var jsonData = jsonDecode(response.body);
    for (var u in jsonData) {
      UserList user = UserList(u['title'], u['body'], u['id']);
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
                      Future exitDialog(){
                        return showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: Text("Delete"),
                            content: Row(
                              children: [
                                ElevatedButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text("No")),
                                SizedBox(width: 20,),
                                ElevatedButton(onPressed: (){
                                  setState(() {
                                    (snapshot.data as dynamic).removeAt(i);
                                    Navigator.pop(context);
                                  });
                                }, child: Text("Yes"))
                              ],
                            ),
                          );
                        });
                      }
                      return Dismissible(
                        direction: DismissDirection.endToStart,
                        background: Card(
                          color: Colors.red,
                        ),
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          setState(() {
                            (snapshot.data as dynamic).removeAt(i);
                          });
                        },
                        child: ListTile(
                          onTap: (){},
                          trailing: IconButton(
                              key: UniqueKey(),
                              onPressed: () {
                                setState(() {
                                  exitDialog();
                                });
                                },
                              icon: Icon(
                                Icons.delete,
                              )),
                          title: Text(
                            (snapshot.data as dynamic)[i].title,
                          ),
                          subtitle: Text((snapshot.data as dynamic)[i].body),
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

  UserList(this.title, this.body, this.id);
}

// gvsgavs
