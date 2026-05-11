import 'package:flutter/material.dart';
import 'package:blipin_vendor/pages/splash_page/entry_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const EntryPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      body: Center(
        child: BlipinLogo(size: LogoSize.large),
      ),
    );
  }
}

enum LogoSize { large, small }

class BlipinLogo extends StatelessWidget {
  final LogoSize size;
  const BlipinLogo({super.key, this.size = LogoSize.large});

  @override
  Widget build(BuildContext context) {
    final double imageWidth = size == LogoSize.large ? 200 : 140;
    return Image.asset(
      'assets/images/Default@1x.png',
      width: imageWidth,
      fit: BoxFit.contain,
    );
  }
}