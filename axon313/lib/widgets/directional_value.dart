import 'package:flutter/material.dart';

class DirectionalValue extends StatelessWidget {
  const DirectionalValue({super.key, required this.value, this.ltr = false});

  final String value;
  final bool ltr;

  @override
  Widget build(BuildContext context) {
    if (!ltr) return Text(value);
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Text(value),
      ),
    );
  }
}
