import 'dart:ui';

import 'package:blipin_vendor/generated/app_localizations.dart';
import 'package:blipin_vendor/pages/create_food_truck_page/create_food_truck_page.dart';
import 'package:flutter/material.dart';

class LauncherPage extends StatelessWidget {
  const LauncherPage({super.key, this.onCreateTruck});

  final VoidCallback? onCreateTruck;

  static Future<void> enterPage(
    BuildContext context, {
    bool replaceCurrent = false,
    bool clearStack = false,
  }) async {
    final route = MaterialPageRoute<void>(builder: (_) => const LauncherPage());
    if (clearStack) {
      await Navigator.pushAndRemoveUntil(context, route, (_) => false);
      return;
    }
    if (replaceCurrent) {
      await Navigator.pushReplacement(context, route);
      return;
    }
    await Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned.fill(child: _ScheduleHomeBackground()),
            Positioned.fill(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: ColoredBox(color: Colors.white.withValues(alpha: 0.5)),
                ),
              ),
            ),
            Positioned(
              top: 24,
              left: 20,
              right: 20,
              child: _CreateTruckAlert(
                onPressed:
                    onCreateTruck ??
                    () => CreateFoodTruckPage.enterPage(context),
                l10n: l10n,
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Center(child: _BottomNavigation()),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateTruckAlert extends StatelessWidget {
  const _CreateTruckAlert({required this.onPressed, required this.l10n});

  final VoidCallback onPressed;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final checklistItems = [
      l10n.homeTruckName,
      l10n.homeTruckIntroduction,
      l10n.homeTruckBusinessType,
      l10n.homeSocialLinks,
      l10n.homeBrandLogo,
      l10n.homeBrandCover,
      l10n.homeTruckPhotos,
    ];

    return SizedBox(
      height: 388,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFFFC299)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
          child: Column(
            children: [
              SizedBox(
                height: 110,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 48,
                          height: 48,
                          child: CustomPaint(painter: _TruckPainter()),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.homeCreateFirstTruckTitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  height: 1.2,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                l10n.homeCreateFirstTruckSubtitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xFF8C8C90),
                                  fontSize: 16,
                                  height: 1.5,
                                  letterSpacing: 0.64,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        key: const Key('create-truck-button'),
                        onPressed: onPressed,
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: EdgeInsets.zero,
                          backgroundColor: const Color(0xFFFF6600),
                          foregroundColor: Colors.white,
                          shape: const StadiumBorder(),
                        ),
                        child: Text(
                          l10n.homeCreateTruckButton,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.2,
                            letterSpacing: 0.64,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Column(
                  children: [
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(0x1F000000),
                    ),
                    const SizedBox(height: 15),
                    ...checklistItems.indexed.map(
                      (entry) => Padding(
                        padding: EdgeInsets.only(
                          bottom: entry.$1 == checklistItems.length - 1 ? 0 : 8,
                        ),
                        child: _ChecklistItem(label: entry.$2),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChecklistItem extends StatelessWidget {
  const _ChecklistItem({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: const BoxDecoration(
              color: Color(0xFFE5E5E7),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, size: 12, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _TruckPainter extends CustomPainter {
  const _TruckPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const orange = Color(0xFFFF7A33);
    final paint = Paint()..color = orange;
    final scaleX = size.width / 48;
    final scaleY = size.height / 48;
    canvas.save();
    canvas.scale(scaleX, scaleY);

    final body = Path()
      ..moveTo(1, 31)
      ..lineTo(1, 22)
      ..lineTo(8, 10)
      ..quadraticBezierTo(9.5, 8, 12, 8)
      ..lineTo(39, 8)
      ..quadraticBezierTo(47, 8, 47, 17)
      ..lineTo(47, 31)
      ..quadraticBezierTo(47, 34, 44, 34)
      ..lineTo(42, 34)
      ..quadraticBezierTo(40.5, 28, 35, 28)
      ..quadraticBezierTo(29.5, 28, 28, 34)
      ..lineTo(18, 34)
      ..quadraticBezierTo(16.5, 28, 11, 28)
      ..quadraticBezierTo(5.5, 28, 4, 34)
      ..quadraticBezierTo(1, 34, 1, 31)
      ..close();
    canvas.drawPath(body, paint);

    final window = Path()
      ..moveTo(11, 11)
      ..lineTo(19, 11)
      ..lineTo(19, 22)
      ..lineTo(5.5, 22)
      ..lineTo(11, 11)
      ..close();
    canvas.drawPath(window, Paint()..color = Colors.white);

    canvas.drawCircle(const Offset(11, 35), 5, paint);
    canvas.drawCircle(const Offset(35, 35), 5, paint);
    canvas.drawCircle(const Offset(11, 35), 3.5, Paint()..color = Colors.white);
    canvas.drawCircle(const Offset(35, 35), 3.5, Paint()..color = Colors.white);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SizedBox(
      width: 222,
      height: 60,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0x1F2B2B2B),
          border: Border.all(color: const Color(0xFFE8E8E8)),
          borderRadius: BorderRadius.circular(99),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Row(
            children: [
              _NavigationItem(
                icon: Icons.calendar_month_outlined,
                label: l10n.homeScheduleTab,
                selected: true,
              ),
              const SizedBox(width: 6),
              _NavigationItem(
                icon: Icons.menu_book_outlined,
                label: l10n.homeMenuTab,
              ),
              const SizedBox(width: 6),
              _NavigationItem(
                icon: Icons.bar_chart_outlined,
                label: l10n.homeDataTab,
              ),
              const SizedBox(width: 6),
              _NavigationItem(
                icon: Icons.person_outline,
                label: l10n.homeProfileTab,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.icon,
    required this.label,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final color = selected ? const Color(0xFFFF6600) : const Color(0xFF858589);
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: selected ? Colors.white : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 1,
            style: TextStyle(color: color, fontSize: 11, height: 1.2),
          ),
        ],
      ),
    );
  }
}

class _ScheduleHomeBackground extends StatelessWidget {
  const _ScheduleHomeBackground();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 19),
          child: Row(
            children: [
              _TopTab(label: l10n.homeCurrentScheduleTab, selected: true),
              const SizedBox(width: 32),
              _TopTab(label: l10n.homeTodayScheduleTab),
              const Spacer(),
              const Icon(
                Icons.calendar_month_outlined,
                size: 24,
                color: Color(0xFF333333),
              ),
            ],
          ),
        ),
        Container(
          height: 174,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0x33787878)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    l10n.homeClosed,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 61,
                    height: 26,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6E6E6),
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                ],
              ),
              const Divider(height: 25),
              Row(
                children: [
                  Text(l10n.homeBusinessInformation),
                  const SizedBox(width: 8),
                  const Icon(Icons.edit_outlined, size: 20),
                  const Spacer(),
                  const Text('--'),
                ],
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Icon(Icons.access_time_filled, size: 20),
                  SizedBox(width: 8),
                  Text('--'),
                ],
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Icon(Icons.location_on, size: 20),
                  SizedBox(width: 8),
                  Text('--'),
                  Spacer(),
                  Icon(Icons.my_location, size: 20),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ColoredBox(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  l10n.homeSaleItems,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TopTab extends StatelessWidget {
  const _TopTab({required this.label, this.selected = false});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 7),
        Container(
          width: 44,
          height: 3,
          color: selected ? const Color(0xFFFF6600) : Colors.transparent,
        ),
      ],
    );
  }
}
