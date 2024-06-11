import 'dart:core';
import 'package:intl/intl.dart';
extension NumberExtension on num {
  String formatNumber(){

    if (this >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(1)}M';
    } else if (this >= 1000) {
      return '${(this / 1000).toStringAsFixed(3)}k';
    } else {
      return toString();
    }
  }

  String formatTime(){
    int minutes = this ~/ 60;
    num seconds = this % 60;

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }

  String formatCurrency() {
    final formatCurrency = NumberFormat('#,##0', 'en_US');
    return formatCurrency.format(this);
  }
}
