class DrugDetailModel {
  DrugDetailModel({
    required this.medicine,
    required this.dosage,
    required this.fraction,
    required this.days,
    required this.elapsed,
    required this.remaining,
    required this.progress,
    required this.description,
    required this.doctor,
    required this.period,
    required this.nextReminder,
  });

  final String medicine;
  final int dosage;
  final String fraction;
  final int days;
  final int elapsed;
  final int remaining;
  final double progress;
  final String description;
  final Doctor doctor;
  final int period;
  final int? nextReminder;

  factory DrugDetailModel.fromJson(Map<String, dynamic> json) =>
      DrugDetailModel(
        medicine: json["medicine"],
        dosage: json["dosage"],
        fraction: json["fraction"],
        days: json["days"],
        elapsed: json["elapsed"],
        remaining: json["remaining"],
        progress: json["progress"],
        description: json["description"],
        period: json["period"],
        doctor: Doctor.fromJson(json["doctor"]),
        nextReminder: json['next_reminder'],
      );
}

class Doctor {
  Doctor({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profilePic,
    required this.degree,
    required this.field,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String? profilePic;
  final String degree;
  final String field;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        profilePic: json["profile_pic"],
        degree: json["degree"],
        field: json["field"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "profile_pic": profilePic,
        "degree": degree,
        "field": field,
      };
}
