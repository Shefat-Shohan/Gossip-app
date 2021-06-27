import 'package:flutter/material.dart';
import 'package:gossip_app/background.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'rounded_button.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Gossip',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SvgPicture.asset('assets/icons/chat.svg', height: 100),
          RoundedButton(
              title: 'Login',
              colour: Color(0xff6E3AA7),
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              }),
          RoundedButton(
              title: 'Register',
              colour: Color(0x506E3AA7),
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              }),
        ],
      ),
    );
  }
}
