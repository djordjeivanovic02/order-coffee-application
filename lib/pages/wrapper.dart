import 'package:flutter/material.dart';
import 'package:ordercoffee/pages/coffee_view.dart';
import 'package:ordercoffee/pages/login_view.dart';
import 'package:ordercoffee/services/auth/auth_service.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    //return const LoginView();
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: ((context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              return const CoffeeView();
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        }
      }),
    );
  }
}
