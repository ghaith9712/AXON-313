import 'package:flutter/material.dart';

abstract final class AppColors {
  static const background = Color(0xFFF6F5EF);
  static const surface = Color(0xFFFFFFFF);
  static const text = Color(0xFF14283A);
  static const muted = Color(0xFF63727F);
  static const border = Color(0xFFE7E3D9);

  static const navy = Color(0xFF0B2B45);
  static const blue = Color(0xFF14548F);
  static const blueMid = Color(0xFF3B8BD0);
  static const blueSoft = Color(0xFFE5F0FA);

  static const green = Color(0xFF1F7A57);
  static const greenMid = Color(0xFF5FB895);
  static const mint = Color(0xFFA6E3C6);
  static const greenLight = Color(0xFFDDF4E8);

  static const teal = Color(0xFF1B7F8C);
  static const tealMid = Color(0xFF59B8C4);

  static const heroStart = Color(0xFFE3F5EC);
  static const heroEnd = Color(0xFFE4EFFA);

  static const accentGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [blue, green],
  );

  static const softGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [heroStart, heroEnd],
  );
}
