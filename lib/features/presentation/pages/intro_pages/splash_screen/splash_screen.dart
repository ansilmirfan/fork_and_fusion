
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:fork_and_fusion/features/presentation/widgets/logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Constants.dHeight = MediaQuery.of(context).size.height;
    Constants.dWidth = MediaQuery.of(context).size.width;
    context.read<AuthBloc>().add(AuthAlreadyLoggedInCheckEvent());
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AlreadyLoggedInState) {
          Navigator.pushReplacementNamed(context, '/signin');
        }
        if(state is InitialLoggingState){
           Navigator.pushReplacementNamed(context, '/onboard');
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: Logo(),
            ),
            const Expanded(
              child: Text('Version 1.0.0.0'),
            )
          ],
        ),
      ),
    );
  }
}
