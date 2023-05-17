import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ordercoffee/services/auth/auth_user.dart';

class DatabaseUserServices {
  final String uid;
  DatabaseUserServices(this.uid);

  final CollectionReference _dbUsersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateUser(
    String email,
  ) async {
    return _dbUsersCollection.doc(uid).set({
      'email': email,
    });
  }

  List<AuthUser> _getAllUsers(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return AuthUser(
        email: e['email'],
        uid: e.id,
        isVerified: false,
      );
    }).toList();
  }

  Stream<List<AuthUser>> get getUsers {
    return _dbUsersCollection.snapshots().map(_getAllUsers);
  }
}
