import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'constants.dart';
import '../text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    void _trySubmit() {
      final isValid = _formKey.currentState.validate();

      if (isValid) {
        _formKey.currentState.save();
      }
    }

    return TextFieldContainer(
      key: _formKey,
      child: TextFormField(
        key: _formKey,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value.isEmpty || !value.contains('@')) {
            return 'invalid email';
          }
          return null;
        },
        onSaved: (value) {},
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

// return TextFieldContainer(
// key: _formKey,
// child: TextField(
// key: _formKey,
// keyboardType: TextInputType.emailAddress,
// onChanged: onChanged,
// cursorColor: kPrimaryColor,
// decoration: InputDecoration(
// icon: Icon(
// icon,
// color: kPrimaryColor,
// ),
// hintText: hintText,
// border: InputBorder.none,
// ),
// ),
// );
// }
// }
