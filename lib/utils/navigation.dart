import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  void pop() => Navigator.of(this).pop();

  void navigate(Widget page) => Navigator.of(this).push(
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );
}
