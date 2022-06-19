import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_med/src/modules/profile/providers/profile_provider.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late ProfileProvider sut;
  final MockBuildContext context = MockBuildContext();
  setUp(() {
    sut = ProfileProvider(context);
  });

  test(
    'Profile Page Initializing Test',
    () {
      expect(sut.hasError, false);
      expect(sut.userProfileModel, null);
      expect(sut.isCompleteBirthDay, false);
      expect(sut.isloading, false);
      expect(sut.isDisposed, false);
      expect(sut.sexuality, Sexuality.man);
    },
  );

  test(
    'Profile Page [onSexualityChange] Test',
    () {
      // setup
      const sex = Sexuality.other;
      // run
      sut.onSexualityChange(sex);
      // verify (result)
      expect(sut.sexuality, sex);
    },
  );

  test(
    'Profile Page [onYearChange] Test',
    () {
      // setup
      const year = '1379';
      // run
      sut.onYearChange(year);
      // verify (result)
      expect(sut.year, year);
    },
  );

  test(
    'Profile Page [onMonthChange] Test',
    () {
      // setup
      const month = '12';
      // run
      sut.onMonthChange(month);
      // verify (result)
      expect(sut.month, month);
    },
  );

  test(
    'Profile Page [onDayChange] Test',
    () {
      // setup
      const day = '12';
      // run
      sut.onDayChange(day);
      // verify (result)
      expect(sut.day, day);
    },
  );

  test(
    'Profile Page [dateValidators] Test',
    () {
      // setup
      String day = '.';
      String month = '13';
      String year = '12345';
      // run
      // verify (result)
      expect(sut.dayValidator(day), null);
      expect(sut.monthValidator(month), '');
      expect(sut.yearValidator(year), '');

      //=================================
      day = '31';
      month = '5';
      sut.onMonthChange(month);
      expect(sut.dayValidator(day), null);
      //=================================
      day = '31';
      month = '7';
      sut.onMonthChange(month);
      expect(sut.dayValidator(day), '');
      //=================================
      day = '30';
      month = '12';
      sut.onMonthChange(month);
      expect(sut.dayValidator(day), '');
    },
  );

  test(
    'Profile Page [birthdayValidator] Test',
    () {
      // setup
      const day = '1';
      const month = '13';
      const year = '1345';
      // run
      sut.onYearChange(year);
      sut.onMonthChange(month);
      sut.onDayChange(day);
      sut.checkValidBirthDay();
      // verify (result)
      expect(sut.isCompleteBirthDay, false);
    },
  );

  test(
    'Profile Page [dispose] Test',
    () {
      // setup
      // run
      sut.dispose();
      // verify (result)
      expect(sut.isDisposed, true);
    },
  );
}
