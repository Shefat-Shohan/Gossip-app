import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gossip_app/chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'registration_screen.dart';
import 'constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'already_have_an_account.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        newUser = await _auth.signInWithEmailAndPassword(
            email: _emailAddress, password: _password);
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
              padding: const EdgeInsets.fromLTRB(26, 80, 26, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text('Login'),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SvgPicture.asset(
                      'assets/icons/login.svg',
                      height: size.height * 0.35,
                    ),
                    SizedBox(height: 15),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
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
                                .requestFocus(_passwordFocusNode),
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
                          TextFormField(
                            key: ValueKey('Password'),
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
                                'LOGIN',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          AlreadyHaveAnAccountCheck(
                            press: () {
                              Navigator.pushNamed(
                                  context, RegistrationScreen.id);
                            },
                          ),
                        ],
                      ),
                    )
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

//                  decoration: InputDecoration(
//                     prefixIcon: Padding(
//                       padding:
//                           const EdgeInsetsDirectional.only(start: 20, end: 20),
//                       child: Icon(
//                         Icons.lock,
//                         color: kPrimaryColor,
//                       ),
//                     ),
//                     hintText: 'Enter your password.',
//                     contentPadding:
//                         EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(32.0),
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(32.0),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(32.0),
//                       ),
//                     ),
//                   ),
//                 ),

// class LoginScreen extends StatefulWidget {
//   static const String id = 'login_screen';
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String _userEmail = '';
//   String _userName = '';
//   String _userPassword = '';
//   void _trySubmit() {
//     final isValid = _formKey.currentState.validate();
//     FocusScope.of(context).unfocus();
//     if (isValid) {
//       _formKey.currentState.save();
//       print(_userEmail);
//       print(_userName);
//       print(_userPassword);
//
//       // TODO use those value to send our auth request
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: EdgeInsets.all(24),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 Container(
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 40.0),
//                     child: Center(
//                       child: Text(
//                         'LOGIN',
//                         style: TextStyle(
//                             fontSize: 15.0, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 45,
//                 ),
//                 SvgPicture.asset(
//                   'assets/icons/login.svg',
//                   height: size.height * 0.35,
//                 ),
//                 SizedBox(
//                   height: 10.0,
//                 ),
//
//                 // Email form field
//                 TextFormField(
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value.isEmpty || !value.contains('@')) {
//                       return 'Please enter a valid email address';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _userEmail = value;
//                   },
//                   onChanged: (value) {
//                     //Do something with the user input.
//                   },
//                   decoration: InputDecoration(
//                     prefixIcon: Padding(
//                       padding:
//                           const EdgeInsetsDirectional.only(start: 20, end: 15),
//                       child: Icon(
//                         Icons.email,
//                         color: kPrimaryColor,
//                       ),
//                     ),
//                     hintText: 'Enter your email',
//                     contentPadding:
//                         EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//                     focusColor: kPrimaryColor,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(32.0),
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(32.0),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(32.0),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.0,
//                 ),
//
//                 //Password form field
//                 TextFormField(
//                   obscureText: true,
//                   validator: (value) {
//                     if (value.isEmpty || value.length < 7) {
//                       return 'Please enter a valid password.';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _userPassword = value;
//                   },
//                   onChanged: (value) {
//                     //Do something with the user input.
//                   },
//                   decoration: InputDecoration(
//                     prefixIcon: Padding(
//                       padding:
//                           const EdgeInsetsDirectional.only(start: 20, end: 20),
//                       child: Icon(
//                         Icons.lock,
//                         color: kPrimaryColor,
//                       ),
//                     ),
//                     hintText: 'Enter your password.',
//                     contentPadding:
//                         EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(32.0),
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(32.0),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(32.0),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: 20.0),
//                   child: Material(
//                     color: kPrimaryColor,
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(30.0),
//                     ),
//                     elevation: 5.0,
//                     child: MaterialButton(
//                       onPressed: _trySubmit,
//                       height: 60.0,
//                       child: Text(
//                         'LOGIN',
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 AlreadyHaveAnAccountCheck(
//                   press: () {
//                     Navigator.pushNamed(context, RegistrationScreen.id);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
