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
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_text_form_field.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/page_loader.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/scaffold_wrapper.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';
import 'package:todo_y_pomodoro_app/features/tasks/pages/tasks_home_page.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({super.key});

  @override
  State<RecoverPasswordPage> createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const VSpacing(5),
                const AppHeader(title: "Recuperar contraseña"),
                const VSpacing(5),
                CustomTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  hintText: "Correo",
                  errorMessage: emailError,
                ),
                const VSpacing(8),
                CustomButton(
                  onPressed: onSignIn,
                  label: "Enviar email", 
                  width: mqWidth(context, 90), 
                  color: Theme.of(context).primaryColor
                )
              ],
            ),
          ),
          PageLoader(
            loading: loading, 
            message: "Iniciando sesión"
          )
        ],
      )
    );
  }
  Future<void> onSignIn() async {
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
    final response = await authController.signInUserEmailPassword(emailController.text, passwordController.text);
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
    final responseUser = await authController.fetchUserById(respTemp.uid);
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
    final data = responseUser as UserModel;
    if(!data.enabled){
      setState(() {
        loading = false;
      });
      if(mounted){
        showErrorAlert(
          context, 
          "Estimado usuario", 
          ["Su cuenta se encuentra deshabilitada. Comuníquese con el administrador para más información"]
        );
      }
      await authController.signOut();
      return;
    }
    if(mounted){
      Provider.of<UserProvider>(context, listen: false).setNewUser(data);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const TasksHomePage()), (route) => false);
    }
  }
}