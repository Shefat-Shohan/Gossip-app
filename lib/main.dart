import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gossip_app/auth_form.dart';
import '../welcome_screen.dart';
import 'login_screen.dart';
import '../registration_screen.dart';
import '../chat_screen.dart';
import 'background.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Gossip());
}

class Gossip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //   primaryColor: kPrimaryColor,
      //   backgroundColor: kPrimaryColor,
      //   accentColor: kPrimaryLightColor,
      //   accentColorBrightness: Brightness.dark,
      //   buttonTheme: ButtonTheme.of(context).copyWith(
      //     buttonColor: kPrimaryColor,
      //     textTheme: ButtonTextTheme.primary,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(20),
      //     ),
      //   ),
      // ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
      home: WelcomeScreen(),
    );
  }
}
