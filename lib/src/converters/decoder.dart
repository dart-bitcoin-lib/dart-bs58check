import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_bs58check/src/utils/base_x/base_x_codec.dart';
import 'package:dart_bs58check/src/utils/crypto.dart';

/// base converter
final BaseXCodec _base58 =
    BaseXCodec('123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz');

/// The canonical instance of [Base58CheckDecoder].
const bs58CheckDecoder = Base58CheckDecoder();

/// Base58 Check Decoder
class Base58CheckDecoder extends Converter<String, Uint8List> {
  const Base58CheckDecoder();

  /// Decode Raw Data
  Uint8List decodeRaw(Uint8List buffer) {
    if (buffer.length < 5) {
      throw ArgumentError('Invalid checksum');
    }
    Uint8List payload = buffer.sublist(0, buffer.length - 4);
    Uint8List checksum = buffer.sublist(buffer.length - 4);
    Uint8List newChecksum = hash256(payload);
    if (checksum[0] != newChecksum[0] ||
        checksum[1] != newChecksum[1] ||
        checksum[2] != newChecksum[2] ||
        checksum[3] != newChecksum[3]) {
      throw ArgumentError("Invalid checksum");
    }
    return payload;
  }

  /// Convert base58 list [String] to [Uint8List]
  @override
  Uint8List convert(String input) {
    if (input.trim() == '') throw ArgumentError('Invalid checksum');
    final buf = _base58.decode(input);
    return decodeRaw(buf);
  }
}
