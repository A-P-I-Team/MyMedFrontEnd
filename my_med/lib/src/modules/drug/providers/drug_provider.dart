import 'package:flutter/cupertino.dart';
import 'package:my_med/src/modules/doctor/models/doctor_model.dart';
import 'package:my_med/src/modules/drug/models/drug_model.dart';

class DrugProvider extends ChangeNotifier {
  BuildContext context;
  // List<Medication> medications = Data.medications;
  bool isSearchSelect = false;
  TextEditingController searchBarController = TextEditingController();
  List<DrugModel> drugModel = [];
  DrugProvider(this.context) {
    //TODO API Call (Get)
    drugModel = List.generate(
          3,
          (index) => DrugModel(
              id: '#',
              name: 'Acetaminophen',
              dosage: 500.0,
              doctor: DoctorModelMock(
                  id: '#', name: 'Danial Bazmande', profession: 'ENT Doctor'),
              consumptionAmount: '1',
              consumptionStart: DateTime.now().toString(),
              consumptionTimes: 12,
              consumptionDuration: '14',
              description: 'Consume your medicine preciesly at the time.',
              changeRequests: [],
              isActive: true,
              isGreen: false),
        ) +
        List.generate(
          2,
          (index) => DrugModel(
              id: '#',
              name: 'Co-amoxiclav',
              dosage: 500.0,
              doctor: DoctorModelMock(
                  id: '#', name: 'Danial Bazmande', profession: 'ENT Doctor'),
              consumptionAmount: '1',
              consumptionStart:
                  DateTime.now().add(const Duration(days: 1)).toString(),
              consumptionTimes: 12,
              consumptionDuration: '14',
              description: 'Consume your medicine preciesly at the time.',
              changeRequests: [],
              isActive: false,
              isGreen: false),
        );
    ;
  }
  void onDrugTap(DrugModel drug) {
    //TODO navigate to drug detail page
  }
  void onSearchTap() {
    isSearchSelect = !isSearchSelect;
    searchBarController.clear();
    notifyListeners();
  }

  void onSearchChanged(String? value) {
    notifyListeners();
  }
}
