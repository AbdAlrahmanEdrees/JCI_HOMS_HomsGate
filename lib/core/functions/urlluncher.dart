import 'package:url_launcher/url_launcher.dart';

void lunchurl(String fullurl) async {
  String url = fullurl;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
