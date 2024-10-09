// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/services/services.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/core/utils/validator/validation.dart';
import 'package:fork_and_fusion/features/domain/usecase/Auth%20usecase/forgot_password_usecase.dart';
import 'package:fork_and_fusion/features/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:fork_and_fusion/features/presentation/pages/intro_pages/sign_in/widgets/or_widget.dart';
import 'package:fork_and_fusion/features/presentation/pages/intro_pages/sign_in/widgets/signup_prompt.dart';
import 'package:fork_and_fusion/features/presentation/widgets/custom_alert_dialog.dart';
import 'package:fork_and_fusion/features/presentation/widgets/custome_textform_field.dart';
import 'package:fork_and_fusion/features/presentation/widgets/logo.dart';
import 'package:fork_and_fusion/features/presentation/widgets/snackbar.dart';

import 'package:fork_and_fusion/features/presentation/widgets/buttons/textbutton.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController forgotPasswordController = TextEditingController();
AuthBloc logInBloc = AuthBloc();
AuthBloc googleSignInbloc = AuthBloc();

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          var gap = SizedBox(height: constraints.maxHeight * .03);
          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: Constants.signIn,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Logo(width: constraints.maxWidth * .5),
                      _titleText(context),
                      _descriptionText(constraints),
                      _buildTextFormFields(gap),
                      _forgotPasswordButton(context),
                      _buildSignInButton(),
                      gap,
                      const OrDivider(),
                      gap,
                      _buildGoogleSignInButton(),
                      gap,
                      AuthPrompt()
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  SizedBox _forgotPasswordButton(BuildContext context) {
    return SizedBox(
      width: Constants.dWidth * .9,
      child: Align(
        alignment: Alignment.topRight,
        child: TextButton(
          onPressed: () => forgotPassword(context),
          child: const Text('Forgot Password?'),
        ),
      ),
    );
  }

  BlocConsumer<AuthBloc, AuthState> _buildGoogleSignInButton() {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: googleSignInbloc,
      listener: (context, state) {
        if (state is AuthCompleatedState) {
          Navigator.of(context)
              .pushReplacementNamed('/bottomnav')
              .then((value) {
            emailController.clear();
            passwordController.clear();
          });
        }
        if (state is AuthErrorState) {
          showCustomSnackbar(
              context: context, message: state.message, isSuccess: false);
        }
      },
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return SizedBox(
              width: Constants.dWidth * .9,
              child: CustomTextButton(progress: true));
        }
        return SizedBox(
          width: Constants.dWidth * .9,
          child: CustomTextButton(
            text: 'Sign in with Google',
            onPressed: () => googleSignInbloc.add(AuthSignInWithGoogleEvent()),
            google: true,
          ),
        );
      },
    );
  }

  BlocConsumer<AuthBloc, AuthState> _buildSignInButton() {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: logInBloc,
      listener: (context, state) {
        if (state is AuthCompleatedState) {
          Navigator.of(context)
              .pushReplacementNamed('/bottomnav')
              .then((value) {
            emailController.clear();
            passwordController.clear();
          });
        }
        if (state is AuthErrorState) {
          showCustomSnackbar(
              context: context, message: state.message, isSuccess: false);
        }
      },
      builder: (context, state) {
        if (state is AuthSignInLoadingState) {
          return SizedBox(
            width: Constants.dWidth * .9,
            child: CustomTextButton(
              progress: true,
            ),
          );
        }
        return SizedBox(
          width: Constants.dWidth * .9,
          child: CustomTextButton(
            text: 'Login',
            onPressed: () {
              if (Constants.signIn.currentState!.validate()) {
                logInBloc.add(AuthSignInWithEmailEvent(
                    emailController.text.trim(),
                    passwordController.text.trim()));
              }
            },
          ),
        );
      },
    );
  }

  Column _buildTextFormFields(SizedBox gap) {
    return Column(
      children: [
        gap,
        CustomTextField(
          hintText: 'Email',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          validator: Validation.validateEmail,
          prefixIcon: const Icon(Icons.mail),
        ),
        gap,
        CustomTextField(
          hintText: 'Password',
          controller: passwordController,
          validator: Validation.passwordValidation,
          obsuceText: true,
          obscureIcon: true,
          prefixIcon: const Icon(Icons.lock),
        ),
      ],
    );
  }

  SizedBox _descriptionText(BoxConstraints constraints) {
    return SizedBox(
      width: constraints.maxWidth * .9,
      child: const Text(
        'Enter your email and password to get access your account',
        textAlign: TextAlign.center,
      ),
    );
  }

  Text _titleText(BuildContext context) {
    return Text('Welcome Back ', style: Theme.of(context).textTheme.titleLarge);
  }

  void forgotPassword(BuildContext context) async {
    showCustomAlertDialog(
      context: context,
      title: 'Forgot password?',
      controller: forgotPasswordController,
      textField: true,
      onPressed: () async {
        try {
          ForgotPasswordUsecase usercase =
              ForgotPasswordUsecase(await Services.firebaseRepo());

          await usercase.call(forgotPasswordController.text.trim());
          Navigator.of(context).pop();
          showCustomSnackbar(
              context: context,
              message: 'Password updated please check your email');
        } catch (e) {
          showCustomSnackbar(
              context: context, message: e.toString(), isSuccess: false);
        }
      },
    );
  }
}
