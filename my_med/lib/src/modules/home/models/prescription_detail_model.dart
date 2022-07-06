import 'package:hive_flutter/adapters.dart';

part 'prescription_detail_model.g.dart';

@HiveType(typeId: 0)
class PrescriptionModel {
  PrescriptionModel({
    required this.id,
    required this.name,
    required this.dosage,
    required this.doctor,
    required this.consumptionAmount,
    required this.consumptionStart,
    required this.consumptionTimes,
    required this.consumptionDuration,
    required this.consumptionMethod,
    required this.description,
    required this.changeRequests,
    required this.isActive,
    required this.isGreen,
    required this.isReminderOn,
    // required this.takenReminderCount,
    // required this.countAllReminders,
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double dosage;
  @HiveField(3)
  final Doctor doctor;
  @HiveField(4)
  final String consumptionAmount;
  @HiveField(5)
  final DateTime? consumptionStart;
  @HiveField(6)
  final int consumptionTimes;
  @HiveField(7)
  final String consumptionDuration;
  @HiveField(8)
  final String description;
  @HiveField(9)
  final List<dynamic> changeRequests;
  @HiveField(10)
  final bool isActive;
  @HiveField(11)
  final bool isGreen;
  @HiveField(12)
  final String consumptionMethod;
  //TODO should be sync with the server
  @HiveField(13)
  bool isReminderOn;
  // @HiveField(14)
  // int takenReminderCount;
  // @HiveField(15)
  // int countAllReminders;

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) =>
      PrescriptionModel(
        id: json["id"],
        name: json["name"],
        dosage: json["dosage"],
        doctor: Doctor.fromJson(json["doctor"]),
        consumptionAmount: json["consumption_amount"],
        consumptionStart: (json["consumption_start"] == null)
            ? null
            : DateTime.parse(json["consumption_start"]),
        consumptionTimes: json["consumption_times"],
        consumptionMethod: json["consumption_method"] as String,
        consumptionDuration: json["consumption_duration"],
        description: json["description"],
        changeRequests:
            List<dynamic>.from(json["change_requests"].map((x) => x)),
        isActive: json["is_active"],
        isGreen: json["is_green"],
        isReminderOn: true,
        // takenReminderCount: json['taken_reminder_count'],
        // countAllReminders: json['count_all_reminders'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "dosage": dosage,
        "doctor": doctor.toJson(),
        "consumption_amount": consumptionAmount,
        "consumption_start": (consumptionStart == null)
            ? null
            : consumptionStart!.toIso8601String(),
        "consumption_times": consumptionTimes,
        "consumption_duration": consumptionDuration,
        "consumption_method": consumptionMethod,
        "description": description,
        "change_requests": List<dynamic>.from(changeRequests.map((x) => x)),
        "is_active": isActive,
        "is_green": isGreen,
        "is_reminder_on": isReminderOn,
        // "taken_reminder_count": takenReminderCount,
        // "count_all_reminders": countAllReminders
      };
}

@HiveType(typeId: 1)
class Doctor {
  Doctor({
    required this.id,
    required this.name,
    required this.profession,
    required this.avatar,
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String profession;
  @HiveField(3)
  final Avatar avatar;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["id"],
        name: json["name"],
        profession: json["profession"],
        avatar: Avatar.fromJson(json["avatar"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "profession": profession,
        "avatar": avatar.toJson(),
      };
}

@HiveType(typeId: 2)
class Avatar {
  Avatar({
    required this.file,
  });

  @HiveField(0)
  final String file;

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "file": file,
      };
}
