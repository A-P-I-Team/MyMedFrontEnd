class UserProfileModel {
  UserProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.birthdate,
    required this.ssn,
    required this.citizensSsn,
    required this.userCity,
    required this.profilePic,
    required this.email,
  });

  final int id;
  String firstName;
  String lastName;
  String? gender;
  String birthdate;
  final String ssn;
  final String? citizensSsn;
  final UserCity userCity;
  final String profilePic;
  final String? email;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        birthdate: DateTime.parse(json["birthdate"]).toString().split(' ')[0],
        ssn: json["ssn"],
        citizensSsn: json["citizens_ssn"],
        userCity: UserCity.fromJson(json["user_city"]),
        profilePic: json["profile_pic"],
        email: json["username"],
      );
}

class UserCity {
  UserCity({
    required this.id,
    required this.cityName,
  });

  final int id;
  final String cityName;

  factory UserCity.fromJson(Map<String, dynamic> json) => UserCity(
        id: json["id"],
        cityName: json["city_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city_name": cityName,
      };
}
