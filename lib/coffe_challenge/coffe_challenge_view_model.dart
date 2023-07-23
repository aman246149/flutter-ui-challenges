import 'package:flutter/foundation.dart';

class CoffeChallengeViewModel {
  static final ValueNotifier<int> number = ValueNotifier<int>(0);

  static String formatNumberWithLeadingZero() {
    if (number.value == 0) return '0';
    String formattedNumber = (number.value < 10) ? '0${number.value}' : number.value.toString();
    return formattedNumber;
  }

  static void increment() {
    number.value++;
  }

  static void decrement() {
    if (number.value > 0) {
      number.value--;
    }
  }

  static void clearNumber() {
    number.value = 0;
  }
}
