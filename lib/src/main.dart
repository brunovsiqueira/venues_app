import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venues_app/src/pages/home_page.dart';

Future<void> main() async {
  await dotenv.load(
      fileName:
          "lib/config/env/.${const String.fromEnvironment('env', defaultValue: 'prod')}.env");
  runApp(const ProviderScope(child: VenuesApp()));
}

class VenuesApp extends StatelessWidget {
  const VenuesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wolt Venues',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(87, 191, 228, 0.0)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
