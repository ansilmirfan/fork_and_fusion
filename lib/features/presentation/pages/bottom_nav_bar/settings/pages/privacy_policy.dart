import 'package:flutter/material.dart';
import 'package:fork_and_fusion/features/presentation/widgets/gap.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(gap: 20),
            const Text(
              'Effective Date: October 10, 2024',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            const Text(
              'This Privacy Policy explains how Fork and Fusion ("we," "our," or "us") collects, uses, and shares '
              'information about you when you use our mobile application (the “App”) and related services.',
            ),
            Gap(gap: 20),
            const Text(
              '1. Information We Collect',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            const Text(
              'A. Information You Provide:\n- Account Information: We collect your name, email address, and necessary information '
              'when you sign up or log in.\n- Order Information: We collect information about the items you purchase and your preferences.',
            ),
            Gap(gap: 10),
            const Text(
              'B. Automatically Collected Information:\n- Device Information: We collect information about the device you use to access the App.\n'
              '- Location Information: With your consent, we collect your location information to improve the user experience.\n'
              '- Usage Data: We track your interactions with the App, such as items viewed, clicks, and pages visited.',
            ),
            Gap(gap: 20),
            const Text(
              '2. How We Use Your Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(gap: 20),
            const Text(
              'We use the information we collect for the following purposes:\n'
              '- To provide services, such as processing orders and maintaining your account.\n'
              '- For user authentication to securely log you in through email or Google sign-in options.\n'
              '- To improve the App by analyzing usage data.\n'
              '- For marketing purposes, like sending promotional emails or notifications with your consent.',
            ),
            Gap(gap: 20),
            const Text(
              '3. Sharing Your Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            const Text(
              'We do not sell or rent your personal information. However, we may share your information with:\n'
              '- Service Providers who help us operate the App, like payment processors.\n'
              '- Legal authorities when required by law.',
            ),
            Gap(gap: 20),
            const Text(
              '4. Data Security',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            const Text(
              'We implement security measures such as encrypted communication and secure storage to protect your information.',
            ),
            Gap(gap: 20),
            const Text(
              '5. Your Choices',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            const Text(
              'You can update your account information, opt-out of promotional communications, or request data deletion at any time by contacting us.',
            ),
            Gap(gap: 20),
            const Text(
              '6. Third-Party Links and Services',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            const Text(
              'Our App may contain links to third-party websites or services. We encourage you to review their privacy policies.',
            ),
            Gap(gap: 20),
            const Text(
              '7. Children’s Privacy',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            const Text(
              'We do not knowingly collect information from individuals under the age of 13. If we find out we have collected such information, we will take steps to delete it.',
            ),
            Gap(gap: 20),
            const Text(
              '8. Changes to This Privacy Policy',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            const Text(
              'We may update this Privacy Policy from time to time. The "Effective Date" will be updated accordingly.',
            ),
            Gap(gap: 20),
            const Text(
              '9. Contact Us',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            const Text(
              'If you have any questions or concerns, please contact us at ansilmirfan123@gmail.com.',
            ),
            Gap(gap: 30),
          ],
        ),
      ),
    );
  }
}
