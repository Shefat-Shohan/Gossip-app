import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gossip_app/chat_screen.dart';
import 'constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'already_have_an_account.dart';
import 'login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _obscureText = true;
  bool showSpinner = false;
  String _emailAddress = '';
  String _password = '';
  String _userName = '';
  var newUser;
  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _userNameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() async {
    setState(() {
      showSpinner = true;
    });
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      try {
        newUser = await _auth.createUserWithEmailAndPassword(
            email: _emailAddress.toLowerCase().trim(),
            password: _password.trim());
        // TODO collect username to database using flutter map
        if (newUser != null) {
          Navigator.pushNamed(context, ChatScreen.id);
          setState(() {
            showSpinner = false;
          });
        }
      } catch (error) {
        print('error occurred ${error.message}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          ModalProgressHUD(
            inAsyncCall: showSpinner,
            color: kPrimaryColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(26, 50, 26, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text('Register'),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SvgPicture.asset(
                      'assets/icons/signup.svg',
                      height: size.height * 0.35,
                    ),
                    SizedBox(height: 15),
                    Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            //email field starts here
                            TextFormField(
                              key: ValueKey('email'),
                              validator: (value) {
                                if (value.isEmpty || !value.contains('@')) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _emailAddress = value;
                              },
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_emailFocusNode),
                              keyboardType: TextInputType.emailAddress,

                              // Decoration start here
                              decoration: InputDecoration(
                                focusColor: kPrimaryLightColor,
                                filled: true,
                                prefixIcon: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 20, end: 15),
                                  child: Icon(
                                    Icons.email,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                fillColor: kPrimaryLightColor,
                                labelText: 'Enter your email.',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(32.0),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: kPrimaryColor, width: 1.0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(32.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: kPrimaryColor, width: 2.0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(32.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            // username starts here
                            TextFormField(
                              key: ValueKey('username'),
                              validator: (value) {
                                if (value.isEmpty || value.length < 4) {
                                  return 'Please enter at least 4 character';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _userName = value;
                              },
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_userNameFocusNode),

                              // Decoration start here
                              decoration: InputDecoration(
                                focusColor: kPrimaryLightColor,
                                filled: true,
                                prefixIcon: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 20, end: 15),
                                  child: Icon(
                                    Icons.person,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                fillColor: kPrimaryLightColor,
                                labelText: 'Enter your username.',
                                hoverColor: kPrimaryColor,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(32.0),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: kPrimaryColor, width: 1.0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(32.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: kPrimaryColor, width: 2.0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(32.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              key: ValueKey('password'),
                              validator: (value) {
                                if (value.isEmpty || value.length < 7) {
                                  return 'Please enter a valid Password';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              focusNode: _passwordFocusNode,
                              decoration: InputDecoration(
                                  focusColor: kPrimaryLightColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(32.0),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: kPrimaryColor, width: 1.0),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(32.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: kPrimaryColor, width: 2.0),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(32.0),
                                    ),
                                  ),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 20, end: 15),
                                    child: Icon(
                                      Icons.lock,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    child: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  labelText: 'Enter your password',
                                  fillColor: kPrimaryLightColor),
                              onSaved: (value) {
                                _password = value;
                              },
                              obscureText: _obscureText,
                              onEditingComplete: _submitForm,
                            ),
                            SizedBox(height: 10),
                            //Login button starts here
                            Material(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                              elevation: 5.0,
                              child: MaterialButton(
                                onPressed: _submitForm,
                                height: 60.0,
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            AlreadyHaveAnAccountCheck(
                              login: false,
                              press: () {
                                Navigator.pushNamed(context, LoginScreen.id);
                              },
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
