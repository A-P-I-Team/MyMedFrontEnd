import 'package:flutter/cupertino.dart';
import 'package:my_med/src/modules/doctor/apis/doctor_apis.dart';
import 'package:my_med/src/modules/doctor/models/doctor_model.dart';

class DoctorProvider extends ChangeNotifier {
  BuildContext context;
  bool isSearchSelect = false;
  TextEditingController searchBarController = TextEditingController();
  List<DoctorModel> doctorsList = [];
  List<DoctorModel> doctorListFiltered = [];

  DoctorProvider(this.context) {
    getDoctors();
  }

  void getDoctors() async {
    doctorsList = await DoctorAPIs().getDoctors();
    doctorListFiltered.addAll(
      doctorsList.where(
        (element) => (('${element.firstName} ${element.lastName}')
            .contains(searchBarController.text)),
      ),
    );
    notifyListeners();
  }

  void onDoctorsDetailsTap(String id) {
    //TODO Navigate to doctor details page
  }

  void onSearchTap() {
    isSearchSelect = !isSearchSelect;
    searchBarController.clear();
    updateList();
    notifyListeners();
  }

  void onSearchChanged(String? value) {
    doctorListFiltered = doctorsList
        .where(
          (element) => (('${element.firstName} ${element.lastName}')
              .contains(searchBarController.text)),
        )
        .toList();
    notifyListeners();
  }

  void updateList() {
    doctorListFiltered = doctorsList
        .where(
          (element) => (('${element.firstName} ${element.lastName}')
              .contains(searchBarController.text)),
        )
        .toList();
  }

  @override
  void dispose() {
    searchBarController.dispose();
    super.dispose();
  }
}
