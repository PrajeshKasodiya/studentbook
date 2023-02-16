
import 'package:studentbook/controller/repository.dart';
import 'package:studentbook/model/student_model.dart';

class UserService {

  late Repository repository;
  UserService() {
    repository = Repository();
  }

  // Insert
  Future<dynamic> saveUser(StudentModel studentModel) async {
    return await repository.insertData('users', studentModel.toJson());
  }

  // Fetch
  readUsers() async{
    return await repository.fetchData('users');
  }
  // Update
  Future<dynamic> editUser(int id,StudentModel studentModel) async {
    return await repository.updateData("users",studentModel.toJson(), id);
  }

  // Delete
  removeUser(int id) async {
    return await repository.deleteData("users", id);
  }
}
