class DoctorModelMock {
  final String id;
  final String name;
  final String? profession;
  final String? imageURL;

  DoctorModelMock({
    required this.id,
    required this.name,
    required this.profession,
    this.imageURL =
        "https://www.sketchappsources.com/resources/source-image/doctor-illustration-hamamzai.png",
  });
}

class DoctorModel {
  DoctorModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profilePic,
    required this.userCity,
    required this.field,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String? profilePic;
  final int userCity;
  final String? field;

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        profilePic: json["profile_pic"],
        userCity: json["user_city"],
        field: json["field"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "profile_pic": profilePic,
        "user_city": userCity,
        "field": field,
      };
}
