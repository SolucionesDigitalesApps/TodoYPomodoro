import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/core/validator.dart';
import 'package:todo_y_pomodoro_app/features/auth/controllers/auth_controller.dart';
import 'package:todo_y_pomodoro_app/features/common/models/error_response.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/app_header.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_text_form_field.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/page_loader.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/scaffold_wrapper.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({super.key});

  @override
  State<RecoverPasswordPage> createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  final authController = AuthController();
  
  final emailController = TextEditingController();

  final FocusNode emailFocus = FocusNode();

  String emailError = "";

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
                  onPressed: onSendEmail,
                  label: "Enviar email", 
                  width: mqWidth(context, 90), 
                  color: Theme.of(context).primaryColor
                )
              ],
            ),
          ),
          PageLoader(
            loading: loading, 
            message: "Enviando correo"
          )
        ],
      )
    );
  }
  Future<void> onSendEmail() async {
    emailError = emailValidator(emailController.text);
    if(emailError.isNotEmpty){
      setState(() {});
      return;
    }
    if(loading == true) return;
    emailFocus.unfocus();
    setState(() {
      loading = true;
    });
    final response = await authController.sendRecoverPasswordEmail(emailController.text);
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
    if(!mounted) return;
    showSuccessAlert(context, "Estimado usuario", "Se ha enviado un correo a su dirección de correo electrónico").then((value) => Navigator.pop(context));
  }
}