import 'package:flutter/material.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/profile/components/setting_card.dart';
import 'package:my_med/src/modules/setting/providers/language_provider.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LanguageProvider(context),
      child: const _LanguagePage(),
    );
  }
}

class _LanguagePage extends StatelessWidget {
  const _LanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LanguageProvider>();

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
          InkWell(
            onTap: () => provider.changeLanguage(const Locale('fa')),
            child: SettingCard(
              enableShadow: false,
              cardText: context.localizations.settingPagePersian,
              leadingWidget: (provider.language == const Locale('fa'))
                  ? getCheckMarkIcon()
                  : const SizedBox(
                      width: 0,
                      height: 0,
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 29),
            child: Container(
              height: 1,
              color: Colors.black12,
            ),
          ),
          InkWell(
            onTap: () => provider.changeLanguage(const Locale('en')),
            child: SettingCard(
              enableShadow: false,
              cardText: context.localizations.settingPageEnglish,
              leadingWidget: (provider.language == const Locale('en'))
                  ? getCheckMarkIcon()
                  : const SizedBox(
                      width: 0,
                      height: 0,
                    ),
            ),
          ),
          Container(
            height: 2,
            color: Colors.black12,
          ),
        ],
      ),
    );
  }

  Widget getCheckMarkIcon() {
    return const Padding(
      padding: EdgeInsets.only(left: 29),
      child: Icon(
        Icons.check,
        color: Color(0xFF5AC0A7),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        context.localizations.selectLanguage,
        style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
      ),
      centerTitle: true,
    );
  }
}
