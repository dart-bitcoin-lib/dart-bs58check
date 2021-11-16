import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_bs58check/src/converters/api.dart';
import 'package:dart_bs58check/src/utils/crypto.dart';

/// The canonical instance of [Base58CheckCodec].
const bs58check = Base58CheckCodec();

/// Base58 Check
class Base58CheckCodec extends Codec<Uint8List, String> {
  final ChecksumFn? _tmpChecksumFn;

  const Base58CheckCodec([this._tmpChecksumFn]);

  @override
  Base58CheckDecoder get decoder => _tmpChecksumFn == null
      ? bs58CheckDecoder
      : Base58CheckDecoder(_tmpChecksumFn);

  @override
  Base58CheckEncoder get encoder => _tmpChecksumFn == null
      ? bs58CheckEncoder
      : Base58CheckEncoder(_tmpChecksumFn);
}
