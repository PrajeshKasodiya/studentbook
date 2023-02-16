import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studentbook/controller/user_service.dart';
import 'package:studentbook/model/student_model.dart';

class EditStudent extends StatefulWidget {
  final String name;
  final int number;
  final String des;
  final int id;
  const EditStudent({Key? key,required this.name,required this.number,required this.des,required this.id}) : super(key: key);

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController decController = TextEditingController();


  @override
  void initState() {
    super.initState();
      nameController = TextEditingController(text: widget.name);
      numberController = TextEditingController(text: widget.number.toString());
      decController = TextEditingController(text: widget.des);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Student"),
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
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ], //
                  controller: numberController,
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
                    await UserService().editUser(widget.id, StudentModel(
                        name: nameController.text,
                        number: int.parse(numberController.text),
                        description: decController.text,
                      id: widget.id
                    )).then((value) {
                      Navigator.pop(context,true);
                    }).onError((error, stackTrace) {
                      final snackBar = SnackBar(
                        content: Text('$error'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  }
                }, child: const Text("Edit"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
