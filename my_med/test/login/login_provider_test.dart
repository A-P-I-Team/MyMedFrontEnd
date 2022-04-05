import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_med/src/components/utils/shared_preferences.dart';
import 'package:my_med/src/modules/intro/providers/login_provider.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late LoginProvider loginProvider;
  final MockBuildContext _context = MockBuildContext();
  setUp(() {
    loginProvider = LoginProvider(_context);
  });

  test('Login Page Initializing Test', () async {
    // setup

    // run

    // verify (result)
    expect(loginProvider.isLoading, false);
  });

  test('Login Failure (No Email) Test', () {
    // setup
    loginProvider.emailController.text = '';
    loginProvider.passwordController.text = 'Ab654321';

    // run
    loginProvider.isTextFieldsValid('temp');

    // verify (result)
    expect(loginProvider.isButtonEnabled, false);
  });

  test('Login Failure (No Password) Test', () {
    // setup
    loginProvider.emailController.text = 'user@example.com';
    loginProvider.passwordController.text = '';

    // run
    loginProvider.isTextFieldsValid('temp');

    // verify (result)
    expect(loginProvider.isButtonEnabled, false);
  });

  test('Login Failure (No Email and Password) Test', () {
    // setup
    loginProvider.emailController.text = '';
    loginProvider.passwordController.text = '';

    // run
    loginProvider.isTextFieldsValid('temp');

    // verify (result)
    expect(loginProvider.isButtonEnabled, false);
  });

  test('Login Button Enabling Status Test', () {
    // setup
    loginProvider.emailController.text = 'user@example.com';
    loginProvider.passwordController.text = 'Ab654321';

    // run
    loginProvider.isTextFieldsValid('temp');

    // verify (result)
    expect(loginProvider.isButtonEnabled, true);
  });

  test('Login Button Pressing Test', () async {
    WidgetsFlutterBinding.ensureInitialized();
    await PreferencesService.initialize();

    // setup
    loginProvider.emailController.text = 'iliya.mi78@gmail.com';
    loginProvider.passwordController.text = 'Ab654321';
    // run
    loginProvider.isTextFieldsValid('temp');
    await loginProvider.login();
    loginProvider.isLoading;

    // verify (result)
    expect(loginProvider.isLoading, false);
  });
}
