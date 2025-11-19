import 'package:intl/intl.dart';

class CurrencyFormatter {
  
  static String guaraniFormat(double amount) {
    return 'Gs. ${NumberFormat("#,##0", "es_PY").format(amount)}';
  }
}