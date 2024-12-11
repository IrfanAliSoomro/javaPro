import 'package:briggsapp/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:briggsapp/themes/my_theme.dart';
import 'package:briggsapp/providers/chat_provider.dart';
import 'package:briggsapp/providers/settings_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'DefaultFirebaseOption.dart';
import 'generic_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initHive();

  await ChatProvider.initHive();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChatProvider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> initHive() async {
  if (kIsWeb) {
    await Hive.initFlutter(Constants.geminiDB);
  } else {
    await Hive.initFlutter();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();

    return MaterialApp(
      title: 'Briggs ChatBot',
      theme: settingsProvider.isDarkMode ? darkTheme : lightTheme,
      debugShowCheckedModeBanner: false,
      home: GenericLogin(),
    );
  }
}
