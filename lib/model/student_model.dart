/*

{
  "id" : 1.,
  "name" : "john",
  "number" : 1234567890,
  "description" : "Test Users"
}


 */

class StudentModel {
  StudentModel({
    this.id,
    required this.name,
    required this.number,
    required this.description,
  });
  late final int? id;
  late final String name;
  late final int number;
  late final String description;

  StudentModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    number = json['number'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['number'] = number;
    data['description'] = description;
    return data;
  }
}
