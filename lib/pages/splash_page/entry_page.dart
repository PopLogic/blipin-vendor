import 'package:flutter/material.dart';
import 'package:blipin_vendor/pages/splash_page/splash_page.dart';
import 'package:blipin_vendor/pages/quick_start_page/quick_start_page.dart';
import 'package:blipin_vendor/generated/app_localizations.dart';
import 'package:blipin_vendor/utils/route_utils.dart';

class EntryPage extends StatelessWidget {
  const EntryPage({super.key});

  static Future<void> enterPage(BuildContext context, {bool replaceCurrent = false}) async {
    final page = const EntryPage();
    if (replaceCurrent) {
      await RouteUtils.replaceWithPage(context, page);
      return;
    }
    await RouteUtils.pushPage(context, page);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 48),
            // Logo at top
            BlipinLogo(size: LogoSize.small),
            // City silhouette + truck in the middle (expanded)
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // City buildings silhouette
                  Positioned.fill(
                    child: CustomPaint(painter: _CityPainter()),
                  ),
                  // Truck + pin icon centered
                  Center(
                    child: SizedBox(
                      width: 72,
                      height: 72,
                      child: Stack(
                        alignment: Alignment.center,
                        children: const [
                          Icon(Icons.location_on, color: Colors.white, size: 72),
                          Positioned(
                            bottom: 4,
                            left: 4,
                            child: Icon(
                              Icons.local_shipping,
                              color: Color(0xFFE07820),
                              size: 38,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    QuickStartPage.enterPage(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE07820),
                    shape: StadiumBorder(),
                    elevation: 0,
                  ),
                  child: Text(
                    l10n.entryPageStartButton,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
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

class _CityPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2A2A2A)
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // Draw stylized building silhouettes
    void drawBuilding(double x, double bw, double bh) {
      final rect = Rect.fromLTWH(x, h - bh, bw, bh);
      canvas.drawRect(rect, paint);
    }

    void drawBuildingWithWindows(double x, double bw, double bh) {
      drawBuilding(x, bw, bh);
      final windowPaint = Paint()
        ..color = const Color(0xFF333333)
        ..style = PaintingStyle.fill;
      for (double wy = h - bh + 12; wy < h - 16; wy += 20) {
        for (double wx = x + 8; wx < x + bw - 10; wx += 18) {
          canvas.drawRect(Rect.fromLTWH(wx, wy, 8, 10), windowPaint);
        }
      }
    }

    // Background buildings (left side)
    drawBuildingWithWindows(0, w * 0.18, h * 0.55);
    drawBuildingWithWindows(w * 0.14, w * 0.12, h * 0.40);
    drawBuildingWithWindows(w * 0.22, w * 0.10, h * 0.65);

    // Background buildings (right side)
    drawBuildingWithWindows(w * 0.70, w * 0.14, h * 0.50);
    drawBuildingWithWindows(w * 0.80, w * 0.10, h * 0.38);
    drawBuildingWithWindows(w * 0.86, w * 0.14, h * 0.60);

    // Road at bottom
    final roadPaint = Paint()
      ..color = const Color(0xFF252525)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, h - 30, w, 30), roadPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}