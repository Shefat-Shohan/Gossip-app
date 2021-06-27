import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gossip_app/background.dart';
import 'package:gossip_app/body.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'rounded_button.dart';

class WelcomeScreen extends StatelessWidget {
  final Widget child;
  const WelcomeScreen({this.child});
  static const String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              'GOSSIP',
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
                color: Color(0xff6E3AA7),
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          SvgPicture.asset(
            'assets/icons/chat.svg',
            width: 340,
            height: 340,
          ),
          SizedBox(
            height: 25.0,
          ),
          RoundedButton(
              title: 'LOGIN',
              colour: Color(0xff6E3AA7),
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              }),
          RoundedButton(
              title: 'REGISTER',
              colour: Color(0xffF1E6FF),
              textColor: Colors.black,
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              }),
        ],
      ),
    );
  }
}
