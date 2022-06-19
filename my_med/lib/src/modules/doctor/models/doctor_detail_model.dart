class DoctorDetailModel {
  DoctorDetailModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profilePic,
    required this.msn,
    required this.degree,
    required this.field,
    required this.experience,
    required this.about,
    required this.hoursOfWork,
    required this.address,
    required this.phone,
    required this.officeno,
    required this.latitude,
    required this.longitude,
    required this.prescriptionDate,
    required this.prescriptionsNum,
    required this.medicinesNum,
  });

  final int id;
  final String firstName;
  final String lastName;
  final dynamic profilePic;
  final String msn;
  final String degree;
  final String field;
  final int experience;
  final String about;
  final String hoursOfWork;
  final String address;
  final String phone;
  final String officeno;
  final double latitude;
  final double longitude;
  final DateTime prescriptionDate;
  final int prescriptionsNum;
  final int medicinesNum;

  factory DoctorDetailModel.fromJson(Map<String, dynamic> json) =>
      DoctorDetailModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        profilePic: json["profile_pic"],
        msn: json["msn"],
        degree: json["degree"],
        field: json["field"],
        experience: json["experience"],
        about: json["about"],
        hoursOfWork: json["hours_of_work"],
        address: json["address"],
        phone: json["phone"],
        officeno: json["officeno"],
        latitude: double.parse(json["latitude"]),
        longitude: double.parse(json["longitude"]),
        prescriptionDate: DateTime.parse(json["prescription_date"]),
        prescriptionsNum: json["prescriptions_num"],
        medicinesNum: json["medicines_num"],
      );
}
