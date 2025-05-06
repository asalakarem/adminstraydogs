class OrgModel {
  final int? ngoId;
  final String? name;
  final String? email;
  final String? password;
  final String? address;
  final int? phoneNumber;
  final String? dateJoined;
  final int? approvedNgo;

  OrgModel({
    required this.ngoId,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.phoneNumber,
    required this.dateJoined,
    required this.approvedNgo,
  });

  factory OrgModel.fromJson(Map<String, dynamic> json) {
    return OrgModel(
      ngoId: json['ngoId'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      dateJoined: json['dateJoined'],
      approvedNgo: json['approvedNgo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ngoId': ngoId,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'phoneNumber': phoneNumber,
      'dateJoined': dateJoined,
      'approvedNgo': approvedNgo,
    };
  }
}
