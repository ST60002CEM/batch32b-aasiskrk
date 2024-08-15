import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playforge/app/app.dart';

import 'core/networking/local/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await HiveService().init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(27, 27, 27, 1),
      // Color.fromRGBO(38, 45, 52, 1), // Match this with your AppBar color
      statusBarIconBrightness: Brightness.dark,
      // Light icons on dark background
    ),
  );

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
