import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final bool loading;
  const CustomTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            label,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 16
            )
          ),
        ),
        if(loading) SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        )
      ],
    );
  }
}