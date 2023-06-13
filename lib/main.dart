import 'package:firebase_a_to_z/register%20page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Show Entreis.dart';
import 'firebase_options.dart';
import 'login page.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    OutlineInputBorder borderStyle = OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.tealAccent, width: 2));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: OpenUpwardsPageTransitionsBuilder(),
        }),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Colors.teal, width: 2),
                backgroundColor: Colors.white)),
        inputDecorationTheme: InputDecorationTheme(
          errorBorder: borderStyle,
          focusedBorder: borderStyle,
          enabledBorder: borderStyle,
        ),
        useMaterial3: true,
      ),
      initialRoute: "register",
      routes: {
        "register": (context) => RegisterPage(),
        "login": (context) => LoginPage(),
        "showData": (context) => const ShowEntries(),
      },
    );
  }
}
