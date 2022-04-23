import 'package:flutter/material.dart';
import 'package:my_med/src/components/custom_app_bar.dart';
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
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const Expanded(
              child: AvatarColumn(
                fullName: 'John Smith',
                identification: '0032023045',
              ),
              flex: 1,
            ),
            Expanded(
              child: InformationContainer(
                patient: provider.patient!,
                showEditNamePopUp: provider.showEditNamePopUp,
                showEditBirthdayPopUp: provider.showEditBirthdayPopUp,
                showEditSexualityPopUp: provider.showEditSexualityPopUp,
              ),
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
