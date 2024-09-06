import 'package:flutter/material.dart';
import 'package:fork_and_fusion/features/presentation/pages/sign_in/widgets/signup_prompt.dart';
import 'package:fork_and_fusion/features/presentation/widgets/custome_textform_field.dart';
import 'package:fork_and_fusion/features/presentation/widgets/logo.dart';
import 'package:fork_and_fusion/features/presentation/widgets/textbutton.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController consfirmPasswordController = TextEditingController();
    TextEditingController nameController = TextEditingController();

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
                    prefixIcon: const Icon(Icons.person),
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
                  CustomeTextField(
                    hintText: 'Confirm password',
                    controller: consfirmPasswordController,
                    obsuceText: true,
                    suffixIcon: true,
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  gap,
                  CustomeTextButton(
                    text: 'Create Account',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  gap,
                  AuthPrompt(
                    signUp: false,
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
