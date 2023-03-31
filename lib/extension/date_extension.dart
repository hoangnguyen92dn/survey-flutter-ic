import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String getFormattedString() {
    return '${DateFormat.EEEE().format(this)}, ${DateFormat.MMMMd().format(this)}';
  }
}
