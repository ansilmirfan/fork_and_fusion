import 'package:flutter/material.dart';

class AuthPrompt extends StatelessWidget {
  bool signUp;
  AuthPrompt({super.key, this.signUp = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(signUp ? 'Don’t have an account?' : 'Already have an account?'),
          TextButton(
            style: const ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(Colors.blue)),
            onPressed: () {
              signUp
                  ? Navigator.of(context).pushNamed('/signup')
                  : Navigator.of(context).pop();
            },
            child: Text(signUp ? 'Signup here' : 'Login here'),
          )
        ],
      ),
    );
  }
}
