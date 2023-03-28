import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse(
    'https://drive.google.com/file/d/1g5TSLSlxUdEh6WH3S-0b66xZHEMa_s6W/view?usp=sharing');

class app_launch extends StatelessWidget {
  const app_launch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Install a App"),
        backgroundColor: const Color(0xFF6539C0),
      ),
      body: const Center(
        child: ElevatedButton(
          onPressed: _launchUrl,
          child: Text('Button'),
        ),
      ),
    );
  }
}

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  } else {
    await launchUrl(
      _url,
      mode: LaunchMode.externalNonBrowserApplication,
    );
  }
}
