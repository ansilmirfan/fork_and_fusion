import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/features/presentation/bloc/cart_quantity/cart_quantity_bloc.dart';
import 'package:fork_and_fusion/features/presentation/routs/routes.dart';
import 'package:fork_and_fusion/features/presentation/themes/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartQuantityBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.primaryTheme,
        onGenerateRoute: Routes.routes,
        initialRoute: '/',
      ),
    );
  }
}
