import 'package:intl/intl.dart';

class DateFormatter {
  static String formatReleaseDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'Fecha no disponible';
    
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy', 'es').format(date);
    } catch (e) {
      return dateString;
    }
  }
  
  static String formatYear(String? dateString) {
    if (dateString == null || dateString.isEmpty) return '';
    
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('yyyy', 'es').format(date);
    } catch (e) {
      return '';
    }
  }
}

