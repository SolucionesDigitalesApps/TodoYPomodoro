import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_icon_button.dart';

class MoreItems extends StatelessWidget {
  final Function() onPressed;
  const MoreItems({
    super.key,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mqWidth(context, 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconButton(
            size: 8, 
            fillColor: Theme.of(context).primaryColor.withOpacity(0.6),
            onPressed: onPressed,
            icon: Icon(Icons.arrow_drop_down_rounded, color: Colors.white, size: mqWidth(context, 5),)
          )
        ],
      ),
    );
  }
}