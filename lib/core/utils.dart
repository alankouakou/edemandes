import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

enum MessageType { info, success, warning, error }

class Utils {
  static DateFormat dateFull = DateFormat('dd/MM/yyyy HH:mm:ss');
  static DateFormat dateShort = DateFormat('dd/MM/yyyy');
  static DateFormat timeFull = DateFormat('HH:mm:ss');
  static DateFormat timeShort = DateFormat('HH:mm');

  static String formatCFA(double amount) {
    // Create a NumberFormat instance for currency formatting
    NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'fr_FR', // Change the locale as needed
      symbol:
          'FCFA', // The currency symbol, empty string if you want only the code
      decimalDigits: 0, // The number of decimal digits to display
    );

    // Format the amount as currency
    return currencyFormat.format(amount);
  }

  static String capitalize(String name) {
    if (name.isNotEmpty && name.length > 1) {
      return '${name[0].toUpperCase()}${name.substring(1).toLowerCase()}';
    } else {
      return '';
    }
  }

  static void showToast({required String message, required Color color}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: color.withValues(alpha: 0.9), //color.withOpacity(0.9),
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16,
        timeInSecForIosWeb: 1);
  }

  static void showMessage({required String message, MessageType? messageType}) {
    final Color color;
    switch (messageType) {
      case MessageType.error:
        color = Colors.red.shade300;
        break;
      case MessageType.success:
        color = Colors.green.shade300;
        break;
      case MessageType.warning:
        color = Colors.orange.shade300;
        break;
      default:
        color = Colors.blue.shade300;
        break;
    }
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: color,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16,
        timeInSecForIosWeb: 1);
  }

  static void showErrorMessage({required String message}) {
    showToast(message: message, color: Colors.red);
  }

  static void showWarningMessage({required String message}) {
    showToast(message: message, color: Colors.orange.shade800);
  }

  static void showInfoMessage({required String message}) {
    showToast(message: message, color: Colors.blue);
  }

  static void showSuccessMessage({required String message}) {
    showToast(message: message, color: Colors.green.shade800);
  }
}

extension FonctionsChaine on String {
  String ellipse({int? maxLength}) {
    final longueur = maxLength ?? 10;
    if (this.length > longueur) {
      return '${this.substring(1, longueur)} ...';
    } else {
      return this;
    }
  }

  String get shortened {
    final limit = 25;
    if (this.length > limit) {
      final shortened = substring(0, limit);
      return '$shortened ...';
    } else {
      return this;
    }
  }
}

extension FonctionsDate on DateTime {
  String get shortDate {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String get longDate {
    return DateFormat('dd/MM/yyyy HH:mm:ss').format(this);
  }
}

extension MoneyFunctions on num {
  String get monetaire {
    // Create a NumberFormat instance for currency formatting
    NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'fr_FR', // Change the locale as needed
      symbol: '', // The currency symbol, empty string if you want only the code
      decimalDigits: 0, // The number of decimal digits to display
    );

    // Format the amount as currency
    return currencyFormat.format(this);
  }

  String get francCFA {
    // Create a NumberFormat instance for currency formatting
    NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'fr_FR', // Change the locale as needed
      symbol:
          'FCFA', // The currency symbol, empty string if you want only the code
      decimalDigits: 0, // The number of decimal digits to display
    );

    // Format the amount as currency
    return currencyFormat.format(this);
  }

  String get euros {
    // Create a NumberFormat instance for currency formatting
    NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'fr_FR', // Change the locale as needed
      symbol:
          'EUR', // The currency symbol, empty string if you want only the code
      decimalDigits: 0, // The number of decimal digits to display
    );

    // Format the amount as currency
    return currencyFormat.format(this);
  }

  String get usd {
    // Create a NumberFormat instance for currency formatting
    NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'fr_FR', // Change the locale as needed
      symbol:
          'USD', // The currency symbol, empty string if you want only the code
      decimalDigits: 0, // The number of decimal digits to display
    );

    // Format the amount as currency
    return currencyFormat.format(this);
  }
}
