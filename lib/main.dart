import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playforge/app/app.dart';

import 'core/networking/local/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await HiveService().init();

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
