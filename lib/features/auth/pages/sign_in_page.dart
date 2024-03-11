import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:todo_y_pomodoro_app/core/navigation.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/core/validator.dart';
import 'package:todo_y_pomodoro_app/features/auth/controllers/auth_controller.dart';
import 'package:todo_y_pomodoro_app/features/auth/models/user_model.dart';
import 'package:todo_y_pomodoro_app/features/auth/pages/recover_password_page.dart';
import 'package:todo_y_pomodoro_app/features/auth/pages/sign_up_page.dart';
import 'package:todo_y_pomodoro_app/features/auth/providers/user_provider.dart';
import 'package:todo_y_pomodoro_app/features/common/models/error_response.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/app_version_label.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_text_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_text_form_field.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/general_image.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/page_loader.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/scaffold_wrapper.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';
import 'package:todo_y_pomodoro_app/features/tasks/pages/tasks_home_page.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_activity_provider.dart';

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
                  width: mqHeigth(context, 20),
                  height: mqHeigth(context, 20),
                  url: "",
                  fromLocal: false,
                  fit: BoxFit.cover,
                ),
                const VSpacing(10),
                CustomTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  hintText: FlutterI18n.translate(context, "pages.sign_in.email_label"),
                  errorMessage: emailError,
                ),
                const VSpacing(3),
                CustomTextFormField(
                  controller: passwordController,
                  hintText: FlutterI18n.translate(context, "pages.sign_in.password_label"),
                  errorMessage: passwordError,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTextButton(
                      label: FlutterI18n.translate(context, "pages.sign_in.forget_account"), 
                      onPressed: (){
                        Navigator.push(context, cupertinoNavigationRoute(context, const RecoverPasswordPage()));
                      }, 
                    )
                  ],
                ),
                const VSpacing(10),
                CustomButton(
                  onPressed: onSignIn,
                  label: FlutterI18n.translate(context, "pages.sign_in.sign_in"), 
                  width: mqWidth(context, 90), 
                  color: Theme.of(context).primaryColor
                ),
                const VSpacing(2),
                CustomTextButton(
                  label: FlutterI18n.translate(context, "pages.sign_in.sign_up"), 
                  onPressed: (){
                    Navigator.push(context, cupertinoNavigationRoute(context, const SignUpPage()));
                  }, 
                ),
                const AppVersionLabel()
              ],
            ),
          ),
          PageLoader(
            loading: loading, 
            message: FlutterI18n.translate(context, "pages.sign_in.signingin")
          )
        ],
      )
    );
  }
  Future<void> onSignIn() async {
    emailError = emailValidator(context, emailController.text);
    passwordError = passwordValidator(context, passwordController.text);
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
          FlutterI18n.translate(context, "general.error"), 
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
          FlutterI18n.translate(context, "general.error"), 
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
          FlutterI18n.translate(context, "general.dear"), 
          [FlutterI18n.translate(context, "general.disabled")]
        );
      }
      await authController.signOut();
      return;
    }
    if(mounted){
      Provider.of<UserProvider>(context, listen: false).setNewUser(data);
      Provider.of<TasksActivityProvider>(context, listen: false).selectedTaskGroupId = data.lastGroupId;
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const TasksHomePage()), (route) => false);
    }
  }
}