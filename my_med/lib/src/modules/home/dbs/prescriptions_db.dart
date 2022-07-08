import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_med/src/modules/home/models/active_prescription_detail_model.dart';

class PrescriptionDB {
  static final PrescriptionDB instance = PrescriptionDB._();
  PrescriptionDB._();
  static const medicationsBoxName = 'Medications';
  late Box<ActivePrescriptionDetailModel> activePrescriptionsDetailsDB;

  Future<void> initializeActivePrescriptionsDetailsDB() async {
    activePrescriptionsDetailsDB = await Hive.openBox(medicationsBoxName);
  }

  void addActivePrescriptionsDetails(ActivePrescriptionDetailModel value) {
    activePrescriptionsDetailsDB.put(value.id, value);
  }

  ActivePrescriptionDetailModel? getActivePrescriptionDetailModel(String id) {
    return activePrescriptionsDetailsDB.get(id);
  }
}
