import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled9/allProvider/state_provider.dart';
import 'package:untitled9/allScreens/home_screen/service/home_service.dart';
import 'package:untitled9/allScreens/home_screen/service/post_service.dart';
import 'package:untitled9/allScreens/home_screen/update_screen.dart';
import '../../model/api_model.dart';

class HomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {




  // Future<Data> fetchData() async {
  //   final response =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  //   if(response.statusCode==200){
  //     print(response.body);
  //     return Data.fromJson(jsonDecode(response.body));
  //
  //   }else{
  //     print(response.statusCode);
  //     throw Exception('Failed');
  //   }
  // }
  @override
  void initState() {
    super.initState();
    ref.read(homeState.notifier).loadData();

  }

  @override
  Widget build(BuildContext context) {
    List<Data> data=ref.watch(homeState);
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
            itemCount:data.length,
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
                    data[i].title.toString(),
                  ),
                  subtitle: Text(data[i].body.toString()),
                ),
              );
            })
      ),
    );
  }
}


