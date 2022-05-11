import 'package:flutter/material.dart';
import 'package:my_med/src/l10n/localization_provider.dart';

class CustomAppbar {
  AppBar buildSearchBar(
    void Function() onSearchTap,
    bool isSearchSelect,
    TextEditingController searchValue,
    void Function(String? value) onSearchChanged,
    BuildContext context,
  ) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: onSearchTap,
        icon: (isSearchSelect)
            ? const Icon(
                Icons.close,
                color: Color(0xFF909090),
              )
            : const Icon(
                Icons.search,
                color: Color(0xFF909090),
              ),
      ),
      actions: (isSearchSelect)
          ? [buildSearchTextField(searchValue, onSearchChanged, context)]
          : [
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.asset(
                        "assets/launcher_icon_blue_red.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                    Text(
                      "My Med",
                      style: TextStyle(
                        color: Colors.blue.shade300,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
    );
  }

  AppBar buildProfileAppBar({
    required BuildContext context,
    required void Function() onNotificationTap,
    required void Function() onSettingTap,
  }) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.notifications),
        onPressed: onNotificationTap,
      ),
      title: Text(context.localizations.profile),
      centerTitle: true,
      actions: [
        IconButton(onPressed: onSettingTap, icon: const Icon(Icons.settings))
      ],
    );
  }

  SizedBox buildSearchTextField(
    TextEditingController searchValue,
    void Function(String? value) onSearchChanged,
    BuildContext context,
  ) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          onChanged: onSearchChanged,
          controller: searchValue,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            suffixIcon: const Icon(
              Icons.search,
              color: Color(0xFF909090),
            ),
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF5EAFC0), width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            hintTextDirection: TextDirection.rtl,
            hintText: context.localizations.searchDrugText,
            hintStyle: const TextStyle(
              fontWeight: FontWeight.w300,
              color: Color(0xFF909090),
            ),
          ),
        ),
      ),
      height: 100,
      width: 300,
    );
  }
}
