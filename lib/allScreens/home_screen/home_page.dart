import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled9/allScreens/home_screen/service/post_service.dart';
import 'package:untitled9/allScreens/home_screen/update_screen.dart';
import '../../model/api_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // var dd=dataToJson();
List<Data>postList=[];
bool isLoading=false;
  getPost()async{
    final prefs=await SharedPreferences.getInstance();
     isLoading=true;
   postList=await GetPostService().fetchData();
   setState((){
     isLoading=false;
     prefs.get(postList.toString());
   });

  }

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
    getPost();
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
        child:isLoading?CircularProgressIndicator():ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                Divider(
                  thickness: 2,
                ),
            itemCount:postList.length,
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
                        ElevatedButton(onPressed: ()async{
                          print(postList.length);
                          final pref=await SharedPreferences.getInstance();
                          setState((){
                            pref.get(postList.toString());
                            postList.removeAt(i);
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
                    postList.removeAt(i);
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
                    postList[i].title.toString(),
                  ),
                  subtitle: Text(postList[i].body.toString()),
                ),
              );
            })
      ),
    );
  }
}


