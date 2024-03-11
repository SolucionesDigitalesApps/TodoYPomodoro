import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/general_image.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';

class OnboardingSlide extends StatelessWidget {
  const OnboardingSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GeneralImage(
          width: mqHeigth(context, 30),
          height: mqHeigth(context, 30),
          url: "",
          fromLocal: false,
          fit: BoxFit.cover,
        ),
        const VSpacing(8),
        SizedBox(
          height: mqHeigth(context, 17),
          child: Column(
            children: [
              Text(FlutterI18n.translate(context, "pages.onboarding.title"), style: Theme.of(context).textTheme.displayLarge),
              Text(FlutterI18n.translate(context, "pages.onboarding.description"), style: Theme.of(context).textTheme.displaySmall, textAlign: TextAlign.center),
            ],
          )
        ),
      ],
    );
  }
}