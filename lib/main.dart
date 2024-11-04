import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fork_and_fusion/core/services/services.dart';
import 'package:fork_and_fusion/features/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:fork_and_fusion/features/presentation/bloc/cart_managemnt/cart_management_bloc.dart';
import 'package:fork_and_fusion/features/presentation/bloc/cart_quantity/cart_quantity_bloc.dart';
import 'package:fork_and_fusion/features/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:fork_and_fusion/features/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:fork_and_fusion/features/presentation/bloc/product/product_bloc.dart';

import 'package:fork_and_fusion/features/presentation/cubit/favourite_get_all/favourite_get_all_cubit.dart';

import 'package:fork_and_fusion/features/presentation/cubit/selected_category_cubit/selected_category_cubit.dart';
import 'package:fork_and_fusion/features/presentation/cubit/selected_variant/selected_variant_cubit.dart';

import 'package:fork_and_fusion/features/presentation/routs/routes.dart';
import 'package:fork_and_fusion/features/presentation/themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    
    await Firebase.initializeApp(options: Services.firebaseOptions);
  } else {
    await Firebase.initializeApp();
  }
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartQuantityBloc()),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => ProductBloc()),
        BlocProvider(
            create: (context) => CategoryBloc()..add(CategoryGetAllEvent())),
        BlocProvider(create: (context) => SelectedCategoryCubit()),
        BlocProvider(
            create: (context) =>
                CartManagementBloc()..add(CartManagemntGetAllEvent())),
        BlocProvider(create: (context) => SelectedVariantCubit()),
        BlocProvider(create: (context) => FavouriteGetAllCubit()),
        BlocProvider(create: (context) => OrderBloc()..add(OrderGetAllEvent()))
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
