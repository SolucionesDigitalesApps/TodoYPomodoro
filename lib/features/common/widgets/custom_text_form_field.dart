import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextStyle? hintStyle;
  final String errorMessage;
  final TextEditingController? controller;
  final Function()? onTap;
  final TextInputFormatter? formater;
  final GlobalKey<FormState>? formKey;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final double widthPer;
  final int? maxLength;
  final bool autofocus;

  const CustomTextFormField({
    required this.hintText, 
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.keyboardType,
    Key? key, 
    this.hintStyle,
    this.errorMessage = "",
    this.controller,
    this.onTap,
    this.formater,
    this.formKey,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.widthPer = 90,
    this.maxLength,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mqWidth(context, widthPer),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: mqWidth(context, widthPer),
            child: TextFormField(
              autofocus: autofocus,
              key: formKey,
              onTap: onTap,
              focusNode: focusNode,
              controller: controller,
              obscureText: obscureText,
              onChanged: onChanged,
              validator: validator,
              keyboardType: keyboardType,
              maxLength: maxLength,
              inputFormatters: formater != null ? [formater!] : null,
              autocorrect: false,
              style: const TextStyle(
                fontSize: 18,
              ),
              textAlign: textAlign,
              decoration: InputDecoration(
                hintText: hintText,
                isDense: true,
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w400
                ),
                contentPadding: EdgeInsets.only(
                  left: mqWidth(context, 3),
                  top: 20,
                  bottom: 15
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusColor: Colors.grey,
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Colors.grey
                  )
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor
                  )
                ),
              ),
            ),
          ),
          errorMessage.isNotEmpty ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: mqWidth(context, 2)
                ),
                child: Text(errorMessage, 
                  style: const TextStyle(
                    color: Colors.red
                  )
                ),
              ),
            ],
          ) : const SizedBox()
        ],
      ),
    );
  }
}