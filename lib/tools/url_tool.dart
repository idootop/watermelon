import 'package:url_launcher/url_launcher.dart';

class UrlTool {
  static Future<void> open(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
