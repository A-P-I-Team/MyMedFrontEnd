import 'package:flutter/material.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/doctor/components/background_image_container.dart';
import 'package:my_med/src/modules/doctor/components/box_container.dart';
import 'package:my_med/src/modules/doctor/components/circular_experience_and_personality.dart';
import 'package:my_med/src/modules/doctor/components/mini_map.dart';
import 'package:my_med/src/modules/doctor/components/next_to_map.dart';
import 'package:my_med/src/modules/doctor/providers/doctor_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class DoctorsDetailsPage extends StatelessWidget {
  final String id;
  const DoctorsDetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DoctorsDetailsProvider(context, id),
      child: const _DoctorsDetailsPage(),
    );
  }
}

class _DoctorsDetailsPage extends StatelessWidget {
  const _DoctorsDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DoctorsDetailsProvider>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              final text = provider.getTextForShare();
              Share.share(text, subject: "Doctor details");
            },
            icon: const Icon(
              Icons.share,
              color: Color(0xFF909090),
            ),
          ),
        ],
      ),
      body: (provider.isLoading)
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 230,
                    child: BackgroundImageContainer(
                        imageURL: provider.doctor!.profilePic),
                  ),
                  Positioned(
                    top: 190,
                    left: 16,
                    child: CircularExperienceAndPersonality(
                      image: Image.asset("assets/experience.png"),
                      textSpan: TextSpan(
                        text: '${provider.doctor!.experience} ',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                          color: Color(0xFF5EAFC0),
                        ),
                        children: [
                          TextSpan(
                            text: context.localizations.year,
                          ),
                        ],
                      ),
                      bottomTitle: context.localizations.experience,
                    ),
                  ),
                  Positioned(
                    top: 190,
                    right: 16,
                    child: CircularExperienceAndPersonality(
                      image: Image.asset("assets/personality.png"),
                      textSpan: TextSpan(
                        text: provider.doctor!.msn,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                          color: Color(0xFF5EAFC0),
                        ),
                      ),
                      bottomTitle: context.localizations.medicalSystem,
                    ),
                  ),
                  Positioned(
                    top: 240,
                    right: 8,
                    left: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            '${provider.doctor!.firstName} ${provider.doctor!.lastName}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(0xFF474747),
                            ),
                          ),
                          Text(
                            provider.doctor!.field,
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                              color: Color(0xFF474747),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: BoxContainer(
                                    image: Image.asset("assets/hospital.png"),
                                    title:
                                        context.localizations.lastPrescription,
                                    data: provider.doctor!.prescriptionDate
                                        .toString()
                                        .split(' ')[0]
                                        .replaceAll('-', '/'),
                                    action: "last_prescription",
                                    onTap: provider.onLastPrescriptionTap,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: BoxContainer(
                                    image: Image.asset("assets/noskheha.png"),
                                    title: context.localizations.prescriptions,
                                    data: provider.doctor!.prescriptionsNum
                                        .toString(),
                                    action: "prescriptions",
                                    onTap: () => provider
                                        .onPrescriptionTap(provider.doctor!.id),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: BoxContainer(
                                    image: Image.asset("assets/drugs.png"),
                                    title: context.localizations.drugs,
                                    data: provider.doctor!.medicinesNum
                                        .toString(),
                                    action: "drugs",
                                    onTap: () => provider
                                        .onDrugsTap(provider.doctor!.id),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                context.localizations.aboutDoctor,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: Color(0xFF474747),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 100,
                              child: Scrollbar(
                                thumbVisibility: true,
                                radius: const Radius.circular(8),
                                child: ListView(
                                  physics: const BouncingScrollPhysics(),
                                  padding: const EdgeInsets.all(0),
                                  children: [
                                    Text(
                                      provider.doctor!.about,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Color(0xFF737373),
                                      ),
                                      textAlign: TextAlign.justify,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                context.localizations.hoursOfWork,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: Color(0xFF474747),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  provider.doctor!.hoursOfWork,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Color(0xFF474747),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                context.localizations.clinicInformation,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: Color(0xFF474747),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              MiniMap(
                                provider: provider,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    NextToMap(
                                      image: Image.asset("assets/location.png"),
                                      text: provider.doctorAddress,
                                    ),
                                    NextToMap(
                                      image: Image.asset("assets/call.png"),
                                      text: provider.doctorPhoneNumbers,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
