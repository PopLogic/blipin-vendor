import 'package:blipin_vendor/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PrivacyPolicyPage extends HookWidget {
  const PrivacyPolicyPage({super.key});

  static Future<bool?> enterPage(BuildContext context) async {
    return Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const PrivacyPolicyPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scrollController = useScrollController();
    final canAgree = useState(false);

    useEffect(() {
      void updateScrollState() {
        if (!scrollController.hasClients) return;
        final isAtEnd =
            scrollController.position.maxScrollExtent <= 0 ||
            scrollController.position.pixels >=
                scrollController.position.maxScrollExtent - 24;
        if (canAgree.value != isAtEnd) canAgree.value = isAtEnd;
      }

      scrollController.addListener(updateScrollState);
      WidgetsBinding.instance.addPostFrameCallback((_) => updateScrollState());
      return () => scrollController.removeListener(updateScrollState);
    }, [scrollController]);

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
                        l10n.privacyPolicyPageTitle,
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
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(18, 42, 18, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.privacyPolicyPageTitle,
                      style: const TextStyle(
                        fontSize: 22,
                        height: 1.2,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E1E1E),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      l10n.privacyPolicyContent,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.35,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: canAgree.value
                      ? () => Navigator.pop(context, true)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6600),
                    disabledBackgroundColor: const Color(0xFFFFE0CC),
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                    elevation: 0,
                  ),
                  child: Text(
                    l10n.privacyPolicyAgreeButton,
                    style: const TextStyle(fontSize: 18),
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

class _ProgressBar extends StatelessWidget {
  const _ProgressBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5,
      child: Row(
        children: [
          Expanded(flex: 5, child: Container(color: const Color(0xFFFF6600))),
          Expanded(child: Container(color: const Color(0xFFF2F2F4))),
        ],
      ),
    );
  }
}
