class ActivePrescriptionModel {
  ActivePrescriptionModel({
    required this.id,
    required this.name,
    required this.dosage,
    required this.createdAt,
    required this.consumptionMethod,
    required this.consumptionAmount,
    required this.reminders,
    required this.consumptionTimes,
    required this.consumptionDuration,
  });

  final String id;
  final String name;
  final double dosage;
  final DateTime createdAt;
  final String consumptionMethod;
  final String consumptionAmount;
  List<ReminderModel> reminders;
  final int consumptionTimes;
  final String consumptionDuration;

  factory ActivePrescriptionModel.fromJson(Map<String, dynamic> json) =>
      ActivePrescriptionModel(
        id: json["id"] as String,
        name: json["name"] as String,
        dosage: json["dosage"] as double,
        createdAt: DateTime.parse(json["created_at"]),
        consumptionMethod: json["consumption_method"] as String,
        consumptionAmount: json["consumption_amount"] as String,
        reminders: List<ReminderModel>.from(
          json["reminders"].map(
            (x) => ReminderModel.fromJson(
              json: x,
              name: json["name"] as String,
              amount: json["consumption_amount"] as String,
              method: json["consumption_method"] as String,
              prescriptionId: json["id"] as String,
            ),
          ),
        ),
        consumptionTimes: json["consumption_times"] as int,
        consumptionDuration: json["consumption_duration"] as String,
      );
}

class ReminderModel {
  ReminderModel({
    required this.id,
    required this.prescriptionId,
    required this.timeToTake,
    required this.taken,
    required this.name,
    required this.consumptionMethod,
    required this.consumptionAmount,
  });

  final String id;
  final String prescriptionId;
  final String name;
  final String consumptionMethod;
  final String consumptionAmount;
  final DateTime timeToTake;
  bool? taken;

  factory ReminderModel.fromJson({
    required Map<String, dynamic> json,
    name,
    amount,
    method,
    prescriptionId,
  }) =>
      ReminderModel(
        id: json["id"],
        prescriptionId: prescriptionId,
        timeToTake: DateTime.parse(json["time_to_take"]),
        taken: json["taken"],
        name: name,
        consumptionMethod: method,
        consumptionAmount: amount,
      );
}
