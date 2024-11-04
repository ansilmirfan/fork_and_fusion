import 'package:flutter/material.dart';
import 'package:fork_and_fusion/features/presentation/widgets/gap.dart';

class TermsOfService extends StatelessWidget {
  const TermsOfService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms of Service')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms of Service',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(gap: 20),
            Text(
              'Effective Date: October 10, 2024',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            Text(
              'These Terms of Service ("Terms") govern your use of the Fork and Fusion mobile application (the "App") and '
              'the services provided through the App. By using the App, you agree to these Terms.',
            ),
            Gap(gap: 20),
            Text(
              '1. Use of the App',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            Text(
              'You may use the App for personal purposes, including browsing the menu, placing orders, and managing your account. '
              'You agree to use the App in compliance with applicable laws and not for any illegal activities.',
            ),
            Gap(gap: 20),
            Text(
              '2. User Accounts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            Text(
              'To use certain features of the App, such as placing an order, you must create an account. You are responsible for '
              'keeping your login credentials secure and notifying us immediately if you suspect unauthorized access.',
            ),
            Gap(gap: 20),
            Text(
              '3. Orders and Payments',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            Text(
              'When placing an order through the App, you agree to provide accurate information and pay for the items as specified. '
              'We reserve the right to cancel any order if payment is not processed or if there are issues with availability.',
            ),
            Gap(gap: 20),
            Text(
              '4. Intellectual Property',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            Text(
              'All content provided in the App, including images, text, and logos, is the intellectual property of Fork and Fusion '
              'or its licensors. You may not copy, modify, or distribute any content without our permission.',
            ),
            Gap(gap: 20),
            Text(
              '5. Limitation of Liability',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            Text(
              'To the maximum extent permitted by law, Fork and Fusion is not liable for any indirect, incidental, or consequential damages '
              'arising from your use of the App or any service provided through it.',
            ),
            Gap(gap: 20),
            Text(
              '6. Termination',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            Text(
              'We reserve the right to terminate or suspend your account or access to the App at any time, without notice, if you violate '
              'these Terms or engage in unlawful behavior.',
            ),
            Gap(gap: 20),
            Text(
              '7. Changes to the Terms',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            Text(
              'We may update these Terms from time to time. The "Effective Date" will be updated accordingly, and we recommend that you '
              'review these Terms periodically.',
            ),
            Gap(gap: 20),
            Text(
              '8. Governing Law',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            Text(
              'These Terms are governed by and construed in accordance with the laws of the jurisdiction in which Fork and Fusion operates.',
            ),
            Gap(gap: 20),
            Text(
              '9. Contact Us',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            Text(
              'If you have any questions or concerns about these Terms, please contact us at ansilmirfan123@gmail.com.',
            ),
            Gap(gap: 30),
          ],
        ),
      ),
    );
  }
}
