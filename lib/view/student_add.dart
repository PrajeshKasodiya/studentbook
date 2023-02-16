import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studentbook/controller/user_service.dart';
import 'package:studentbook/model/student_model.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {

  // form key
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final decController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Student"),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      hintText: "Name",
                      labelText: "Name"
                  ),
                  validator: (v) {
                    if(v.toString().isEmpty) {
                      return "Please Enter Name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: numberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ], // Only numbers can be entered
                  decoration: const InputDecoration(
                      hintText: "Number",
                      labelText: "Number"
                  ),
                  validator: (v) {
                    if(v.toString().isEmpty) {
                      return "Please Enter Number";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: decController,
                  decoration: const InputDecoration(
                      hintText: "Des",
                      labelText: "Des"
                  ),
                  validator: (v) {
                    if(v.toString().isEmpty) {
                      return "Please Enter Des";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextButton(onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    await UserService().saveUser(StudentModel(
                      name: nameController.text,
                      number: int.parse(numberController.text),
                      description: decController.text
                    )).then((value) {
                      Navigator.pop(context,true);
                    }).onError((error, stackTrace) {
                     final snackBar = SnackBar(
                        content: Text('$error'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });

                  }
                }, child: const Text("Add"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
