import 'dart:typed_data';
import 'dart:convert';
import 'dart:ui';

extension UiImageToBytes on Image {
  Future<Uint8List> toBytes() async {
    final byteData = await toByteData(format: ImageByteFormat.png);
    return byteData.buffer.asUint8List();
  }
}

extension Base64ToBytes on String {
  Uint8List toBytes() => base64Decode(this);
}

extension BytesToBase64 on Uint8List {
  String toBase64() => base64Encode(this);
}
