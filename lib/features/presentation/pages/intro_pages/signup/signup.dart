import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/core/utils/validator/validation.dart';
import 'package:fork_and_fusion/features/presentation/pages/intro_pages/sign_in/widgets/signup_prompt.dart';
import 'package:fork_and_fusion/features/presentation/widgets/custome_textform_field.dart';
import 'package:fork_and_fusion/features/presentation/widgets/logo.dart';
import 'package:fork_and_fusion/features/presentation/widgets/textbutton.dart';

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
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    consfirmPasswordController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
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
                    Logo(
                      width: constraints.maxWidth * .5,
                    ),
                    Text(
                      'Create Account',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      width: constraints.maxWidth * .9,
                      child: const Text(
                        'Please enter valid information to access your account',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    gap,
                    CustomeTextField(
                      hintText: 'Name',
                      controller: nameController,
                      validator: Validation.validateName,
                      prefixIcon: const Icon(Icons.person),
                    ),
                    gap,
                    CustomeTextField(
                      hintText: 'Email',
                      controller: emailController,
                      validator: Validation.validateEmail,
                      prefixIcon: const Icon(Icons.mail),
                    ),
                    gap,
                    CustomeTextField(
                      hintText: 'Password',
                      validator: Validation.passwordValidation,
                      controller: passwordController,
                      obsuceText: true,
                      suffixIcon: true,
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    gap,
                    CustomeTextField(
                      hintText: 'Confirm password',
                      validator: Validation.passwordValidation,
                      controller: consfirmPasswordController,
                      obsuceText: true,
                      suffixIcon: true,
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    gap,
                    SizedBox(
                      width: Constants.dWidth * .9,
                      child: CustomeTextButton(
                        text: 'Create Account',
                        onPressed: () {
                          if (Constants.signUp.currentState!.validate()) {
                            log('suceess');
                          }
                        },
                      ),
                    ),
                    gap,
                    AuthPrompt(
                      signUp: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
