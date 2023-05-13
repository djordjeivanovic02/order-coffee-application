import 'package:flutter/material.dart';

InputDecoration inputFieldDecoration() {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(
      vertical: 20,
      horizontal: 10,
    ),
    filled: true,
    fillColor: Colors.white,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        color: Colors.brown[500] as Color,
        width: 2,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(
        color: Colors.white,
        width: 2,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(
        color: Colors.white,
        width: 2,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(
        color: Colors.white,
        width: 2,
      ),
    ),
    hintText: 'Unesite Vasu email adresu',
  );
}
