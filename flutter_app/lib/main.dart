import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'core/controllers/global_provider.dart';
import 'core/controllers/providers.dart';
import 'core/models/chat_message.dart';
import 'core/utils/theme.dart';
import 'firebase_options.dart';
import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();
  Hive.registerAdapter(ChatMessageAdapter());
  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalProvider globalProvider = Provider.of<GlobalProvider>(context);
    return MaterialApp.router(
      title: 'TurboVets',
      theme: appTheme(context, globalProvider.isDark),
      routerConfig: router
    );
  }
}