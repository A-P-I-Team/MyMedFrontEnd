import 'package:flutter/cupertino.dart';
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

  void getDoctors() {
    //TODO API Call (Get Doctors)
    doctorsList = [
      DoctorModel(
        id: '#',
        name: 'Danial Bazmande',
        profession: 'ENT Doctor',
      ),
      DoctorModel(
        id: '#',
        name: 'Mohammad Yarmoghadam',
        profession: 'Surgery Expert',
      ),
      DoctorModel(
        id: '#',
        name: 'AmirMahdi Shadman',
        profession: 'Surgery Expert',
      ),
      DoctorModel(
        id: '#',
        name: 'Alireza Haghani',
        profession: 'Physician',
      ),
      DoctorModel(
        id: '#',
        name: 'Ali Mostofi',
        profession: 'ENT Doctor',
      ),
      DoctorModel(
        id: '#',
        name: 'Arash Taherian Khode Asl',
        profession: 'Hair and Care',
      ),
    ];
    doctorListFiltered.addAll(doctorsList
        .where((element) => (element.name.contains(searchBarController.text))));
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
        .where((element) => (element.name.contains(searchBarController.text)))
        .toList();
    notifyListeners();
  }

  void updateList() {
    doctorListFiltered = doctorsList
        .where((element) => (element.name.contains(searchBarController.text)))
        .toList();
  }

  @override
  void dispose() {
    searchBarController.dispose();
    super.dispose();
  }
}
