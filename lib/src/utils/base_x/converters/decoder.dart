import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_bs58check/src/utils/base_x/base_x_codec.dart';

/// BaseX Decoder
class BaseXDecoder extends Converter<String, Uint8List> {
  final BaseXCodec codec;

  const BaseXDecoder(this.codec) : super();

  /// BaseX Decode
  @override
  Uint8List convert(String input) {
    if (input.isEmpty) {
      throw ArgumentError('Non-base${codec.base} character');
    }
    List<int> bytes = [0];
    for (int i = 0; i < input.length; i++) {
      int? value = codec.alphabetMap[input[i]];
      if (value == null) {
        throw ArgumentError('Non-base${codec.base} character');
      }
      int carry = value;
      for (int j = 0; j < bytes.length; ++j) {
        carry += bytes[j] * codec.base;
        bytes[j] = carry & 0xff;
        carry >>= 8;
      }
      while (carry > 0) {
        bytes.add(carry & 0xff);
        carry >>= 8;
      }
    }
    // deal with leading zeros
    for (int k = 0; input[k] == codec.leader && k < input.length - 1; ++k) {
      bytes.add(0);
    }
    return Uint8List.fromList(bytes.reversed.toList());
  }
}
