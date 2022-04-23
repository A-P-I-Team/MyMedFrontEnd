import 'package:flutter/material.dart';
import 'package:my_med/src/modules/drug/providers/drug_provider.dart';
import 'package:provider/provider.dart';

class DrugPage extends StatelessWidget {
  const DrugPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DrugProvider(),
      child: const _DrugPage(),
    );
  }
}

class _DrugPage extends StatelessWidget {
  const _DrugPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
