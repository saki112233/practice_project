import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled9/allScreens/home_screen/update_screen.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var data;
   fetchData() async {
    var response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    setState((){
      var decode=jsonDecode(response.body);
      data=decode;
      print(data.length);
    });
  }
  @override
  void initState() {
    super.initState();
    setState((){this.fetchData();});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>UpdateScreen()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("User"),
        centerTitle: true,
      ),
      body: Container(
        child:ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                Divider(
                  thickness: 2,
                ),
            itemCount:data==null?0: data.length,
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
                            data.removeAt(i);

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
                    data.removeAt(i);
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
                    data[i]["title"],
                  ),
                  subtitle: Text(data[i]["body"]),
                ),
              );
            })
      ),
    );
  }
}

// ListView.separated(
// separatorBuilder: (BuildContext context, int index) =>
// Divider(
// thickness: 2,
// ),
// itemCount: (snapshot.data as dynamic).length,
// itemBuilder: (context, i) {
// Future exitDialog(){
// return showDialog(context: context, builder: (context){
// return AlertDialog(
// title: Text("Delete"),
// content: Row(
// children: [
// ElevatedButton(onPressed: (){
// Navigator.pop(context);
// }, child: Text("No")),
// SizedBox(width: 20,),
// ElevatedButton(onPressed: (){
// setState(() {
// (snapshot.data as dynamic).removeAt(i);
// Navigator.pop(context);
// });
// }, child: Text("Yes"))
// ],
// ),
// );
// });
// }
// return Dismissible(
// direction: DismissDirection.endToStart,
// background: Card(
// color: Colors.red,
// ),
// key: UniqueKey(),
// onDismissed: (direction) {
// setState(() {
// (snapshot.data as dynamic).removeAt(i);
// });
// },
// child: ListTile(
// onTap: (){},
// trailing: IconButton(
// key: UniqueKey(),
// onPressed: () {
// setState(() {
// exitDialog();
// });
// },
// icon: Icon(
// Icons.delete,
// )),
// title: Text(
// (snapshot.data as dynamic)[i].title,
// ),
// subtitle: Text((snapshot.data as dynamic)[i].body),
// ),
// );
// })
