import 'package:flutter/material.dart';
import 'package:ordercoffee/constants/routes.dart';
import 'package:ordercoffee/pages/parts.dart';
import 'package:ordercoffee/services/auth/auth_exceptions.dart';
import 'package:ordercoffee/services/auth/auth_service.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[500],
        title: const Text('Registruj se na ordercoffee'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: inputFieldDecoration(),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _passwordController,
              enableSuggestions: false,
              autocorrect: false,
              obscureText: true,
              decoration: inputFieldDecoration(),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.brown[500],
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextButton(
                onPressed: () async {
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  try {
                    await AuthService.firebase().createUser(
                      email: email,
                      password: password,
                    );
                    final user = AuthService.firebase().currentUser;
                    print('User $user');
                    if (user != null) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        orderCoffeeViewroute,
                        (route) => false,
                      );
                    } else {
                      throw UserNotLoggedInException();
                    }
                  } on InvalidEmailException {
                    print('Invalid Email');
                  } on UserNotFoundException {
                    print('User Not Found');
                  } on GenericException {
                    print('Generic Exception');
                  }
                },
                child: const Text(
                  'Registracija',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Imate nalog?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginViewRoute,
                      (route) => false,
                    );
                  },
                  child: Text(
                    'Prijavi se!',
                    style: TextStyle(
                        color: Colors.brown[500], fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
