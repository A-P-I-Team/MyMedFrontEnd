class UserModel {
  UserModel({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.ssn,
    required this.gender,
    required this.birthdate,
    required this.userCityID,
    required this.relationshipStatus,
    required this.isVaccinated,
  });

  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String relationshipStatus;
  final String isVaccinated;
  final String ssn;
  final String gender;
  final String birthdate;
  final String userCityID;

  factory UserModel.fromJson(Map<String, String> json) => UserModel(
        username: json["username"] as String,
        password: json["password"] as String,
        firstName: json["first_name"] as String,
        lastName: json["last_name"] as String,
        relationshipStatus: json["relationship_status"] as String,
        isVaccinated: json["isVaccinated"] as String,
        ssn: json["ssn"] as String,
        gender: json["gender"] as String,
        birthdate: json["birthdate"] as String,
        userCityID: json["user_city"] as String,
      );

  Map<String, String> toJson() => {
        "username": username,
        "password": password,
        "first_name": firstName,
        "last_name": lastName,
        "relationship_status": relationshipStatus,
        "isVaccinated": isVaccinated,
        "ssn": ssn,
        "gender": gender,
        "birthdate": birthdate,
        "user_city": userCityID,
      };

  static String getGender(String userGender) {
    if (userGender == 'Female') {
      return "F";
    }
    if (userGender == 'Male') {
      return "M";
    }
    return "O";
  }
}

enum Genders { female, male, others }
