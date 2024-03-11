import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/core/validator.dart';
import 'package:todo_y_pomodoro_app/features/auth/controllers/auth_controller.dart';
import 'package:todo_y_pomodoro_app/features/auth/models/user_model.dart';
import 'package:todo_y_pomodoro_app/features/auth/providers/user_provider.dart';
import 'package:todo_y_pomodoro_app/features/common/models/error_response.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/app_header.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/app_version_label.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_text_form_field.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/page_loader.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/scaffold_wrapper.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';
import 'package:todo_y_pomodoro_app/features/tasks/pages/tasks_home_page.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_activity_provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final authController = AuthController();
  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  String emailError = "";
  String passwordError = "";

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      onWillPop: () => Future.value(false),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const VSpacing(5),
                const AppHeader(title: "Crear cuenta"),
                const VSpacing(5),
                CustomTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  hintText: "Correo",
                  errorMessage: emailError,
                ),
                const VSpacing(3),
                CustomTextFormField(
                  controller: passwordController,
                  hintText: "Contraseña",
                  errorMessage: passwordError,
                ),
                const VSpacing(10),
                CustomButton(
                  onPressed: onSignUp,
                  label: "Crear cuenta", 
                  width: mqWidth(context, 90), 
                  color: Theme.of(context).primaryColor
                ),
                const VSpacing(2),
                const AppVersionLabel()
              ],
            ),
          ),
          PageLoader(
            loading: loading, 
            message: "Creando cuenta...", 
          )
        ],
      )
    );
  }
  Future<void> onSignUp() async {
    emailError = emailValidator(emailController.text);
    passwordError = passwordValidator(passwordController.text);
    if(emailError.isNotEmpty || passwordError.isNotEmpty){
      setState(() {});
      return;
    }
    if(loading == true) return;
    emailFocus.unfocus();
    passwordFocus.unfocus();
    setState(() {
      loading = true;
    });
    final response = await authController.signUpUserEmailPassword(emailController.text, passwordController.text);
    if(response is ErrorResponse){
      setState(() {
        loading = false;
      });
      if(mounted){
        showErrorAlert(
          context, 
          "Ocurrió un error", 
          [response.message]
        );
      }
      return;
    }
    final respTemp = response as User;
    final userModel = UserModel(
      id: respTemp.uid, 
      email: emailController.text, 
      enabled: true, 
      lastGroupId: "",
      lastTaskOrder: 0
    );
    final responseUser = await authController.createUserById(userModel);
    if(responseUser is ErrorResponse){
      setState(() {
        loading = false;
      });
      if(mounted){
        showErrorAlert(
          context, 
          "Ocurrió un error", 
          [responseUser.message]
        );
      }
      await authController.signOut();
      return;
    }
    if(mounted){
      Provider.of<UserProvider>(context, listen: false).setNewUser(userModel);
      Provider.of<TasksActivityProvider>(context, listen: false).selectedTaskGroupId = userModel.lastGroupId;
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const TasksHomePage()), (route) => false);
    }
  }
}