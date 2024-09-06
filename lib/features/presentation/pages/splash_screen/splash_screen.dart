import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/widgets/logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushReplacementNamed('/onboard'),
    );
  }

  @override
  Widget build(BuildContext context) {
    Constants.dHeight = MediaQuery.of(context).size.height;
    Constants.dWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
    );
  }
}
