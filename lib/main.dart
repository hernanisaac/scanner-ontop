import 'package:flutter/material.dart';
import 'package:ontop_scanner/screens/qr_reader_screen.dart';
import 'package:ontop_scanner/services/storage.dart';

import 'screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final accessToken = await getAccessToken();
  runApp(MyApp(accessToken: accessToken));
}

class MyApp extends StatelessWidget {
  final String? accessToken;

  const MyApp({Key? key, required this.accessToken}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi App Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: accessToken != null
          ? QrReaderScreen()
          : LoginScreen(), // Choose screen based on token
    );
  }
}
