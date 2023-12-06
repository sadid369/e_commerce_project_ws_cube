import 'package:e_commerce_project_ws_cube/constants/global_variables.dart';
import 'package:e_commerce_project_ws_cube/features/auth/screens/auth_screens.dart';
import 'package:e_commerce_project_ws_cube/features/auth/services/auth_service.dart';
import 'package:e_commerce_project_ws_cube/features/home/screens/home_screens.dart';
import 'package:e_commerce_project_ws_cube/providers/user_provider.dart';
import 'package:e_commerce_project_ws_cube/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-Commerce Project',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: GlobalVariables.secondaryColor,
          ),
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: Builder(builder: (context) {
          return FutureBuilder(
            future: authService.getUserData(context: context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return context.watch<UserProvider>().user.token.isNotEmpty
                    ? const HomeScreens()
                    : const AuthScreens();
              }
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          );
        }));
  }
}
