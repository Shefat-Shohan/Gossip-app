// import 'dart:html';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'auth_form.dart';
//
// class AuthScreen extends StatefulWidget {
//   @override
//   _AuthScreenState createState() => _AuthScreenState();
// }
//
// class _AuthScreenState extends State<AuthScreen> {
//   final _auth = FirebaseAuth.instance;
//   void _submitAuthForm(
//       String email, String username, String password, bool isLogin) async {
//     // A authResult;
//
//     try {
//       if (isLogin) {
//         await _auth.signInWithEmailAndPassword(
//             email: email, password: password);
//       } else {
//         await _auth.createUserWithEmailAndPassword(
//             email: email, password: password);
//       }
//     } on PlatformException catch (err) {
//       var message = 'An error occurred, Please check your credentials';
//       if (err.message != null) {
//         message = err.message;
//       }
//       Scaffold.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Message'),
//           backgroundColor: Theme.of(context).errorColor,
//         ),
//       );
//     } catch (err) {
//       print(err);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).primaryColor,
//       body: AuthForm(),
//     );
//   }
// }
