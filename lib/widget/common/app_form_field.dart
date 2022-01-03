import 'package:flutter/material.dart';

class AppFormFieldWidget extends StatelessWidget {

  final String? hintText;
  final IconData? prefixIcon;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final Function(String)? onSubmitted;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final bool isExtendedField;
  final String? errorText;
  final int? maxLength;

  const AppFormFieldWidget({this.hintText, this.prefixIcon, this.obscureText = false,
    this.suffixIcon, this.onChanged, this.focusNode, this.controller,
    this.inputType, this.onSubmitted, this.textInputAction, this.validator,
    this.enabled = true, this.isExtendedField = false, this.errorText, this.maxLength, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableSuggestions: false,
      textAlignVertical: TextAlignVertical.center,
      enabled: enabled,
      minLines: isExtendedField ? 2 : 1,
      keyboardType: inputType ?? TextInputType.text,
      textInputAction: textInputAction ?? TextInputAction.done,
      controller: controller,
      onChanged: (value) {
        if(onChanged != null) onChanged!(value);
      },
      onFieldSubmitted: (value) {
        if(onSubmitted != null) onSubmitted!(value);
      },
      validator: (value) {
        if(validator != null) return validator!(value);

        return null;
      },
      obscureText: obscureText ?? false,
      focusNode: focusNode,
      style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400
      ),
      cursorColor: Colors.red,
      decoration: InputDecoration(
        errorText: errorText,
        errorStyle: const TextStyle(
            fontSize: 12,
            color: Colors.red,
            fontWeight: FontWeight.w400
        ),
        hintText: hintText,
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.grey,
          size: 25,
        ),
        suffixIcon: suffixIcon,
        isDense: true,
        counterText: "",
        contentPadding: const EdgeInsets.all(8.0),
        filled: true,
        fillColor: Colors.white,
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.red)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.black, width: 0.15)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.grey, width: 0.01))
      ),
      textAlign: TextAlign.start,
      maxLines: isExtendedField ? 2 : 1,
      maxLength: maxLength ?? (isExtendedField ? 60 : 35),
    );
  }
}
