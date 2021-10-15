import 'dart:typed_data';

/// BaseX is the Base converter.
class BaseX {
  String alphabet;
  Map<String, int> alphabetMap = <String, int>{};
  late int base;

  String? leader;

  BaseX(this.alphabet) {
    base = alphabet.length;
    leader = alphabet[0];
    for (int i = 0; i < alphabet.length; i++) {
      alphabetMap[alphabet[i]] = i;
    }
  }

  /// Encode
  String encode(Uint8List source) {
    if (source.isEmpty) {
      return "";
    }
    List<int> digits = [0];

    for (int i = 0; i < source.length; ++i) {
      int carry = source[i];
      for (int j = 0; j < digits.length; ++j) {
        carry += digits[j] << 8;
        digits[j] = carry % base;
        carry = carry ~/ base;
      }
      while (carry > 0) {
        digits.add(carry % base);
        carry = carry ~/ base;
      }
    }
    String string = "";

    // deal with leading zeros
    for (int k = 0; source[k] == 0 && k < source.length - 1; ++k) {
      string += leader!;
    }
    // convert digits to a string
    for (int q = digits.length - 1; q >= 0; --q) {
      string += alphabet[digits[q]];
    }
    return string;
  }

  /// Decode
  Uint8List decode(String string) {
    if (string.isEmpty) {
      throw ArgumentError('Non-base$base character');
    }
    List<int> bytes = [0];
    for (int i = 0; i < string.length; i++) {
      int? value = alphabetMap[string[i]];
      if (value == null) {
        throw ArgumentError('Non-base$base character');
      }
      int carry = value;
      for (int j = 0; j < bytes.length; ++j) {
        carry += bytes[j] * base;
        bytes[j] = carry & 0xff;
        carry >>= 8;
      }
      while (carry > 0) {
        bytes.add(carry & 0xff);
        carry >>= 8;
      }
    }
    // deal with leading zeros
    for (int k = 0; string[k] == leader && k < string.length - 1; ++k) {
      bytes.add(0);
    }
    return Uint8List.fromList(bytes.reversed.toList());
  }
}
