import 'package:flutter/material.dart';
import 'package:fork_and_fusion/features/presentation/widgets/logo.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Logo(),
              Text(
                'Welcome to ',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'Fork & Fusion',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                elevation: 5,
                child: SizedBox(
                  width: 350,
                  child: TextFormField(
                    scrollPadding: const EdgeInsets.only(left: 10),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.mail,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
