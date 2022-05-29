class ConstURLs {
  static const String baseDomain = 'http://mymed.pythonanywhere.com';
  static const String login = '$baseDomain/user/login/';
  static const String forgetPasswordEmail = '$baseDomain/user/send_reset_password_email/';
  static const String forgetPassword = '$baseDomain/user/reset_password/';
  static const String register = '$baseDomain/user/register/';
  static const String sendRegisterEmail =
      '$baseDomain/user/send_register_email/';
  static const String cities = '$baseDomain/user/cities/';

  static const String profile = '$baseDomain/user/profile/';

  static const String doctor = '$baseDomain/medical/my_doctors';

  static const String drug = '$baseDomain/medical/prescription-medicines/';

}
