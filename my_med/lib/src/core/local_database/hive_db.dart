import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_med/src/modules/home/dbs/prescriptions_db.dart';
import 'package:my_med/src/modules/home/models/active_prescription_detail_model.dart';

class HiveDB {
  Future<void> initAppDBs() async {
    await PrescriptionDB.instance.initializeActivePrescriptionsDetailsDB();
  }

  void registerHiveAdapters() {
    Hive.registerAdapter(DoctorAdapter());
    Hive.registerAdapter(ActivePrescriptionDetailModelAdapter());
  }
}
