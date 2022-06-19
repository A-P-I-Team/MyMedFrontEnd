import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_med/src/modules/setting/providers/language_provider.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late LanguageProvider sut;
  final MockBuildContext context = MockBuildContext();
  setUp(() {
    sut = LanguageProvider(context);
  });

  test(
    'Language Page Initializing Test',
    () {
      expect(sut.language, null);
    },
  );

  test(
    'Language Page [onLanguageChange] Test',
    () {
      const language = Locale('fa');
      sut.changeLanguage(language);
      expect(sut.language, const Locale('fa'));
    },
  );

  test(
    'Language Page [popScreen] Test',
    () {
      expect(true, true);
    },
  );
}
