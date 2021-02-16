import 'package:url_launcher/url_launcher.dart';

class OpenUtil {
  static void open(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    }
  }

  static void openMap(double latitude, double longitude) async => await open(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
      );

  static void openPhone(String phone) async => await open('tel:$phone');

  static void openMail(String mail) async => await open('mailto:$mail');

  static void openFacebook(String link) async => await open('fb://page/$link');

  static void openInstagram(String link) async =>
      await open('www.instagram.com/$link');

  static void openWhatsapp(String phone) async =>
      await open('whatsapp://send?phone=$phone}');
}
