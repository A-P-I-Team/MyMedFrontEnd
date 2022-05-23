class Patient {
  String fullName;
  String? gender;
  String? dateOfBirth;
  String email;
  String identification;

  Patient({
    required this.fullName,
    this.gender,
    this.dateOfBirth,
    required this.email,
    required this.identification,
  });
}
