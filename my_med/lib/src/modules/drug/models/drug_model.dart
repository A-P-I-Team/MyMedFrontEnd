class DrugModel {
  DrugModel({
    required this.id,
    required this.prescription,
    required this.medicine,
    required this.dosage,
    required this.fraction,
    required this.days,
    required this.consumptionStart,
    required this.isActive,
  });

  final int id;
  final int prescription;
  final String medicine;
  final int dosage;
  final String fraction;
  final String? consumptionStart;
  final bool? isActive;
  final int days;

  factory DrugModel.fromJson(Map<String, dynamic> json) => DrugModel(
        id: json["id"],
        prescription: json["prescription"],
        medicine: json["medicine"],
        dosage: json["dosage"],
        fraction: json["fraction"],
        days: json["days"],
        consumptionStart: json["start"],
        isActive: json["notify"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prescription": prescription,
        "medicine": medicine,
        "dosage": dosage,
        "fraction": fraction,
        "days": days,
      };
}
