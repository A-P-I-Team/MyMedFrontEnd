import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/profile/components/setting_card.dart';
import 'package:my_med/src/modules/setting/providers/setting_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingProvider(context),
      child: const _SettingPage(),
    );
  }
}

class _SettingPage extends StatelessWidget {
  const _SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SettingProvider>();
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Container(
            height: 2,
            color: Colors.black12,
          ),
          SettingCard(
            cardText: context.localizations.language,
            leadingWidget: getLeadingIcon(
                leadingText: context.localizations.settingPageSelectedLanguage),
            enableShadow: false,
            onTap: provider.onLanguageTap,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 29),
            child: Container(
              height: 1,
              color: Colors.black12,
            ),
          ),
          SettingCard(
            cardText: context.localizations.announcement,
            leadingWidget: getLeadingIcon(),
            enableShadow: false,
            onTap: provider.onNotificationTap,
          ),
          Container(
            height: 2,
            color: Colors.black12,
          ),
          const SizedBox(
            height: 24,
          ),
          SettingCard(
            cardText: context.localizations.aboutUs,
            leadingWidget: getLeadingIcon(),
            onTap: provider.onAboutUsTap,
          ),
          const SizedBox(
            height: 24,
          ),
          SettingCard(
            enableActionWidget: true,
            cardText: context.localizations.logout,
            actionWidget: SizedBox(
              child: RotatedBox(
                quarterTurns:
                    (Directionality.of(context) == TextDirection.ltr) ? 2 : 0,
                child: SvgPicture.asset(
                  "assets/combined_shape.svg",
                  fit: BoxFit.fill,
                  height: 20,
                  width: 20,
                  color: const Color(0xFFF07171),
                ),
              ),
            ),
            onTap: provider.showExitPopUp,
          ),
        ],
      ),
    );
  }

  TextStyle getSettingTextStyle({Color textColor = Colors.black}) {
    return TextStyle(
      color: textColor,
      fontWeight: FontWeight.w700,
      fontSize: 12,
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        context.localizations.setting,
        style:
            const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
      ),
      centerTitle: true,
    );
  }

  Widget getLeadingIcon({String leadingText = ''}) {
    return (leadingText.isEmpty)
        ? const Icon(
            Icons.arrow_forward_ios,
            size: 12,
          )
        : Row(
            children: [
              Text(leadingText),
              const SizedBox(width: 16),
              const Icon(
                Icons.arrow_forward_ios,
                size: 12,
              ),
            ],
          );
  }
}
