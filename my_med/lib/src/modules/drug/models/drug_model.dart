import 'package:my_med/src/modules/doctor/models/doctor_model.dart';

class DrugModel {
  final String id;
  final String name;
  final double dosage;
  final DoctorModelMock doctor;
  final String consumptionAmount;
  final String? consumptionStart;
  final int consumptionTimes;
  final String consumptionDuration;
  final String description;
  final List<dynamic> changeRequests;
  final bool isActive;
  final bool isGreen;

  DrugModel({
    required this.id,
    required this.name,
    required this.dosage,
    required this.doctor,
    required this.consumptionAmount,
    required this.consumptionStart,
    required this.consumptionTimes,
    required this.consumptionDuration,
    required this.description,
    required this.changeRequests,
    required this.isActive,
    required this.isGreen,
  });
}
