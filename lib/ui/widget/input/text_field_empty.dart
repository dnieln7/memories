import 'package:flutter/material.dart';

class TextFieldEmpty extends StatelessWidget {
  TextFieldEmpty({
    @required this.hint,
    this.value,
    @required this.theme,
    this.inputAction,
    this.saveListener,
    this.changeListener,
    this.validator,
  });

  final String hint;
  final String value;
  final TextInputAction inputAction;
  final Color theme;
  final Function saveListener;
  final Function changeListener;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: hint,
        alignLabelWithHint: true,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: theme),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: theme),
        ),
      ),
      initialValue: value != null ? value : '',
      textInputAction: inputAction != null ? inputAction : TextInputAction.next,
      keyboardType: TextInputType.text,
      cursorColor: theme,
      style: TextStyle(fontSize: 16, color: Colors.black),
      onSaved: saveListener != null ? (text) => saveListener(text) : null,
      onChanged: changeListener != null ? (text) => changeListener(text) : null,
      validator: validator != null ? (text) => validator(text) : null,
    );
  }
}
