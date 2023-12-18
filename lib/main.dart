import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosco_clean_architecture/core/constants/variables.dart';
import 'package:hosco_clean_architecture/injection_container.dart';
import 'package:hosco_clean_architecture/presentation/blocs/cart/cart_bloc.dart';
import 'package:hosco_clean_architecture/presentation/blocs/product/product_bloc.dart';
import 'package:hosco_clean_architecture/presentation/screens/login/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
          BlocProvider(create:(_) => ProductBloc(getListProductUC: sl())),
          BlocProvider(create: (_) => CartBloc()),
      ],  
      child: MaterialApp(
        home: const MyLogin(),
        theme: ThemeData(scaffoldBackgroundColor: themeColor),
      ),
    );
  }
}
