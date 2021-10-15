# dart_bs58check

A straight forward implementation of base58check extending upon base58.

## Install

        dart pub add dart_bs58check

## Example

```dart
import 'dart:typed_data';

import 'package:dart_bs58check/dart_bs58check.dart' as bs58check;

/// encode and decode test
void main() {
  Uint8List decoded =
  bs58check.decode('5Kd3NBUAdUnhyzenEwVLy9pBKxSwXvE9FMPyR4UKZvpe6E3AgLr');

  print(decoded);
  // => [128, 237, 219, 220, 17, 104, 241, 218, 234, 219, 211, 228, 76, 30, 63, 143, 90, 40, 76, 32, 41, 247, 138, 210, 106, 249, 133, 131, 164, 153, 222, 91, 25]

  print(bs58check.encode(decoded));
  // => 5Kd3NBUAdUnhyzenEwVLy9pBKxSwXvE9FMPyR4UKZvpe6E3AgLr
}
```

## LICENSE [MIT](LICENSE)