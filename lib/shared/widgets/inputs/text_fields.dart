import 'text_field.dart';
import 'package:flutter/material.dart';

class EmailTextFormField extends BushaTextFormField {
  const EmailTextFormField({
    super.key,
    super.title = 'Email Address',
    super.hintText = 'johndoe@abce.com',
    super.hintStyle,
    super.validator,
    super.onChanged,
    super.onFieldSubmitted,
    super.controller,
    super.focusNode,
    super.textInputAction,
    super.readOnly = false,
    autocorrect = false,
    autofillHints = const [
      AutofillHints.email,
      AutofillHints.newUsername,
      AutofillHints.username,
    ],
    super.keyboardType = TextInputType.emailAddress,
  });
}

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    super.key,
    this.title,
    this.hintText,
    this.hintStyle,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.controller,
    this.focusNode,
    this.textInputAction,
    this.readOnly = false,
  });

  final String? title;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool readOnly;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BushaTextFormField(
      title: widget.title ?? 'Password',
      hintText: widget.hintText ?? 'Enter your password',
      hintStyle: widget.hintStyle,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      controller: widget.controller,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      readOnly: widget.readOnly,
      obscureText: obscurePassword,
      keyboardType: TextInputType.visiblePassword,
      suffixConstraints: BoxConstraints(maxWidth: 80),
      autocorrect: false,
      autofillHints: [AutofillHints.password, AutofillHints.newPassword],
      suffix: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        onTap: _togglePasswordVisibility,
        child: DefaultTextStyle(
          style: Theme.of(context)
              .inputDecorationTheme
              .labelStyle!
              .copyWith(fontSize: 12),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: switch (obscurePassword) {
              true => Text('SHOW'),
              false => Text('HIDE'),
            },
          ),
        ),
      ),
    );
  }
}
