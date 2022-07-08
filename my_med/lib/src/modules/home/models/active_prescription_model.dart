class ActivePrescriptionModel {
  ActivePrescriptionModel({
    required this.id,
    required this.prescription,
    required this.medicine,
    required this.dosage,
    required this.fraction,
    required this.days,
    required this.start,
    required this.period,
    required this.reminders,
    required this.takenno,
    required this.notify,
    required this.consumptionDuration,
  });

  final String id;
  final int prescription;
  final String medicine;
  final int dosage;
  final String fraction;
  final int days;
  final DateTime start;
  final int period;
  List<ReminderModel> reminders;
  final int takenno;
  final bool notify;
  final String consumptionDuration;

  factory ActivePrescriptionModel.fromJson(Map<String, dynamic> json) =>
      ActivePrescriptionModel(
        id: json["id"].toString(),
        prescription: json["prescription"],
        medicine: json["medicine"],
        dosage: json["dosage"],
        fraction: json["fraction"],
        days: json["days"],
        start: DateTime.parse(json["start"]),
        period: json["period"],
        reminders: List<ReminderModel>.from(json["reminders"]
            .map((x) => ReminderModel.fromJson(x, json["medicine"]))),
        takenno: json["takenno"],
        notify: json["notify"],
        consumptionDuration: json["description"],
      );
}

class ReminderModel {
  ReminderModel({
    required this.id,
    required this.dateTime,
    required this.status,
    required this.name,
  });

  final String id;
  final DateTime dateTime;
  bool? status;
  final String name;

  factory ReminderModel.fromJson(
    Map<String, dynamic> json,
    String name,
  ) =>
      ReminderModel(
        id: json["id"].toString(),
        dateTime: DateTime.parse(json["date_time"]),
        status: json["status"],
        name: name,
      );
}
