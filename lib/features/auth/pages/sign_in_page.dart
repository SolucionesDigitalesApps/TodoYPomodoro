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
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_text_form_field.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/general_image.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/page_loader.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/scaffold_wrapper.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';
import 'package:todo_y_pomodoro_app/features/tasks/pages/tasks_home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
                const VSpacing(15),
                GeneralImage(
                  width: mqWidth(context, 60),
                  url: "assets/images/logo_app.png",
                  fromLocal: true,
                ),
                const VSpacing(10),
                CustomTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  hintText: "Ingrese su correo",
                  errorMessage: emailError,
                ),
                const VSpacing(3),
                CustomTextFormField(
                  controller: passwordController,
                  hintText: "Ingrese su contraseña",
                  errorMessage: passwordError,
                ),
                const VSpacing(10),
                CustomButton(
                  onPressed: onSignIn,
                  label: "Iniciar sesión", 
                  width: mqWidth(context, 60), 
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