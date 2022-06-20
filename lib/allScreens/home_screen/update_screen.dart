import 'package:flutter/material.dart';
import 'package:untitled9/allScreens/home_screen/home_page.dart';
class UpdateScreen extends StatefulWidget {

  const UpdateScreen({Key? key,}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    var titleController=TextEditingController();
    var bodyController=TextEditingController();
    Widget buildTextfield(String hint,TextEditingController controller){
      return Container(
        margin: EdgeInsets.all(4),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: hint,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black38
                )
              )
          ),
        ),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTextfield('title',titleController ),
              buildTextfield("body", bodyController),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                HomePage()));
              }, child: Text('Update',),)
            ],
          ),
        ),
      ),
    );
  }
}
