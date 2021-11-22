import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_bs58/dart_bs58.dart';
import 'package:dart_bs58check/src/utils/crypto.dart';

/// The canonical instance of [Base58CheckDecoder].
const bs58CheckDecoder = Base58CheckDecoder();

/// Base58 Check Decoder
class Base58CheckDecoder extends Converter<String, Uint8List> {
  final ChecksumFn? _tmpChecksumFn;

  /// checksum function
  Uint8List _checksumFn(Uint8List arg0) {
    return (_tmpChecksumFn ?? hash256)(arg0);
  }

  const Base58CheckDecoder([this._tmpChecksumFn]);

  /// Decode Raw Data
  Uint8List decodeRaw(Uint8List buffer) {
    if (buffer.length < 5) {
      throw ArgumentError('Invalid checksum');
    }
    Uint8List payload = buffer.sublist(0, buffer.length - 4);
    Uint8List checksum = buffer.sublist(buffer.length - 4);
    Uint8List newChecksum = _checksumFn(payload);
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
    try {
      final buf = bs58.decode(input);
      return decodeRaw(buf);
    } catch (e) {
      if (RegExp(r'The character \"[^\"]*\" at index [0-9]+ is invalid\.')
          .hasMatch(e.toString())) {
        throw Exception('Non-base58 character');
      }
      rethrow;
    }
  }
}
