import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ordercoffee/services/models/order_coffee.dart';

class DatabaseServices {
  final String uid;
  DatabaseServices(this.uid);

  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('orders');

  Future<void> updateOrder(
    String username,
    int strength,
    int sugars,
    bool milk,
  ) async {
    return await orderCollection.doc(uid).set({
      'username': username,
      'strength': strength,
      'sugars': sugars,
      'milk': milk,
    });
  }

  List<OrderCoffee> _getOrdersFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return OrderCoffee(
        e['strength'] ?? 0,
        e['sugars'] ?? 0,
        e['milk'] ?? false,
        e['username'] ?? null,
      );
    }).toList();
  }

  Stream<List<OrderCoffee>> get orders {
    return orderCollection.snapshots().map(_getOrdersFromSnapshots);
  }
}
