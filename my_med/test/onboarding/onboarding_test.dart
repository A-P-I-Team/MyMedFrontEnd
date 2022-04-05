import 'package:flutter_test/flutter_test.dart';
import 'package:my_med/src/modules/intro/providers/onboarding_provider.dart';

void main() {
  late OnboardingProvider sut;
  setUp(() {
    sut = OnboardingProvider();
  });

  test('Onboarding Page Change Pictures Test', () {
    sut.onDotClicked(1);
    sut.dispose();

    expect(sut.animateIsDone, false);
  });
}
