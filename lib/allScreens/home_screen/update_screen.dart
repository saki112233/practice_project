import 'package:flutter/material.dart';
import 'package:untitled9/allScreens/home_screen/service/home_list.dart';
import '../../model/api_model.dart';

class AddTask extends StatefulWidget {
  final Function(Data) addUser;
  const AddTask({
    Key? key,
    required this.addUser,
  }) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {

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
        key: _formKey,
        child: Column(
          children: [
            Text(
              'Update',
              style: TextStyle(fontSize: 30, color: Colors.lightBlue),
            ),
            buildTextfield('tile', titleController,),
            buildDescriptionTextfield('description', descriptionController),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    final data = Data(
                            title: titleController.text,
                             body: descriptionController.text,
                         );
                           Bb.addData(data);
                  });
                  // setState((){
                  //   final data = Data(
                  //     title: titleController.text,
                  //     body: descriptionController.text,
                  //   );
                  //   Bb.addData(data);
                  // });

                  Navigator.pop(context);
                },
                child: Text('update'))
          ],
        ),
      ),
    );
  }
}
