import 'package:blipin_vendor/generated/app_localizations.dart';
import 'package:blipin_vendor/utils/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'create_food_truck_view_model.dart';

class CreateFoodTruckPage extends HookWidget {
  const CreateFoodTruckPage({super.key, required this.vm});

  final CreateFoodTruckViewModel vm;

  static Future<void> enterPage(BuildContext context) async {
    final vm = CreateFoodTruckViewModel.impl();
    vm.initialize();
    await RouteUtils.pushPage(context, CreateFoodTruckPage(vm: vm));
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      return vm.dispose;
    }, [vm]);
    useListenable(vm);
    final l10n = AppLocalizations.of(context)!;

    Future<void> navigate(AppRoute? route) async {
      if (route != null) {
        await RouteUtils.navigate(context, route);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          key: const Key('create-food-truck-back-button'),
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back, size: 28, color: Colors.black),
        ),
        title: Text(
          l10n.createFoodTruckTitle,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            height: 1.2,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionTitle(l10n.foodTruckInformationSection),
              const SizedBox(height: 24),
              _FormLabel(text: l10n.foodTruckNameLabel, required: true),
              const SizedBox(height: 8),
              _OutlinedTextField(
                key: const Key('food-truck-name-field'),
                controller: vm.nameController,
                hintText: l10n.foodTruckNameHint,
                maxLength: 150,
              ),
              const SizedBox(height: 24),
              _FormLabel(text: l10n.foodTruckIntroductionLabel, required: true),
              const SizedBox(height: 8),
              _OutlinedTextField(
                key: const Key('food-truck-introduction-field'),
                controller: vm.introductionController,
                hintText: l10n.foodTruckIntroductionHint,
                maxLength: 150,
                minLines: 2,
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              _FormLabel(text: l10n.foodTruckBusinessTypeLabel, required: true),
              const SizedBox(height: 8),
              _SelectionField(
                key: const Key('food-truck-business-type-field'),
                hintText: l10n.foodTruckBusinessTypeHint,
                value: vm.businessType,
                onTap: () => navigate(vm.onSelectBusinessTypePressed()),
              ),
              const SizedBox(height: 40),
              _SectionTitle(l10n.foodTruckBrandInformationSection),
              const SizedBox(height: 24),
              _FormLabel(text: l10n.foodTruckSocialLabel),
              const SizedBox(height: 8),
              _SocialTextField(
                controller: vm.lineController,
                icon: _SocialIcon.line,
                hintText: l10n.foodTruckLineHint,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 8),
              _SocialTextField(
                controller: vm.instagramController,
                icon: _SocialIcon.instagram,
                hintText: l10n.foodTruckInstagramHint,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 8),
              _SocialTextField(
                controller: vm.facebookController,
                icon: _SocialIcon.facebook,
                hintText: l10n.foodTruckFacebookHint,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 8),
              _SocialTextField(
                controller: vm.otherSocialController,
                icon: _SocialIcon.web,
                hintText: l10n.foodTruckOtherSocialHint,
              ),
              const SizedBox(height: 28),
              _UploadHeading(
                label: l10n.foodTruckBrandLogoLabel,
                required: true,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.foodTruckUploadRule,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const _LogoPlaceholder(),
                  const SizedBox(width: 16),
                  _UploadButton(
                    key: const Key('upload-food-truck-logo-button'),
                    label: l10n.foodTruckUploadLogoButton,
                    onPressed: vm.onUploadLogoPressed,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              _UploadHeading(
                label: l10n.foodTruckBrandCoverLabel,
                required: true,
                count: l10n.foodTruckCoverCount(vm.coverCount),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.foodTruckUploadRule,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 16),
              _CoverPlaceholder(
                buttonLabel: l10n.foodTruckUploadCoverButton,
                onPressed: vm.onUploadCoverPressed,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.foodTruckCoverDescription,
                style: const TextStyle(
                  color: Color(0xFF99999E),
                  fontSize: 12,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 40),
              _UploadHeading(
                label: l10n.foodTruckGalleryLabel,
                required: true,
                count: l10n.foodTruckGalleryCount(vm.galleryCount),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.foodTruckUploadRule,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 16),
              _GalleryPlaceholder(onPressed: vm.onUploadGalleryPressed),
              const SizedBox(height: 164),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  key: const Key('create-food-truck-next-button'),
                  onPressed: vm.canContinue
                      ? () => navigate(vm.onNextPressed())
                      : null,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xFFFF6600),
                    disabledBackgroundColor: const Color(0xFFFFE0CC),
                    foregroundColor: Colors.white,
                    disabledForegroundColor: Colors.white,
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    l10n.nextButton,
                    style: const TextStyle(fontSize: 18, height: 1.2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        height: 1.2,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _FormLabel extends StatelessWidget {
  const _FormLabel({required this.text, this.required = false});

  final String text;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFF858589),
            fontSize: 14,
            height: 1.2,
          ),
        ),
        if (required) ...[
          const SizedBox(width: 4),
          const Text(
            '*',
            style: TextStyle(color: Color(0xFFFF2E2E), fontSize: 14),
          ),
        ],
      ],
    );
  }
}

