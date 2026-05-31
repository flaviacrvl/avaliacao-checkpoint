import 'package:flutter/material.dart';

import 'src/screens/login_screen.dart';
import 'src/screens/initial_screen.dart';
import 'src/services/auth_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> checkLogin() async {
    return await AuthService.instance.isLogged();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'UseDev',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      home: FutureBuilder<bool>(
        future: checkLogin(),

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final logged = snapshot.data ?? false;

          if (logged) {
            return const InitialScreen();
          }

          return const LoginScreen();
        },
      ),
    );
  }
}
// feat: finaliza telas de autenticação e carrinho do checkpoint