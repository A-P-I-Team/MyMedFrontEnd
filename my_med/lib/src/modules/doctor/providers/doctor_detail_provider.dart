import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_med/src/modules/doctor/apis/doctor_apis.dart';
import 'package:my_med/src/modules/doctor/models/doctor_detail_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorsDetailsProvider extends ChangeNotifier {
  BuildContext context;
  late GoogleMapController controller;
  DoctorDetailModel? doctor;
  bool isLoading = true;
  bool isDisposed = false;

  DoctorsDetailsProvider(this.context, String id) {
    isLoading = true;
    notifyListeners();
    DoctorAPIs().getDoctorDetails(id: id).then((value) {
      if (value != null) {
        doctor = value;
        doctorAddress = doctor!.address;
        doctorPhoneNumbers = doctor!.phone;
        if (isDisposed) return;
        isLoading = false;
        notifyListeners();
      }
    });
  }

  CameraPosition get initialCameraPosition {
    return CameraPosition(
      zoom: 12,
      target: LatLng(doctor!.latitude, doctor!.longitude),
    );
  }

  String doctorAddress = "آدرسی درج نشده است.";

  String doctorPhoneNumbers = "شماره تلفنی درج نشده است.";

  String getTextForShare() {
    return "$doctorAddress\n$doctorPhoneNumbers";
  }

  void navigate() async {
    final lat = initialCameraPosition.target.latitude;
    final lng = initialCameraPosition.target.longitude;
    final uri = "https://www.google.com/maps/dir/?api=1&destination=$lat,$lng";
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      debugPrint('Could not launch ${uri.toString()}');
      // }
    }

    void onLastPrescriptionTap() {}

    void onPrescriptionTap(String doctorID) {
      notifyListeners();
    }

    void onDrugsTap(String doctorID) {
      // context.router.push(DoctorDrugsRoute(doctorID: doctorID));
      notifyListeners();
    }
  }

  onPrescriptionTap(int id) {}

  onDrugsTap(int id) {}

  void onLastPrescriptionTap() {}

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
