import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:fork_and_fusion/features/presentation/pages/intro_pages/sign_in/widgets/or_widget.dart';
import 'package:fork_and_fusion/features/presentation/pages/intro_pages/sign_in/widgets/signup_prompt.dart';
import 'package:fork_and_fusion/features/presentation/widgets/custome_textform_field.dart';
import 'package:fork_and_fusion/features/presentation/widgets/logo.dart';
import 'package:fork_and_fusion/features/presentation/widgets/textbutton.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    context.read<AuthBloc>();
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        var gap = SizedBox(
          height: constraints.maxHeight * .03,
        );
        return SafeArea(
          child: Center(
            child: SingleChildScrollView(
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
                    prefixIcon: const Icon(Icons.mail),
                  ),
                  gap,
                  CustomeTextField(
                    hintText: 'Password',
                    controller: passwordController,
                    obsuceText: true,
                    suffixIcon: true,
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  gap,
                  SizedBox(
                    width: Constants.dWidth * .9,
                    child: CustomeTextButton(
                      text: 'Login',
                      onPressed: () {},
                    ),
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
        );
      }),
    );
  }
}
