import 'package:hive/hive.dart';

part 'active_prescription_detail_model.g.dart';

@HiveType(typeId: 0)
class ActivePrescriptionDetailModel {
  ActivePrescriptionDetailModel({
    required this.id,
    required this.medicine,
    required this.dosage,
    required this.fraction,
    required this.days,
    required this.elapsed,
    required this.remaining,
    required this.progress,
    required this.description,
    required this.doctor,
    required this.start,
    required this.period,
    required this.count,
    required this.takenno,
    required this.nottakenno,
    required this.notify,
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String medicine;
  @HiveField(2)
  final int dosage;
  @HiveField(3)
  final String fraction;
  @HiveField(4)
  final int days;
  @HiveField(5)
  final int elapsed;
  @HiveField(6)
  final int remaining;
  @HiveField(7)
  final double progress;
  @HiveField(8)
  final String description;
  @HiveField(9)
  final Doctor doctor;
  @HiveField(10)
  final DateTime start;
  @HiveField(11)
  final int period;
  @HiveField(12)
  final int count;
  @HiveField(13)
  final int takenno;
  @HiveField(14)
  final int nottakenno;
  @HiveField(15)
  bool notify;

  factory ActivePrescriptionDetailModel.fromJson(
          Map<String, dynamic> json, String id) =>
      ActivePrescriptionDetailModel(
        medicine: json["medicine"],
        dosage: json["dosage"],
        fraction: json["fraction"],
        days: json["days"],
        elapsed: json["elapsed"],
        remaining: json["remaining"],
        progress: json["progress"],
        description: json["description"],
        doctor: Doctor.fromJson(json["doctor"]),
        start: DateTime.parse(json["start"]),
        period: json["period"],
        count: json["count"],
        takenno: json["takenno"],
        nottakenno: json["nottakenno"],
        notify: json["notify"],
        id: id,
      );
}

@HiveType(typeId: 1)
class Doctor {
  Doctor({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profilePic,
    required this.degree,
    required this.field,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final String? profilePic;
  @HiveField(4)
  final String degree;
  @HiveField(5)
  final String field;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        profilePic: json["profile_pic"],
        degree: json["degree"],
        field: json["field"],
      );
}
