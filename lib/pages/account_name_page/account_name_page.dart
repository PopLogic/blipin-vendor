import 'package:blipin_vendor/generated/app_localizations.dart';
import 'package:blipin_vendor/pages/legal_terms_page/legal_terms_page.dart';
import 'package:blipin_vendor/utils/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AccountNamePage extends HookWidget {
  const AccountNamePage({super.key});

  static Future<void> enterPage(BuildContext context) async {
    await RouteUtils.pushPage(context, const AccountNamePage());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = useTextEditingController();
    final focusNode = useFocusNode();
    useListenable(controller);
    final hasName = controller.text.trim().isNotEmpty;

    Future<void> finish() async {
      await LegalTermsPage.enterPage(context);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned.fill(child: _BrandMarkBackground()),
            Column(
              children: [
                SizedBox(
                  height: 72,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, size: 32),
                        onPressed: () => Navigator.maybePop(context),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: finish,
                        child: Text(
                          l10n.skipButton,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
                const _ProgressBar(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 74, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.accountNamePageTitle,
                          style: const TextStyle(
                            fontSize: 34,
                            height: 1.2,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 80),
                        Row(
                          children: [
                            Text(
                              l10n.accountNameLabel,
                              style: const TextStyle(fontSize: 18, height: 1.2),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              '*',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFFFF2E2E),
                              ),
                            ),
                            const Spacer(),
                            TextButton.icon(
                              onPressed: focusNode.requestFocus,
                              icon: const Icon(
                                Icons.add,
                                size: 18,
                                color: Color(0xFFFF6600),
                              ),
                              label: Text(
                                l10n.accountNameAddButton,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFFF6600),
                                ),
                              ),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: controller,
                          focusNode: focusNode,
                          maxLength: 150,
                          decoration: InputDecoration(
                            hintText: l10n.accountNameHint,
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              color: Color(0x9960606A),
                            ),
                            counterText: '',
                            filled: true,
                            fillColor: const Color(0xB3FFFFFF),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: Color(0xFFE0E0E0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: Color(0xFFFF6600),
                              ),
                            ),
                            suffixIcon: controller.text.isNotEmpty
                                ? IconButton(
                                    onPressed: controller.clear,
                                    tooltip: MaterialLocalizations.of(
                                      context,
                                    ).deleteButtonTooltip,
                                    icon: const Icon(
                                      Icons.cancel,
                                      size: 24,
                                      color: Color(0xFF545454),
                                    ),
                                  )
                                : null,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            l10n.accountNameCharacterCount(
                              controller.text.length,
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0x9960606A),
                            ),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: hasName ? finish : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFE0CC),
                              disabledBackgroundColor: const Color(0xFFFFE0CC),
                              foregroundColor: Colors.white,
                              shape: const StadiumBorder(),
                              elevation: 0,
                            ),
                            child: Text(
                              l10n.nextButton,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5,
      child: Row(
        children: [
          Expanded(flex: 2, child: Container(color: const Color(0xFFFF6600))),
          Expanded(flex: 1, child: Container(color: const Color(0xFFF2F2F4))),
        ],
      ),
    );
  }
}

class _BrandMarkBackground extends StatelessWidget {
  const _BrandMarkBackground();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _BrandMarkPainter());
  }
}

class _BrandMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFF4F4F4);
    final center = Offset(size.width * 0.96, size.height * 0.63);
    canvas.drawCircle(center, size.width * 0.40, paint);
    canvas.drawCircle(center, size.width * 0.18, Paint()..color = Colors.white);
    final stripe = Path()
      ..moveTo(size.width * 0.04, size.height)
      ..lineTo(size.width * 0.30, size.height * 0.70)
      ..quadraticBezierTo(
        size.width * 0.36,
        size.height * 0.63,
        size.width * 0.46,
        size.height * 0.63,
      )
      ..lineTo(size.width * 0.68, size.height * 0.63)
      ..lineTo(size.width * 0.68, size.height * 0.73)
      ..lineTo(size.width * 0.43, size.height * 0.73)
      ..quadraticBezierTo(
        size.width * 0.38,
        size.height * 0.73,
        size.width * 0.35,
        size.height * 0.78,
      )
      ..lineTo(size.width * 0.18, size.height)
      ..close();
    canvas.drawPath(stripe, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
