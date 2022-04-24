import 'package:flutter/material.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/profile/components/setting_card.dart';
import 'package:my_med/src/modules/setting/providers/notification_provider.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotificationProvider(context),
      child: const _NotificationPage(),
    );
  }
}

class _NotificationPage extends StatelessWidget {
  const _NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotificationProvider>();
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        children: [
          const SizedBox(height: 14),
          SettingCard(
            cardText: context.localizations.allNotifications,
            leadingWidget: getSwitchWidget(provider.enableAllNotifications, provider.setAllNotif),
          ),
          SizedBox(
            height: 69,
            child: Padding(
              padding: const EdgeInsets.only(right: 24, bottom: 28, left: 8),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  context.localizations.activeNotificationsForReceivingUpdatesAndAds,
                  style: const TextStyle(color: Color(0xFF909090)),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
          ),
          Container(
            height: 2,
            color: Colors.black12,
          ),
          SettingCard(
            cardText: context.localizations.settingReminders,
            enableShadow: false,
            leadingWidget: getSwitchWidget(provider.enableReminderNotifications, provider.setReminderNotif),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 29),
            height: 1,
            color: Colors.black12,
          ),
          SettingCard(
            cardText: context.localizations.inAppNotifications,
            enableShadow: false,
            leadingWidget: getSwitchWidget(provider.enableInAppNotifications, provider.setInAppNotif),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 29),
            height: 1,
            color: Colors.black12,
          ),
          SettingCard(
            cardText: context.localizations.adsNotification,
            enableShadow: false,
            leadingWidget: getSwitchWidget(provider.enableAdsNotification, provider.setAdsNotif),
          ),
          Container(
            height: 2,
            color: Colors.black12,
          ),
        ],
      ),
    );
  }

  Switch getSwitchWidget(bool switchValue, void Function(bool newValue) onChnagedSwitch) {
    return Switch(
      value: switchValue,
      onChanged: onChnagedSwitch,
      activeColor: const Color(0xFF5AC0A7),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        context.localizations.settingNotifications,
        style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
      ),
      centerTitle: true,
    );
  }
}
