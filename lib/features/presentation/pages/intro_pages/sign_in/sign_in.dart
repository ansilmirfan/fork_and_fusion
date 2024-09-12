import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/core/utils/validator/validation.dart';
import 'package:fork_and_fusion/features/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:fork_and_fusion/features/presentation/pages/intro_pages/sign_in/widgets/or_widget.dart';
import 'package:fork_and_fusion/features/presentation/pages/intro_pages/sign_in/widgets/signup_prompt.dart';
import 'package:fork_and_fusion/features/presentation/widgets/custome_textform_field.dart';
import 'package:fork_and_fusion/features/presentation/widgets/logo.dart';
import 'package:fork_and_fusion/features/presentation/widgets/snackbar.dart';

import 'package:fork_and_fusion/features/presentation/widgets/textbutton.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _SignInPageState extends State<SignInPage> {
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>();
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        var gap = SizedBox(
          height: constraints.maxHeight * .03,
        );
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
                    Logo(
                      width: constraints.maxWidth * .5,
                    ),
                    Text(
                      'Welcome Back ',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      width: constraints.maxWidth * .9,
                      child: const Text(
                        'Enter your email and password to get access your account',
                        textAlign: TextAlign.center,
                      ),
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
                      controller: passwordController,
                      validator: Validation.passwordValidation,
                      obsuceText: true,
                      suffixIcon: true,
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    gap,
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthCompleatedState) {
                          Navigator.of(context)
                              .pushReplacementNamed('/bottomnav');
                        }
                        if (state is AuthErrorState) {
                          showCustomSnackbar(
                              context: context,
                              message: state.message,
                              isSuccess: false);
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoadingState) {
                          return SizedBox(
                            width: Constants.dWidth * .9,
                            child: CustomeTextButton(
                              progress: true,
                            ),
                          );
                        }
                        return SizedBox(
                          width: Constants.dWidth * .9,
                          child: CustomeTextButton(
                            text: 'Login',
                            onPressed: () {
                              if (Constants.signIn.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                    AuthSignInWithEmailEvent(
                                        emailController.text.trim(),
                                        passwordController.text.trim()));
                              }
                            },
                          ),
                        );
                      },
                    ),
                    gap,
                    const OrDivider(),
                    gap,
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthCompleatedState) {
                          Navigator.of(context)
                              .pushReplacementNamed('/bottomnav');
                        }
                        if (state is AuthErrorState) {
                          log(state.message);
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoadingState) {
                          return SizedBox(
                              width: Constants.dWidth * .9,
                              child: CustomeTextButton(
                                progress: true,
                              ));
                        }
                        return SizedBox(
                          width: Constants.dWidth * .9,
                          child: CustomeTextButton(
                            text: 'Sign in with Google',
                            onPressed: () => context
                                .read<AuthBloc>()
                                .add(AuthSignInWithGoogleEvent()),
                            google: true,
                          ),
                        );
                      },
                    ),
                    gap,
                    AuthPrompt()
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
