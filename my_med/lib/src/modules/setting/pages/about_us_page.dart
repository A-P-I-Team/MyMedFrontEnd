import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:my_med/src/l10n/localization_provider.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _AboutUsPage();
  }
}

class _AboutUsPage extends StatelessWidget {
  const _AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20,
                top: 80,
              ),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: Image.asset(
                      "assets/launcher_icon_blue_red.png",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    lorem(paragraphs: 10),
                    locale: Locale(context.localizations.localeName),
                    textDirection: TextDirection.ltr,
                    maxLines: 40,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
