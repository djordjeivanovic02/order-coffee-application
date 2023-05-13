import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ordercoffee/constants/routes.dart';
import 'package:ordercoffee/pages/parts.dart';
import 'package:ordercoffee/services/auth/auth_exceptions.dart';
import 'package:ordercoffee/services/auth/auth_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        title: const Text('Prijavi se na ordercoffee'),
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
                    await AuthService.firebase().logIn(
                      email: email,
                      password: password,
                    );
                    final user = AuthService.firebase().currentUser;
                    if (user != null) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        orderCoffeeViewroute,
                        (route) => false,
                      );
                    } else {
                      throw UserNotLoggedInException();
                    }
                  } on UserDisabledException {
                    showErrorDialog(
                      context,
                      'Doslo je do greske',
                      'Ovaj nalog je blokiran. Pokusajte kasnije!',
                    );
                  } on InvalidEmailException {
                    showErrorDialog(
                      context,
                      'Doslo je do greske',
                      'Email adrasa koju ste uneli nije ispravna. Pokusajte sa drugom email adresom.',
                    );
                  } on UserNotFoundException {
                    showErrorDialog(
                      context,
                      'Doslo je do greske',
                      'Korisnik ne postoji!',
                    );
                  } on WrongPasswordException {
                    showErrorDialog(
                      context,
                      'Doslo je do greske',
                      'Lozinka koju ste uneli nije tacna!',
                    );
                  } on TooManyRequestsException {
                    showErrorDialog(
                      context,
                      'Doslo je do greske',
                      'Molimo pokusajte kasnije',
                    );
                  } on OperationNotAllowedException {
                    showErrorDialog(
                      context,
                      'Doslo je do greske',
                      'Molimo pokusajte kasnije',
                    );
                  } on AccountExistWithDifferentCredentialException {
                    showErrorDialog(
                      context,
                      'Doslo je do greske',
                      'Nalog postoji ali sa drugim podacima!',
                    );
                  } on WeakPasswordException {
                    showErrorDialog(
                      context,
                      'Doslo je do greske',
                      'Uneta lozinka je slaba. Molimo unesite jacu lozinku',
                    );
                  } on UserNotLoggedInException {
                    showErrorDialog(
                      context,
                      'Doslo je do greske',
                      'Korisnik nije prijavljen!',
                    );
                  } on GenericException {
                    showErrorDialog(
                      context,
                      'Doslo je do greske',
                      'Molimo pokusajte kasnije!',
                    );
                  } catch (_) {
                    showErrorDialog(
                      context,
                      'Doslo je do greske',
                      'Molimo pokusajte kasnije!',
                    );
                  }
                },
                child: const Text(
                  'Prijava',
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
                const Text('Jos uvek nemate nalog?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      registrationViewRoute,
                      (route) => false,
                    );
                  },
                  child: Text(
                    'Registruj se!',
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

Future<void> showErrorDialog(
  BuildContext context,
  String title,
  String content,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('U redu'),
          ),
        ],
      );
    },
  );
}
