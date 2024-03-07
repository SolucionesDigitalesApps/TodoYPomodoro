import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/scaffold_wrapper.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/onboarding_slide.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const VSpacing(25),
            SizedBox(
              height: mqHeigth(context, 55),
              child: PageView(
                children: const [
                  OnboardingSlide(),
                  OnboardingSlide(),
                  OnboardingSlide(),
                ],
              ),
            ),
            const VSpacing(5),
            CustomButton(
              onPressed: (){}, 
              label: "Start", 
              width: mqWidth(context, 90), 
              color: Theme.of(context).primaryColor
            )
          ],
        ),
      )
    );
  }
}