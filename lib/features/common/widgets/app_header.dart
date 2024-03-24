import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_icon_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/h_spacing.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final Function()? onBack;
  const AppHeader({
    super.key,
    required this.title,
    this.onBack
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: mqWidth(context, 5)
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: mqWidth(context, 10),
                child: CustomIconButton(
                  size: 10, 
                  onPressed: onBack ?? () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back)
                ),
              ),
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const HSpacing(10)
            ],
          ),
        ],
      ),
    );
  }
}