import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallButton extends StatelessWidget {
  final String phoneNumber;

  const CallButton({required this.phoneNumber});

  void _launchPhoneDialer() async {
    String url = 'tel:$phoneNumber';
    if (await canLaunchUrl(url as Uri)) {
      await launchUrl(url as Uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _launchPhoneDialer,
      child: Text('Call'),
    );
  }
}
