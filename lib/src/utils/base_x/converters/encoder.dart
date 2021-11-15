import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_bs58check/src/utils/base_x/base_x_codec.dart';

/// BaseX Encoder
class BaseXEncoder extends Converter<Uint8List, String> {
  final BaseXCodec codec;

  const BaseXEncoder(this.codec) : super();

  /// BaseX Encode
  @override
  String convert(Uint8List input) {
    if (input.isEmpty) {
      return "";
    }
    List<int> digits = [0];

    for (int i = 0; i < input.length; ++i) {
      int carry = input[i];
      for (int j = 0; j < digits.length; ++j) {
        carry += digits[j] << 8;
        digits[j] = carry % codec.base;
        carry = carry ~/ codec.base;
      }
      while (carry > 0) {
        digits.add(carry % codec.base);
        carry = carry ~/ codec.base;
      }
    }
    String string = "";

    // deal with leading zeros
    for (int k = 0; input[k] == 0 && k < input.length - 1; ++k) {
      string += codec.leader!;
    }
    // convert digits to a string
    for (int q = digits.length - 1; q >= 0; --q) {
      string += codec.alphabet[digits[q]];
    }
    return string;
  }
}
