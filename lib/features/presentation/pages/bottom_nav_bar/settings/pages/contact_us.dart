import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fork_and_fusion/features/presentation/widgets/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Us')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(gap: 20),
            Text(
              'We’d love to hear from you! Whether you have questions, feedback, or need assistance with Fork and Fusion, feel free to reach out to us. We’re here to help.',
            ),
            Gap(gap: 20),
            Text(
              'Customer Support',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            Text(
              'For any issues or inquiries regarding the app, orders, or payments, contact our support team via email or phone. Our support hours are 9 AM - 6 PM, Monday to Friday.',
            ),
            Gap(gap: 10),
            RichText(
                text: TextSpan(
                    text: "- **Email:**",
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                  TextSpan(
                      text: 'ansilmirfan123@gmail.com',
                      recognizer: TapGestureRecognizer()
                        ..onTap =
                            () => _launchEmail('ansilmirfan123@gmail.com'),
                      style: TextStyle(color: Colors.blue)),
                ])),
            Text(
              '- **Phone:** +1-234-567-8900',
            ),
            Gap(gap: 20),
            Text(
              'Business Inquiries',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            Text(
              'For partnership opportunities, collaborations, or other business-related inquiries, please get in touch with our business development team.',
            ),
            Gap(gap: 10),
            Text(
              '- **Email:** business@forkandfusion.com',
            ),
            Gap(gap: 20),
            Text(
              'Follow Us',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            Text(
              'Stay up-to-date with our latest features, offers, and news by following us on social media:',
            ),
            Gap(gap: 10),
            Text(
              '- **Instagram:** @forkandfusion\n'
              '- **Facebook:** Fork and Fusion\n'
              '- **Twitter:** @forkandfusionapp',
            ),
            Gap(gap: 30),
          ],
        ),
      ),
    );
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch $emailUri';
    }
  }
}
