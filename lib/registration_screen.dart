import 'package:flutter/cupertino.dart';
import 'package:gossip_app/chat_screen.dart';
import 'package:gossip_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:gossip_app/login_screen.dart';
import 'package:gossip_app/social_icon.dart';
import 'rounded_button.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'rounded_input_field.dart';
import 'rounded_password_field.dart';
import 'already_have_an_account.dart';
import 'or_divider.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Expanded(
                child: Text(
                  "REGISTER",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SvgPicture.asset(
              'assets/icons/signup.svg',
              width: 240,
              height: 240,
            ),
            RoundedInputField(
              hintText: 'Your Email',
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              title: 'REGISTER',
              colour: kPrimaryColor,
              onPressed: () {
                Navigator.pushNamed(context, ChatScreen.id);
              },
            ),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocalIcon(
                  iconSrc: 'assets/icons/facebook.svg',
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: 'assets/icons/twitter.svg',
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: 'assets/icons/google-plus.svg',
                  press: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
