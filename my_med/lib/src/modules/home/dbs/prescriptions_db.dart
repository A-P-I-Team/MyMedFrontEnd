import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_med/src/modules/home/models/prescription_detail_model.dart';

class PrescriptionDB {
  static final PrescriptionDB instance = PrescriptionDB._();
  PrescriptionDB._();
  static const medicationsBoxName = 'Medications';
  late Box<PrescriptionModel> activePrescriptionsDetailsDB;

  Future<void> initializeActivePrescriptionsDetailsDB() async {
    activePrescriptionsDetailsDB = await Hive.openBox(medicationsBoxName);
  }

  void addActivePrescriptionsDetails(PrescriptionModel value) {
    activePrescriptionsDetailsDB.put(value.id, value);
  }

  PrescriptionModel? getActivePrescriptionDetailModel(String id) {
    return activePrescriptionsDetailsDB.get(id);
  }
}
