import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ordercoffee/pages/new_coffee.dart';
import 'package:ordercoffee/pages/parts.dart';
import 'package:ordercoffee/services/auth/auth_service.dart';
import 'package:ordercoffee/services/database/database_coffee.dart';
import 'package:ordercoffee/services/models/order_coffee.dart';

class CoffeeOrdersView extends StatelessWidget {
  const CoffeeOrdersView({
    super.key,
    required this.orders,
    required this.dbServices,
  });

  final List<OrderCoffee> orders;
  final DatabaseServices dbServices;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.brown[50],
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            side: BorderSide(
              color:
                  (orders[index].uid == FirebaseAuth.instance.currentUser!.uid)
                      ? Colors.brown[500] as Color
                      : Colors.transparent,
              width: 3,
            ),
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 10,
            ),
            child: ListTile(
              onTap: () async {
                if (orders[index].uid ==
                    AuthService.firebase().currentUser!.uid) {
                  await _showModalBottomSheetFunction(
                    context,
                    orders[index].username,
                    orders[index].strength.toDouble(),
                    orders[index].sugars,
                    orders[index].milk,
                  );
                }
              },
              onLongPress: () async {
                if (orders[index].uid ==
                    AuthService.firebase().currentUser!.uid) {
                  final result = await showErrorDialog(
                    context,
                    'Brisanje narudzbine',
                    'Da li zelite da obrisete naruzbinu?',
                    {
                      'Otkazi': false,
                      'Obrisi': true,
                    },
                  );
                  if (result as bool) {
                    dbServices.deleteOrder();
                  }
                }
              },
              leading: Container(
                color: Colors.brown[orders[index].strength * 100],
                child: Image.asset('assets/images/coffee_icon.png'),
              ),
              title: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orders[index].username,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        (orders[index].milk)
                            ? Row(
                                children: [
                                  Text(
                                    orders[index].strength > 5
                                        ? 'Jaka Kafa + '
                                        : 'Slaba Kafa + ',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/images/milk.png',
                                    scale: 20,
                                  )
                                ],
                              )
                            : Text(
                                orders[index].strength > 5
                                    ? 'Jaka Kafa'
                                    : 'Slaba Kafa',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (orders[index].sugars > 0)
                          for (int i = 0; i < orders[index].sugars; i++)
                            Image.asset(
                              'assets/images/sugar.png',
                              scale: 20,
                            ),
                        if (orders[index].sugars == 0)
                          const Text(
                            'Bez Secera',
                            style: TextStyle(color: Colors.red),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> _showModalBottomSheetFunction(
    BuildContext context,
    String default_username,
    double current_slider_value,
    int sugar_count,
    bool milk,
  ) {
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
              children: [
                NewCoffeeSettings(
                  default_username: default_username,
                  current_slider_value: current_slider_value,
                  sugar_count: sugar_count,
                  milk: milk,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
