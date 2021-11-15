import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_bs58check/src/utils/base_x/base_x_codec.dart';
import 'package:dart_bs58check/src/utils/crypto.dart';

/// base converter
final BaseXCodec _base58 =
    BaseXCodec('123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz');

/// The canonical instance of [Base58CheckEncoder].
const bs58CheckEncoder = Base58CheckEncoder();

/// Base58 Check Encoder
class Base58CheckEncoder extends Converter<Uint8List, String> {
  const Base58CheckEncoder();

  @override
  String convert(Uint8List input) {
    Uint8List hash = hash256(input);
    Uint8List combine = Uint8List.fromList(
        [input, hash.sublist(0, 4)].expand((i) => i).toList(growable: false));
    return _base58.encode(combine);
  }
}
