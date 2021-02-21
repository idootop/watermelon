import 'package:share_plus/share_plus.dart';

class ShareTool {
  static Future<void> share(String text) async => Share.share('$text');
}
