import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/pages/list_page.dart';
import 'package:qrreader/provider/scan_list_provider.dart';
import 'package:qrreader/provider/ui_provider.dart';
import 'package:qrreader/widgets/bottom_navbar.dart';
import 'package:qrreader/widgets/floating_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final db = Provider.of<ScanListProvider>(context, listen: false);

    bool val = true;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("dummie QR code scanner",
            style: TextStyle(fontSize: 15)),
        actions: [
          IconButton(
              onPressed: () {
                db.deleteAll();
              },
              icon: const Icon(Icons.delete_sweep_rounded))
        ],
      ),
      body: pageList[uiProvider.pageIndex],
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const CustomFabButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}

final List<Widget> pageList = [
  const CustomListPage(type: "http"),
  const CustomListPage(type: "geo"),
  const CustomListPage(type: "anything"),
];
