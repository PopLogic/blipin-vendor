import 'package:blipin_vendor/pages/splash_page/entry_page.dart';
import 'package:blipin_vendor/utils/route_utils.dart';
import 'package:flutter/material.dart';

class CreateMenuSuccessPage extends StatelessWidget {
  const CreateMenuSuccessPage({super.key});

  static Future<void> enterPage(BuildContext context) async {
    await RouteUtils.pushPage(context, const CreateMenuSuccessPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 56,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.maybePop(context),
                    ),
                  ),
                  const Text(
                    '建立菜單',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: const [
                      Icon(Icons.local_shipping_outlined, size: 86, color: Color(0xFF5A5A5A)),
                      Icon(Icons.verified, size: 30, color: Color(0xFFFF6A00)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    '創建成功！',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    EntryPage.enterPage(context, replaceCurrent: true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6A00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    '前往首頁',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
