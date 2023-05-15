import 'package:flutter/material.dart';
import 'package:ordercoffee/constants/routes.dart';
import 'package:ordercoffee/enums/functionality.dart';
import 'package:ordercoffee/pages/new_coffee.dart';
import 'package:ordercoffee/pages/parts.dart';
import 'package:ordercoffee/services/auth/auth_service.dart';

class CoffeeView extends StatefulWidget {
  const CoffeeView({super.key});

  @override
  State<CoffeeView> createState() => _CoffeeViewState();
}

class _CoffeeViewState extends State<CoffeeView> {
  double _currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[500],
        title: const Text('OrderCoffee'),
        actions: [
          IconButton(
            onPressed: () {
              _showModalBottomSheetFunction(context);
            },
            icon: const Icon(Icons.add_box_outlined),
          ),
          PopupMenuButton(
            onSelected: (value) async {
              switch (value) {
                case MenuActions.logOut:
                  final result = await showErrorDialog(
                    context,
                    'Odjava',
                    'Da li ste sigurni da zelite da se odjavite?',
                    {
                      'Otkazi': false,
                      'Da, odjavi se': true,
                    },
                  );
                  if (result ?? false) {
                    final result = AuthService.firebase().currentUser;
                    if (result != null) {
                      await AuthService.firebase().logOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        loginViewRoute,
                        (route) => false,
                      );
                    }
                  }
                  break;
                case MenuActions.settings:
                  break;
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: MenuActions.settings,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'Podesavanja',
                    ),
                    trailing: Icon(
                      Icons.settings,
                      color: Colors.black,
                    ),
                  ),
                ),
                const PopupMenuItem(
                  value: MenuActions.logOut,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'Odjavi se',
                    ),
                    trailing: Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/coffee_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showModalBottomSheetFunction(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: const NewCoffeeSettings(),
        );
      },
    );
  }
}
