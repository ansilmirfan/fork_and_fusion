import 'package:flutter/material.dart';
import 'package:fork_and_fusion/features/presentation/widgets/gap.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About the App')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Fork and Fusion',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(gap: 20),
            Text(
              'Fork and Fusion is a seamless dining app designed to enhance your restaurant experience. Whether you’re craving delicious meals or just a quick snack, our app offers you the convenience of browsing menus, placing orders, and making payments directly from your table.',
            ),
            Gap(gap: 20),
            Text(
              'Key Features',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            Text(
              '- **QR Code Ordering:** Simply scan the QR code on your table to view the full menu, make your selections, and place an order without needing to call the waiter.\n'
              '- **Personalized Recommendations:** Based on your previous orders and preferences, Fork and Fusion suggests dishes you might enjoy.\n'
              '- **Secure Payments:** Pay directly through the app using secure payment gateways, ensuring your transactions are safe.\n'
              '- **Order Tracking:** Easily track the status of your order, from preparation to delivery to your table.',
            ),
            Gap(gap: 20),
            Text(
              'Our Mission',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            Text(
              'At Fork and Fusion, we aim to bridge the gap between convenience and quality dining. Our goal is to make restaurant ordering efficient, engaging, and personalized, allowing you to focus on enjoying your meal and company.',
            ),
            Gap(gap: 20),
            Text(
              'Why Choose Fork and Fusion?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            Text(
              "With Fork and Fusion, your dining experience is elevated through intuitive technology. No more waiting to flag down a waiter or wondering about the status of your food. Our app brings everything you need to your fingertips—whether you're dining in or ordering to go.",
            ),
            Gap(gap: 20),
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(gap: 10),
            Text(
              'Have any feedback, suggestions, or need help? Feel free to reach out to us at ansilmirfan123@gmail.com.',
            ),
            Gap(gap: 30),
          ],
        ),
      ),
    );
  }
}
