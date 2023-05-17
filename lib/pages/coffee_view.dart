import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ordercoffee/constants/routes.dart';
import 'package:ordercoffee/enums/functionality.dart';
import 'package:ordercoffee/pages/coffee_orders_view.dart';
import 'package:ordercoffee/pages/loading_view.dart';
import 'package:ordercoffee/pages/new_coffee.dart';
import 'package:ordercoffee/pages/parts.dart';
import 'package:ordercoffee/services/auth/auth_service.dart';
import 'package:ordercoffee/services/database/database_coffee.dart';
import 'package:ordercoffee/services/models/order_coffee.dart';

class CoffeeView extends StatefulWidget {
  const CoffeeView({super.key});

  @override
  State<CoffeeView> createState() => _CoffeeViewState();
}

class _CoffeeViewState extends State<CoffeeView> {
  final DatabaseServices _dbServices =
      DatabaseServices(FirebaseAuth.instance.currentUser!.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[500],
        title: const Text('Naruci Kafu'),
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
      body: StreamBuilder(
        stream: _dbServices.orders,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              final orders = snapshot.data as List<OrderCoffee>;
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/coffee_bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: CoffeeOrdersView(orders: orders),
                ),
              );
            default:
              return const LoadingView();
          }
        },
      ),
    );
  }

  Future<dynamic> _showModalBottomSheetFunction(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom, // Pomera sadržaj iznad tastature
            ),
            color: Colors.white,
            child: ListView(
              shrinkWrap: true,
              children: const [
                NewCoffeeSettings(),
              ],
            ),
          ),
        );
      },
    );
  }
}
