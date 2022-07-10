import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/components/custom_shadow.dart';
import 'package:my_med/src/core/routing/router.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/drug/models/drug_detail_model.dart';
import 'package:auto_route/auto_route.dart';

class BuildDoctorDetailsContainer extends StatelessWidget {
  final DrugDetailModel prescriptionModel;

  const BuildDoctorDetailsContainer({
    Key? key,
    required this.prescriptionModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final doctor = prescriptionModel.doctor;
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: CustomShadow().buildBoxShadow(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            getDoctorAvatar(),
            const SizedBox(width: 8),
            getDoctorName(doctor),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                child: Text(
                  context.localizations.seeDetails,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Color(0xFF5EAFC0),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () => context.router.push(
                DoctorsDetailsRoute(
                  id: doctor.id.toString(),
                ),
              ),
              color: const Color(0xFFBABBBC),
              icon: const Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }

  Expanded getDoctorName(Doctor doctor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: FittedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${doctor.firstName} ${doctor.lastName}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(0xFF474747),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  doctor.field,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: Color(0xFF474747),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  StatelessWidget getDoctorAvatar() {
    return (prescriptionModel.doctor.profilePic == null)
        ? Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: Image.asset(
                  "assets/doctor.png",
                ).image,
                fit: BoxFit.cover,
              ),
            ),
          )
        : CachedNetworkImage(
            imageUrl: prescriptionModel.doctor.profilePic!,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            width: 64,
            height: 64,
            errorWidget: (context, url, error) =>
                Image.asset("assets/rectangle_15.png"),
          );
  }
}
