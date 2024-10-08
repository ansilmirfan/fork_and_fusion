import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/core/utils/validator/validation.dart';
import 'package:fork_and_fusion/features/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:fork_and_fusion/features/presentation/pages/intro_pages/sign_in/widgets/signup_prompt.dart';
import 'package:fork_and_fusion/features/presentation/widgets/custome_textform_field.dart';
import 'package:fork_and_fusion/features/presentation/widgets/logo.dart';
import 'package:fork_and_fusion/features/presentation/widgets/snackbar.dart';
import 'package:fork_and_fusion/features/presentation/widgets/buttons/textbutton.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController consfirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  AuthBloc signupBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            var gap = SizedBox(
              height: constraints.maxHeight * .03,
            );
            return SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: Constants.signUp,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Logo(width: constraints.maxWidth * .5),
                        _titleText(context),
                        _descriptionText(constraints),
                        _buildTextFormFields(gap),
                        _buildSignUpButton(),
                        gap,
                        AuthPrompt(signUp: false),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  BlocConsumer<AuthBloc, AuthState> _buildSignUpButton() {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: signupBloc,
      listener: (context, state) {
        if (state is AuthLoadingState) {
          log('loading state');
        }
        if (state is AuthErrorState) {
          showCustomSnackbar(
              context: context, isSuccess: false, message: state.message);
        }
        if (state is AuthCompleatedState) {
          showCustomSnackbar(
            context: context,
            message: "Account created successfully!",
          );
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is AuthLoadingState) {
          SizedBox(
            width: Constants.dWidth * .9,
            child: CustomTextButton(progress: true),
          );
        }
        return SizedBox(
          width: Constants.dWidth * .9,
          child: CustomTextButton(
            text: 'Create Account',
            onPressed: () {
              if (Constants.signUp.currentState!.validate()) {
                if (passwordController.text.trim() ==
                    consfirmPasswordController.text.trim()) {
                  signupBloc.add(AuthSignUpWithEmailEvent(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                      nameController.text.trim()));
                } else {
                  showCustomSnackbar(
                      context: context,
                      message:
                          "The confirmation password doesn't match the original.",
                      isSuccess: false);
                }
              }
            },
          ),
        );
      },
    );
  }

  SizedBox _descriptionText(BoxConstraints constraints) {
    return SizedBox(
      width: constraints.maxWidth * .9,
      child: const Text(
        'Please enter valid information to access your account',
        textAlign: TextAlign.center,
      ),
    );
  }

  Text _titleText(BuildContext context) {
    return Text(
      'Create Account',
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  Column _buildTextFormFields(SizedBox gap) {
    return Column(
      children: [
        gap,
        CustomTextField(
          hintText: 'Name',
          controller: nameController,
          validator: Validation.validateName,
          prefixIcon: const Icon(Icons.person),
        ),
        gap,
        CustomTextField(
          hintText: 'Email',
          controller: emailController,
          validator: Validation.validateEmail,
          prefixIcon: const Icon(Icons.mail),
        ),
        gap,
        CustomTextField(
          hintText: 'Password',
          validator: Validation.passwordValidation,
          controller: passwordController,
          obscureIcon: true,
          obsuceText: true,
          prefixIcon: const Icon(Icons.lock),
        ),
        gap,
        CustomTextField(
          hintText: 'Confirm password',
          validator: Validation.passwordValidation,
          controller: consfirmPasswordController,
          obscureIcon: true,
          obsuceText: true,
          prefixIcon: const Icon(Icons.lock),
        ),
        gap,
      ],
    );
  }
}
