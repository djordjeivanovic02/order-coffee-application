import 'package:flutter/material.dart';
import 'package:ordercoffee/services/models/order_coffee.dart';

class CoffeeOrdersView extends StatelessWidget {
  const CoffeeOrdersView({
    super.key,
    required this.orders,
  });

  final List<OrderCoffee> orders;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.brown[50],
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
                        for (int i = 0; i < orders[index].sugars; i++)
                          Image.asset(
                            'assets/images/sugar.png',
                            scale: 20,
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
}
