class ActivePrescriptionReminderModel {
  ActivePrescriptionReminderModel({
    required this.id,
    required this.timeToTake,
    required this.taken,
  });

  final String id;
  final DateTime timeToTake;
  final bool? taken;

  factory ActivePrescriptionReminderModel.fromJson(Map<String, dynamic> json) =>
      ActivePrescriptionReminderModel(
        id: json["id"],
        timeToTake: DateTime.parse(json["time_to_take"]),
        taken: json["taken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "time_to_take":
            "${timeToTake.year.toString().padLeft(4, '0')}-${timeToTake.month.toString().padLeft(2, '0')}-${timeToTake.day.toString().padLeft(2, '0')}",
        "taken": taken,
      };
}
