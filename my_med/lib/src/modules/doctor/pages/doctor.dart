import 'package:flutter/material.dart';
import 'package:my_med/src/modules/doctor/providers/doctor_provider.dart';
import 'package:provider/provider.dart';

class DoctorPage extends StatelessWidget {
  const DoctorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DoctorProvider(),
      child: const _DoctorPage(),
    );
  }
}

class _DoctorPage extends StatelessWidget {
  const _DoctorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
