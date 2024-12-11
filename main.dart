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






























// import 'package:briggsapp/constants/constants.dart';
// import 'package:briggsapp/widgets/web/login_screen.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:briggsapp/home_screen.dart';
// import 'package:briggsapp/themes/my_theme.dart';
// import 'package:briggsapp/providers/chat_provider.dart';
// import 'package:briggsapp/providers/settings_provider.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:provider/provider.dart';

// import 'DefaultFirebaseOption.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   Initialize Firebase
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   initHive();
//   // Initialize Hive in ChatProvider
//   await ChatProvider.initHive();

//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => ChatProvider()),
//         ChangeNotifierProvider(create: (context) => SettingsProvider()),
//       ],
//       child: const MyApp(),
//     ),
//     // MyApp(),
//   );
// }

// Future<void> initHive() async {
//   if (kIsWeb) {
//     await Hive.initFlutter(Constants.geminiDB);
//     // Use web-specific initialization for Hive (or SharedPreferences)
//     // await Hive.initFlutter(); // Initialize Hive for Web
//   } else {
//     // Initialize Hive for mobile (Android/iOS)
//     await Hive
//         .initFlutter(); // Same initialization for mobile (also works for desktop)
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final settingsProvider = context.watch<SettingsProvider>();

//     return MaterialApp(
//       title: 'Flutter Chat Bot App',
//       theme: settingsProvider.isDarkMode ? darkTheme : lightTheme,
//       debugShowCheckedModeBanner: false,
//       home: LoginScreen(), // Choose the desired home screen here
//     );
//   }
// }
