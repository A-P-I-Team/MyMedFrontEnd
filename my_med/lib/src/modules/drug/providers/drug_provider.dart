import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_med/src/core/routing/router.dart';
import 'package:my_med/src/modules/drug/apis/drug_apis.dart';
import 'package:my_med/src/modules/drug/models/drug_model.dart';

class DrugProvider extends ChangeNotifier {
  BuildContext context;
  bool isSearchSelect = false;
  TextEditingController searchBarController = TextEditingController();
  List<DrugModel> drugModel = [];
  bool isDisposed = false;

  DrugProvider(this.context) {
    getDrugs();
  }

  Future<void> getDrugs() async {
    drugModel = await DrugAPIs().getDrugs();
    if (isDisposed) return;
    notifyListeners();
  }

  void onDrugTap(DrugModel drug) {
    //TODO navigate to drug detail page
    context.router.push(DrugDetailsRoute(drugId: drug.id.toString()));
  }

  void onSearchTap() {
    isSearchSelect = !isSearchSelect;
    searchBarController.clear();
    notifyListeners();
  }

  void onSearchChanged(String? value) {
    notifyListeners();
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
