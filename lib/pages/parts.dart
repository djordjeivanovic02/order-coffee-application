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

Future<bool?> showErrorDialog(BuildContext context, String title,
    String content, Map<String, bool> options) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: options.keys.map(
          (x) {
            final bool? value = options[x];
            return TextButton(
              onPressed: () {
                if (value != null) {
                  Navigator.of(context).pop(value);
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                x,
                style: TextStyle(
                  color: Colors.brown[500],
                ),
              ),
            );
          },
        ).toList(),
      );
    },
  );
}
