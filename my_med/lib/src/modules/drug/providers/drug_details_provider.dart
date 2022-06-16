import 'package:flutter/material.dart';
import 'package:my_med/src/modules/drug/apis/drug_apis.dart';
import 'package:my_med/src/modules/drug/models/drug_detail_model.dart';

class DrugDetailsProvider extends ChangeNotifier {
  final String drugId;
  DrugDetailModel? drugDetailModel;
  bool isDisposed = false;

  DrugDetailsProvider({
    required this.drugId,
  }) {
    initialize();
  }

  Future<void> initialize() async {
    drugDetailModel = await DrugAPIs().getDrugDetail(id: drugId);
    if (isDisposed) return;
    notifyListeners();
  }

  int getTotalDayUse(DrugDetailModel model) {
    return model.days;
  }

  Future<void> onStopPrescription(BuildContext context) async {}

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
