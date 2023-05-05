import 'package:flutter/services.dart';

String formatPhoneNumber(String phoneNumber) {
  if (phoneNumber.isEmpty) {
    return '';
  }
  phoneNumber = phoneNumber.replaceAll(RegExp(r'[^0-9-()+ ]'), '');

  if (phoneNumber.length < 10) {
    return phoneNumber;
  }
  if (RegExp(r'^\+1 \([0-9]{3}\) [0-9]{3}\-[0-9]{4}$').hasMatch(phoneNumber)) {
    return phoneNumber;
  }
  if (phoneNumber.substring(0, 2) == "+1" && phoneNumber.length == 17) {
    phoneNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    phoneNumber =
        phoneNumber.substring(1, phoneNumber.length - 1 > 10 ? 11 : null);
  }
  if (phoneNumber.substring(0, 2) == "+1" && phoneNumber.length < 17) {
    return phoneNumber;
  }
  if ((phoneNumber.substring(0, 2) != "+1" && phoneNumber.length == 10)) {
    phoneNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    return '+1 (${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6, 10)}';
  }

  return phoneNumber;
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    final formattedText = formatPhoneNumber(text);

    // Return the formatted value with the new cursor position
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: newValue.selection.end),
      composing: TextRange.empty,
    );
  }
}
