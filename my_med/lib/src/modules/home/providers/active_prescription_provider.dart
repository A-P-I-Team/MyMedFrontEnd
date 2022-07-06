import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/modules/home/apis/Pharmaceutical_api.dart';
import 'package:my_med/src/modules/home/models/active_prescription_model.dart';

class ActivePrescriptionProvider extends ChangeNotifier {
  final BuildContext context;
  late String? selectedId;
  List<ActivePrescriptionModel> activePrescriptionList = [];
  TextEditingController searchBarController = TextEditingController();
  bool isDisposed = false;

  ActivePrescriptionProvider({required this.context}) {
    getActivePrescriptionList();
  }

  void onSearchedValueChanged(String? newValue) {
    notifyListeners();
  }

  Future<void> getActivePrescriptionList() async {
    await Pharmaceutical().getActivePrescription().then(
      (value) {
        if (isDisposed) return;
        if (value.isEmpty) {
          activePrescriptionList = [];
        } else {
          activePrescriptionList = value;
          selectedId = activePrescriptionList.first.id;
        }
        notifyListeners();
      },
    );
  }

  Future<void> onReminderAcceptTap() async {
    if (activePrescriptionList.isEmpty) return;
    if (selectedId != null) {
      final activePrescriptionModel = activePrescriptionList
          .firstWhere((element) => element.id == selectedId);
      //TODO navigation to detail page
      // context.router.push();
    }
  }

  int getTotalDayUse(ActivePrescriptionModel model) {
    var consumptionDue = model.consumptionDuration;
    int hourDuration = 0;
    if (consumptionDue.contains(' ')) {
      hourDuration = int.parse(consumptionDue.split(' ')[0]) * 24;
      consumptionDue = consumptionDue.split(' ')[1];
    }
    hourDuration += int.parse(consumptionDue.split(':')[0]);
    final minDuration = int.parse(consumptionDue.split(':')[1]);
    final secDuration = int.parse(consumptionDue.split(':')[2]);
    final totalSecDuration =
        hourDuration * 3600 + minDuration * 60 + secDuration;
    final totalDayUse =
        (model.consumptionTimes * totalSecDuration / 86400).ceil();
    return totalDayUse;
  }

  void checkId(String id) {
    if (selectedId == id) {
      selectedId = null;
    } else {
      selectedId = id;
    }
    notifyListeners();
  }

  bool isSelectedId(String id) {
    return (selectedId == id);
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
