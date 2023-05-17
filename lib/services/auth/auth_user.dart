import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';

@immutable
class AuthUser {
  final bool isVerified;
  final String? email;
  final String? uid;

  const AuthUser({
    required this.uid,
    required this.isVerified,
    required this.email,
  });
  factory AuthUser.fromFirebase(User user) => AuthUser(
        isVerified: user.emailVerified,
        email: user.email,
        uid: user.uid,
      );
}
