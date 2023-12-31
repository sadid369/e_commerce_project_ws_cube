import 'package:e_commerce_project_ws_cube/common/widgets/bottom_bar.dart';
import 'package:e_commerce_project_ws_cube/constants/global_variables.dart';
import 'package:e_commerce_project_ws_cube/features/account/services/account_services.dart';
import 'package:e_commerce_project_ws_cube/features/admin/screens/admin_screen.dart';
import 'package:e_commerce_project_ws_cube/features/auth/screens/auth_screen.dart';
import 'package:e_commerce_project_ws_cube/features/auth/services/auth_service.dart';
import 'package:e_commerce_project_ws_cube/features/product_details/services/product_details_services.dart';
import 'package:e_commerce_project_ws_cube/providers/user_provider.dart';
import 'package:e_commerce_project_ws_cube/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => AuthService(),
    ),
    ChangeNotifierProvider(
      create: (context) => AccountServices(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProductDetailsServices(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    // authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Amazon Clone',
        theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme: const ColorScheme.light(
            primary: GlobalVariables.secondaryColor,
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          useMaterial3: true, // can remove this line
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: FutureBuilder(
          future: context.read<AuthService>().getUserData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Provider.of<UserProvider>(context).user.token.isNotEmpty
                  ? Provider.of<UserProvider>(context).user.type == 'user'
                      ? const BottomBar()
                      : const AdminScreen()
                  : const AuthScreen();
            }
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          },
        ));
  }
}
