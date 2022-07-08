import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/components/error_template.dart';
import 'package:my_med/src/core/routing/router.dart';
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
    await Pharmaceutical()
        .getActivePrescription(
      onTimeout: () => APIErrorMessage().onTimeout(context),
      onDisconnect: () => APIErrorMessage().onDisconnect(context),
      onAPIError: () => APIErrorMessage().onDisconnect(context),
    )
        .then(
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

  void onReminderAcceptTap() {
    if (activePrescriptionList.isEmpty) return;
    if (selectedId != null) {
      final activePrescriptionModel = activePrescriptionList
          .firstWhere((element) => element.id == selectedId);
      context.router.push(ActivePrescriptionDetailsRoute(
          activePrescriptionModel: activePrescriptionModel));
    }
  }

  int getTotalDayUse(ActivePrescriptionModel model) {
    return model.days;
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
