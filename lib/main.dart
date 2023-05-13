import 'package:flutter/material.dart';
import 'package:ordercoffee/constants/routes.dart';
import 'package:ordercoffee/pages/coffee_view.dart';
import 'package:ordercoffee/pages/login_view.dart';
import 'package:ordercoffee/pages/registration_view.dart';
import 'package:ordercoffee/pages/wrapper.dart';

void main() {
  runApp(MaterialApp(
    home: const Wrapper(),
    routes: {
      loginViewRoute: (context) => const LoginView(),
      registrationViewRoute: (context) => const RegistrationView(),
      orderCoffeeViewroute: (context) => const CoffeeView(),
    },
  ));
}
