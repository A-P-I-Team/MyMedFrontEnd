import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/components/custom_app_bar.dart';
import 'package:my_med/src/components/custom_shadow.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/doctor/components/mini_button.dart';
import 'package:my_med/src/modules/doctor/providers/doctor_provider.dart';
import 'package:provider/provider.dart';

class DoctorPage extends StatelessWidget {
  const DoctorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DoctorProvider(context),
      child: const _DoctorPage(),
    );
  }
}

class _DoctorPage extends StatelessWidget {
  const _DoctorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DoctorProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppbar().buildSearchBar(
        provider.onSearchTap,
        provider.isSearchSelect,
        provider.searchBarController,
        provider.onSearchChanged,
        context,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 144 / 184,
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            children:
                List.generate(provider.doctorListFiltered.length, (index) {
              var doctor = provider.doctorListFiltered[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: CustomShadow().buildBoxShadow(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        (doctor.imageURL == null)
                            ? Image.asset("assets/doctor.png")
                            : CachedNetworkImage(
                                imageUrl: doctor.imageURL!,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                imageBuilder: (context, imageProvider) =>
                                    Container(
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
                                    Image.asset("assets/doctor.png"),
                              ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                doctor.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Color(0xFF474747),
                                ),
                                overflow: TextOverflow.clip,
                                maxLines: 3,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                doctor.profession ??
                                    context.localizations.unknown,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 10,
                                  color: Color(0xFF474747),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: MiniButton(
                            title: context.localizations.doctorProfileButton,
                            onTap: () => provider.onDoctorsDetailsTap(
                                provider.doctorListFiltered[index].id),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
