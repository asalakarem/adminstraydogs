class LoginModel {
  final int? userId;
  final String? name;
  final String? email;
  final String? password;
  final int? phoneNumber;

  LoginModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
    };
  }
}
