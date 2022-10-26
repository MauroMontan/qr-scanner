import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/pages/home_page.dart';
import 'package:qrreader/pages/map_page.dart';
import 'package:qrreader/provider/scan_list_provider.dart';
import 'package:qrreader/provider/ui_provider.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UiProvider()),
        ChangeNotifierProvider(create: (context) => ScanListProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Qr scanner',
      initialRoute: "home",
      routes: {
        "home": (_) => const HomePage(),
        "map": (_) => const MapPage(),
      },
    );
  }
}
