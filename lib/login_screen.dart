import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gossip_app/registration_screen.dart';
import 'rounded_button.dart';
import 'constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'rounded_button.dart';
import 'already_have_an_account.dart';
import 'rounded_input_field.dart';
import 'rounded_password_field.dart';
import 'already_have_an_account.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 35,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "LOGIN",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 35.0,
              ),
              SvgPicture.asset(
                'assets/icons/login.svg',
                width: 240,
                height: 240,
              ),
              SizedBox(
                height: 35.0,
              ),
              RoundedInputField(
                hintText: 'Your Email',
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                onChanged: (value) {},
              ),
              RoundedButton(
                title: 'LOGIN',
                colour: kPrimaryColor,
                onPressed: () {},
              ),
              SizedBox(
                height: 10,
              ),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
