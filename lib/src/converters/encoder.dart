import 'dart:convert';
import 'dart:typed_data';

import 'package:base_x/base_x.dart';
import 'package:dart_bs58check/src/utils/crypto.dart';

/// base converter
final BaseXCodec _base58 =
    BaseXCodec('123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz');

/// The canonical instance of [Base58CheckEncoder].
const bs58CheckEncoder = Base58CheckEncoder();

/// Base58 Check Encoder
class Base58CheckEncoder extends Converter<Uint8List, String> {
  const Base58CheckEncoder([this._tmpChecksumFn]);

  final ChecksumFn? _tmpChecksumFn;

  /// checksum function
  Uint8List _checksumFn(Uint8List arg0) {
    return (_tmpChecksumFn ?? hash256)(arg0);
  }

  @override
  String convert(Uint8List input) {
    Uint8List hash = _checksumFn(input);
    Uint8List combine = Uint8List.fromList(
        [input, hash.sublist(0, 4)].expand((i) => i).toList(growable: false));
    return _base58.encode(combine);
  }
}
