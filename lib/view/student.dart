
import 'package:flutter/material.dart';
import 'package:studentbook/controller/user_service.dart';
import 'package:studentbook/model/student_model.dart';
import 'package:studentbook/view/student_add.dart';
import 'package:studentbook/view/student_edit.dart';

class Student extends StatefulWidget {
  const Student({Key? key}) : super(key: key);

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {

  late Future future;

  @override
  void initState() {
    super.initState();
    future = UserService().readUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student"),
        actions: [
          IconButton(onPressed: () {
            setState(() {
              future = UserService().readUsers();
            });
          }, icon: const Icon(Icons.refresh))
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          builder: (ctx, snapshot) {
            // Checking if future is resolved or not
            if (snapshot.connectionState == ConnectionState.done) {
              // If we got an error
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: const TextStyle(fontSize: 18),
                  ),
                );

                // if we got our data
              } else if (snapshot.hasData) {
                // Extracting data from snapshot object
                List data = snapshot.data;
                return data.isNotEmpty ? ListView.builder(
                  itemBuilder: (context,i) {
                    StudentModel studentModel = StudentModel.fromJson(data[i]);
                    return Card(
                      child: ListTile(
                        leading: Text(studentModel.id.toString()),
                        title: Text(studentModel.name),
                        subtitle: Text(studentModel.number.toString()),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(onPressed: () async {
                                final res = await Navigator.push(context,MaterialPageRoute(builder: (context) => EditStudent(
                                  name: studentModel.name,
                                  number: studentModel.number,
                                  des: studentModel.description,
                                  id: int.parse("${studentModel.id}"),
                                )));
                                if(res != null) {
                                  setState(() {
                                    future = UserService().readUsers();
                                  });
                                }
                              }, icon: const Icon(Icons.edit,color: Colors.green)),
                              IconButton(onPressed: () async {
                                final res = await UserService().removeUser(studentModel.id!);
                                if(res != null) {
                                  setState(() {
                                    future = UserService().readUsers();
                                  });
                                }
                              }, icon: const Icon(Icons.delete,color: Colors.red)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: data.length,
                ) : const Center(
                  child: Text("No Data"),
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          future: future,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final res = await Navigator.push(context,MaterialPageRoute(builder: (context) => const AddStudent()));
          if(res != null) {
            setState(() {
              future = UserService().readUsers();
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
