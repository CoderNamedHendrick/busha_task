import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BushaTextFormField extends StatelessWidget {
  const BushaTextFormField({
    super.key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.title,
    this.titleStyle,
    this.style,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.readOnly = false,
    this.obscureText = false,
    this.enabled = true,
    this.inputFormatters,
    this.autofillHints,
    this.onEditingComplete,
    this.onTap,
    this.prefix,
    this.prefixConstraints,
    this.suffixIcon,
    this.suffix,
    this.suffixConstraints,
    this.maxLines = 1,
    this.maxLength,
    this.hintText,
    this.hintStyle,
    EdgeInsets? contentPadding,
    this.backgroundColor,
    this.borderSide,
    this.focusedBorderSide,
    this.borderRadius,
    this.prefixIconColor,
    this.suffixIconColor,
    this.errorText,
    this.textAlignment,
    this.showCursor = true,
    this.cursorColor,
    this.prefixWidget,
    this.cursorHeight,
    this.autovalidateMode,
    this.maxLengthEnforcement,
  }) : _contentPadding = contentPadding;

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final bool obscureText;
  final bool enabled;

  final String? title;
  final TextStyle? titleStyle;
  final TextStyle? style;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onTap;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffixIcon;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final int? maxLines;
  final int? maxLength;

  final EdgeInsets? _contentPadding;
  final String? hintText;
  final TextStyle? hintStyle;
  final Color? backgroundColor;
  final BorderSide? borderSide;
  final BorderSide? focusedBorderSide;
  final BorderRadius? borderRadius;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final String? errorText;
  final TextAlign? textAlignment;
  final bool showCursor;
  final Color? cursorColor;
  final Widget? prefixWidget;
  final List<String>? autofillHints;
  final double? cursorHeight;
  final AutovalidateMode? autovalidateMode;
  final MaxLengthEnforcement? maxLengthEnforcement;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        switch (title) {
          final title? => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(title,
                  style: titleStyle ??
                      Theme.of(context).inputDecorationTheme.labelStyle),
            ),
          _ => const SizedBox.shrink(),
        },
        Flexible(
          child: TextFormField(
            autovalidateMode: autovalidateMode,
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            textCapitalization: textCapitalization,
            textInputAction: textInputAction,
            readOnly: readOnly,
            obscureText: obscureText,
            showCursor: showCursor,
            autofillHints: autofillHints,
            enabled: enabled,
            cursorHeight: cursorHeight,
            cursorColor: cursorColor,
            textAlign: textAlignment ?? TextAlign.start,
            style: style,
            inputFormatters: inputFormatters,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
            maxLines: maxLines,
            maxLength: maxLength,
            maxLengthEnforcement: maxLengthEnforcement,
            validator: validator,
            onTap: onTap,
            onEditingComplete: onEditingComplete,
            decoration: InputDecoration(
              contentPadding: _contentPadding,
              hintText: hintText,
              hintStyle: hintStyle,
              fillColor: backgroundColor,
              suffix: suffixIcon,
              suffixIcon: suffix,
              suffixIconConstraints: suffixConstraints,
              prefixIcon: prefix,
              prefixIconConstraints: prefixConstraints,
              prefix: prefixWidget,
              prefixIconColor: prefixIconColor,
              suffixIconColor: suffixIconColor,
            ),
          ),
        )
      ],
    );
  }
}