class _OutlinedTextField extends StatelessWidget {
  const _OutlinedTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.maxLength,
    this.minLines = 1,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String hintText;
  final int maxLength;
  final int minLines;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      textInputAction: maxLines > 1
          ? TextInputAction.newline
          : TextInputAction.next,
      decoration: _fieldDecoration(hintText).copyWith(
        counterText: '${controller.text.length}/$maxLength',
        counterStyle: const TextStyle(
          color: Color(0xFF99999E),
          fontSize: 12,
          height: 1.2,
        ),
      ),
    );
  }
}

class _SelectionField extends StatelessWidget {
  const _SelectionField({
    super.key,
    required this.hintText,
    required this.onTap,
    this.value,
  });

  final String hintText;
  final String? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: InputDecorator(
          decoration: _fieldDecoration(hintText),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value ?? hintText,
                  style: TextStyle(
                    color: value == null
                        ? const Color(0xFF99999E)
                        : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                size: 28,
                color: Color(0xFF333333),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

InputDecoration _fieldDecoration(String hintText) {
  const borderColor = Color(0xFFE5E5E7);
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: borderColor),
  );
  return InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(color: Color(0xFF99999E), fontSize: 16),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    enabledBorder: border,
    focusedBorder: border.copyWith(
      borderSide: const BorderSide(color: Color(0xFFFF6600)),
    ),
    disabledBorder: border,
  );
}

enum _SocialIcon { line, instagram, facebook, web }

class _SocialTextField extends StatelessWidget {
  const _SocialTextField({
    required this.controller,
    required this.icon,
    required this.hintText,
    this.textInputAction = TextInputAction.done,
  });

  final TextEditingController controller;
  final _SocialIcon icon;
  final String hintText;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.url,
        textInputAction: textInputAction,
        decoration: _fieldDecoration(hintText).copyWith(
          prefixIcon: SizedBox(
            width: 48,
            child: Center(child: _SocialIconView(icon)),
          ),
        ),
      ),
    );
  }
}

class _SocialIconView extends StatelessWidget {
  const _SocialIconView(this.icon);

  final _SocialIcon icon;

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFFC9C9CD);
    switch (icon) {
      case _SocialIcon.line:
        return Container(
          width: 19,
          height: 19,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: color, width: 1.5),
            shape: BoxShape.circle,
          ),
          child: const Text(
            'LINE',
            style: TextStyle(color: color, fontSize: 5, height: 1),
          ),
        );
      case _SocialIcon.instagram:
        return const Icon(Icons.camera_alt_outlined, color: color, size: 21);
      case _SocialIcon.facebook:
        return const Text(
          'f',
          style: TextStyle(
            color: color,
            fontSize: 24,
            height: 1,
            fontWeight: FontWeight.w700,
          ),
        );
      case _SocialIcon.web:
        return const Icon(Icons.language, color: color, size: 21);
    }
  }
}

class _UploadHeading extends StatelessWidget {
  const _UploadHeading({
    required this.label,
    this.required = false,
    this.count,
  });

  final String label;
  final bool required;
  final String? count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _FormLabel(text: label, required: required),
        const Spacer(),
        if (count != null)
          Text(
            count!,
            style: const TextStyle(color: Color(0xFF99999E), fontSize: 16),
          ),
      ],
    );
  }
}

class _UploadButton extends StatelessWidget {
  const _UploadButton({super.key, required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed ?? () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF333333),
        side: const BorderSide(color: Color(0xFFE0E0E2)),
        minimumSize: const Size(0, 48),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const StadiumBorder(),
      ),
      icon: const Icon(Icons.camera_alt, size: 20),
      label: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }
}

class _LogoPlaceholder extends StatelessWidget {
  const _LogoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 108,
      height: 108,
      decoration: const BoxDecoration(
        color: Color(0xFFF1F1F2),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.add_location_alt_outlined,
        size: 56,
        color: Color(0xFFC9C9CD),
      ),
    );
  }
}

class _CoverPlaceholder extends StatelessWidget {
  const _CoverPlaceholder({required this.buttonLabel, this.onPressed});

  final String buttonLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 248,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: _UploadButton(
        key: const Key('upload-food-truck-cover-button'),
        label: buttonLabel,
        onPressed: onPressed,
      ),
    );
  }
}

class _GalleryPlaceholder extends StatelessWidget {
  const _GalleryPlaceholder({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: const Key('upload-food-truck-gallery-button'),
      onTap: onPressed ?? () {},
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 118,
        height: 118,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: const Color(0xFFB8B8BC),
            style: BorderStyle.solid,
          ),
        ),
        child: const Icon(
          Icons.add_photo_alternate_outlined,
          size: 34,
          color: Color(0xFFC9C9CD),
        ),
      ),
    );
  }
}
