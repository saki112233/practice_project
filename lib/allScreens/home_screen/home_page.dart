import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled9/allScreens/home_screen/service/home_list.dart';
import 'package:untitled9/allScreens/home_screen/service/post_service.dart';
import 'package:untitled9/allScreens/home_screen/update_screen.dart';
import '../../model/api_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // var dd=dataToJson();
  bool isLoading = false;
  getPost() async {
    final prefs = await SharedPreferences.getInstance();
    isLoading = true;
    // postList = await GetPostService().fetchData();
   await Bb.loadData();
    setState(() {
      isLoading = false;
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
    void addUpdatedList(Data data) {
      setState(() {
        Bb.postList.add(data);
      });
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (context) => AddTask(addUser: addUpdatedList)),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("User"),
        centerTitle: true,
      ),
      body: Container(
          child: isLoading
              ? CircularProgressIndicator()
              : ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                        thickness: 2,
                      ),
                  itemCount: Bb.postList.length,
                  itemBuilder: (context, i) {
                    Future exitDialog() {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Delete"),
                              content: Row(
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("No")),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        // print(bb.postList.length);
                                        setState(() {
                                         Bb.removeData(i);
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Text("Yes"))
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
                          Bb.postList.removeAt(i);
                        });
                      },
                      child: ListTile(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) => ModifyData(index: i,));
                        },
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
                          Bb.postList[i].title.toString(),
                        ),
                        subtitle: Text(Bb.postList[i].body.toString()),
                      ),
                    );
                  })),
    );
  }
}

class ModifyData extends StatefulWidget {
  const ModifyData({
    required this.index,
    Key? key,
  }) : super(key: key);
 final int index;

  @override
  State<ModifyData> createState() => _ModifyDataState(i: index);
}

class _ModifyDataState extends State<ModifyData> {
   final int i;
  final GlobalKey _formkey=GlobalKey<FormState>();

  _ModifyDataState({required this.i});
  @override
  Widget build(BuildContext context) {
    var titleController = TextEditingController();
    var descriptionController = TextEditingController();
    Widget buildTextfield(String hint, TextEditingController controller,) {
      return Container(
        margin: EdgeInsets.all(4),
        child: TextFormField(

          controller: controller,
          decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38))),
        ),
      );
    }
    Widget buildDescriptionTextfield(String hint, TextEditingController controller,) {
      return Container(
        margin: EdgeInsets.all(4),
        child: TextFormField(
          onSaved:(v){v=descriptionController.text;},
          controller: controller,
          decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38))),
        ),
      );
    }
    return Container(
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            Text(
              'Modify',
              style: TextStyle(fontSize: 30, color: Colors.lightBlue),
            ),
            buildTextfield('tile', titleController,),
            buildDescriptionTextfield('description', descriptionController),
            ElevatedButton(
                onPressed: () {
                   setState((){
                     Data data=Data(title:titleController.text, body: descriptionController.text);
                    Bb.upDateData(i,data);
                   });
                },
                child: Text('update'))
          ],
        ),
      ),
    );
  }
}
