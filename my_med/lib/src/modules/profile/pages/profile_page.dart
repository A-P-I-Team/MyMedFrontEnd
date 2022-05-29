import 'package:flutter/material.dart';
import 'package:my_med/src/components/button.dart';
import 'package:my_med/src/components/custom_app_bar.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/profile/components/avatar_column.dart';
import 'package:my_med/src/modules/profile/components/information_container.dart';
import 'package:my_med/src/modules/profile/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileProvider(context),
      child: const _ProfilePage(),
    );
  }
}

class _ProfilePage extends StatelessWidget {
  const _ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
    if (provider.hasError) {
      return const Center(child: Text('Check your internet connection.'));
    }
    return Scaffold(
      appBar: CustomAppbar().buildProfileAppBar(
        context: context,
        onNotificationTap: provider.onNotificationTap,
        onSettingTap: provider.onSettingTap,
      ),
      body: (provider.isloading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : (provider.userProfileModel == null)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(context.localizations.serverMessage),
                      const SizedBox(height: 8),
                      DefaultButton(
                          onPressed: provider.updatePatient,
                          child: Text(context.localizations.retry)),
                    ],
                  ),
                )
              : Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: AvatarColumn(
                          fullName:
                              '${provider.userProfileModel!.firstName} ${provider.userProfileModel!.lastName}',
                          identification: provider.userProfileModel!.ssn,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: InformationContainer(
                          patient: provider.userProfileModel!,
                          showEditNamePopUp: provider.showEditNamePopUp,
                          showEditBirthdayPopUp: provider.showEditBirthdayPopUp,
                          showEditSexualityPopUp:
                              provider.showEditSexualityPopUp,
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
