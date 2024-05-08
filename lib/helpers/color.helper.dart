

import 'dart:ui';

class ColorHelper {
  static Color getRankColor(int number) {
    switch (number) {
      case 1:
        return const Color(0xFFD5310E);
      case 2:
        return const Color(0xFFFF8502);
      case 3:
        return const Color(0xFFFDE216);
      case 4:
        return const Color(0xFF673D07);
      case 5:
        return const Color(0xFF9A9898);
      default:
        return const Color(0xFFC0C0C0);
    }
  }
}