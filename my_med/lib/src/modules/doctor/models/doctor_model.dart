class DoctorModel {
  final String id;
  final String name;
  final String? profession;
  final String? imageURL;

  DoctorModel({
    required this.id,
    required this.name,
    required this.profession,
    this.imageURL =
        "https://www.sketchappsources.com/resources/source-image/doctor-illustration-hamamzai.png",
  });
}
