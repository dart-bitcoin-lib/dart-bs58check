import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_bs58check/src/utils/base_x/converters/decoder.dart';
import 'package:dart_bs58check/src/utils/base_x/converters/encoder.dart';

/// BaseX Codec
class BaseXCodec extends Codec<Uint8List, String> {
  /// BaseX Alphabet
  String alphabet;

  /// BaseX Alphabet Map
  Map<String, int> alphabetMap = <String, int>{};

  /// Base
  late int base;

  /// Leader
  String? leader;

  BaseXCodec(this.alphabet) {
    base = alphabet.length;
    leader = alphabet[0];
    for (int i = 0; i < alphabet.length; i++) {
      alphabetMap[alphabet[i]] = i;
    }
  }

  @override
  BaseXDecoder get decoder => BaseXDecoder(this);

  @override
  BaseXEncoder get encoder => BaseXEncoder(this);
}
