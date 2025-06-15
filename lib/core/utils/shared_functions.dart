import 'package:intl/intl.dart' as international;

bool checkIsRTL(String text) {
  if (RegExp(r'^[!@#\$%\^&\*\(\)\-_\+=\[\]\{\};:"\\|,.<>\/?]')
      .hasMatch(text[0])) {
    return false; // If the first character is symbolic, assume LTR
  }
  return international.Bidi.detectRtlDirectionality(text);
}
