import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  void pop() => Navigator.of(this).pop();

  void navigate(Widget page) => Navigator.of(this).push(
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );

  void showSnackbar(String message) =>
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
}
