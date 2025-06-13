class RequestModel {
  final int? requestId;
  final int? userId;
  final String? status;
  final String? submissionTime;
  final String? description;
  final int? dogsCount;
  final String? streetAddress;
  final String? userName;
  final int? phoneNumber;
  final String? acceptedDate;
  final String? missionDoneDate;
  final String? acceptedNgo;
  final String? missionDoneNgo;
  final double latitude;
  final double longitude;
  final String? dogImage;

  RequestModel({
    required this.requestId,
    required this.userId,
    required this.status,
    required this.submissionTime,
    required this.description,
    required this.dogsCount,
    required this.streetAddress,
    required this.userName,
    required this.phoneNumber,
    required this.acceptedDate,
    required this.missionDoneDate,
    required this.acceptedNgo,
    required this.missionDoneNgo,
    required this.latitude,
    required this.longitude,
    required this.dogImage,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      requestId: json['requestId'],
      userId: json['userId'],
      status: json['status'],
      submissionTime: json['submissionTime'],
      description: json['description'],
      dogsCount: json['dogsCount'],
      streetAddress: json['streetAddress'],
      userName: json['userName'],
      phoneNumber: json['phoneNumber'],
      acceptedDate: json['acceptedDate'],
      missionDoneDate: json['missionDoneDate'],
      acceptedNgo: json['acceptedNgo'],
      missionDoneNgo: json['missionDoneNgo'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      dogImage: json['dogImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requestId': requestId,
      'userId': userId,
      'status': status,
      'submissionTime': submissionTime,
      'description': description,
      'dogsCount': dogsCount,
      'streetAddress': streetAddress,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'acceptedDate': acceptedDate,
      'missionDoneDate': missionDoneDate,
      'acceptedNgo': acceptedNgo,
      'missionDoneNgo': missionDoneNgo,
      'latitude': latitude,
      'longitude': longitude,
      'dogImage': dogImage,
    };
  }
}
