class LoginModel
{
  late bool status;
  String? message;
  UserData? data;

  LoginModel.fromJson(Map<String, dynamic>? json)
  {
    status = json!['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

}

class UserData
{
  // "id": 2589,
  // "name": "Ahmed Halim",
  // "email": "halimjr95@gmail.com",
  // "phone": "01156180333",
  // "image": "https://student.valuxapps.com/storage/uploads/users/T1nF9NP3Oh_1628790182.jpeg",
  // "points": 0,
  // "credit": 0,
  // "token":


  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  int? points;
  int? credit;
  late String token;

  UserData.fromJson(Map<String, dynamic>? json)
  {
    id = json!['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }

}