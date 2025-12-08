import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class GuaraniInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat("#,##0", "es_PY");

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Si borró todo, devolvemos vacío
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Quitamos puntos y comas para obtener solo números
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) digits = "0";

    // Convertimos a número
    final number = double.parse(digits);

    // Aplicamos formato Gs.
    final newText = _formatter.format(number);

    // Ajustamos cursor al final
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
