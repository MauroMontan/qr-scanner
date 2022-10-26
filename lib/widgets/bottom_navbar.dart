import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/provider/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    return NavigationBar(
        height: 90,
        selectedIndex: uiProvider.pageIndex,
        onDestinationSelected: (index) {
          uiProvider.pageIndex = index;
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.link), label: "Urls"),
          NavigationDestination(
            icon: Icon(Icons.location_pin),
            label: "adress",
          ),
          NavigationDestination(
            icon: Icon(Icons.list_rounded),
            label: "more",
          )
        ]);
  }
}
