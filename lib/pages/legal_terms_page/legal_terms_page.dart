import 'package:blipin_vendor/generated/app_localizations.dart';
import 'package:blipin_vendor/pages/create_menu_success_page/create_menu_success_page.dart';
import 'package:blipin_vendor/utils/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LegalTermsPage extends HookWidget {
  const LegalTermsPage({super.key});

  static Future<void> enterPage(BuildContext context) async {
    await RouteUtils.pushPage(context, const LegalTermsPage());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final acceptedPrivacy = useState(false);
    final acceptedService = useState(false);
    final canContinue = acceptedPrivacy.value && acceptedService.value;

    Future<void> finish() async {
      if (canContinue) {
        await CreateMenuSuccessPage.enterPage(context);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 46,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, size: 32),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        l10n.legalTermsTitle,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: Colors.black,
                    ),
                    label: Text(
                      l10n.skipButton,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            const _ProgressBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 68, 40, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        style: const TextStyle(
                          fontSize: 22,
                          height: 1.3,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(text: l10n.legalTermsIntro),
                          TextSpan(
                            text: l10n.serviceAgreementLink,
                            style: const TextStyle(color: Color(0xFFFF6600)),
                          ),
                          TextSpan(text: l10n.legalTermsSeparator),
                          TextSpan(
                            text: l10n.privacyPolicyLink,
                            style: const TextStyle(color: Color(0xFFFF6600)),
                          ),
                          TextSpan(text: l10n.legalTermsOutro),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    _TermsCard(
                      title: l10n.privacyPolicyLink,
                      selected: acceptedPrivacy.value,
                      onTap: () =>
                          acceptedPrivacy.value = !acceptedPrivacy.value,
                      onOpen: () {},
                    ),
                    const SizedBox(height: 16),
                    _TermsCard(
                      title: l10n.serviceAgreementLink,
                      selected: acceptedService.value,
                      onTap: () =>
                          acceptedService.value = !acceptedService.value,
                      onOpen: () {},
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: canContinue ? finish : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6600),
                          disabledBackgroundColor: const Color(0xFFFFE0CC),
                          foregroundColor: Colors.white,
                          shape: const StadiumBorder(),
                          elevation: 0,
                        ),
                        child: Text(
                          l10n.agreeTermsButton,
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
      ),
    );
  }
}

class _TermsCard extends StatelessWidget {
  const _TermsCard({
    required this.title,
    required this.selected,
    required this.onTap,
    required this.onOpen,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              IconButton(
                onPressed: onOpen,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                icon: const Icon(
                  Icons.open_in_new,
                  size: 20,
                  color: Color(0xFFFF6600),
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.check_circle,
                size: 24,
                color: selected
                    ? const Color(0xFFFF6600)
                    : const Color(0xFFE5E5E5),
              ),
            ],
          ),
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
          Expanded(child: Container(color: const Color(0xFFFF6600))),
          Expanded(child: Container(color: const Color(0xFFF2F2F4))),
        ],
      ),
    );
  }
}
