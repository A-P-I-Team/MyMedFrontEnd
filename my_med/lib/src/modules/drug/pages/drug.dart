import 'package:flutter/material.dart';
import 'package:my_med/src/components/custom_app_bar.dart';
import 'package:my_med/src/components/drug_box.dart';
import 'package:my_med/src/modules/drug/providers/drug_provider.dart';
import 'package:provider/provider.dart';

class DrugPage extends StatelessWidget {
  const DrugPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DrugProvider(context),
      child: const _DrugPage(),
    );
  }
}

class _DrugPage extends StatelessWidget {
  const _DrugPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DrugProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppbar().buildSearchBar(
        provider.onSearchTap,
        provider.isSearchSelect,
        provider.searchBarController,
        provider.onSearchChanged,
        context,
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: provider.drugModel.length,
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          itemBuilder: (context, index) {
            return (provider.drugModel[index].medicine
                    .toLowerCase()
                    .contains(provider.searchBarController.text))
                ? DrugBox(
                    drug: provider.drugModel[index],
                    onTap: provider.onDrugTap,
                  )
                : const SizedBox();
          },
        ),
      ),
    );
  }
}
