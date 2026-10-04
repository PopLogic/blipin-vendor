import 'package:blipin_vendor/utils/route_utils.dart';
import 'package:flutter/material.dart';

abstract class CreateFoodTruckViewModel extends ChangeNotifier {
  factory CreateFoodTruckViewModel.impl() = _CreateFoodTruckViewModelImpl;

  TextEditingController get nameController;
  TextEditingController get introductionController;
  TextEditingController get lineController;
  TextEditingController get instagramController;
  TextEditingController get facebookController;
  TextEditingController get otherSocialController;

  String? get businessType;
  int get logoCount;
  int get coverCount;
  int get galleryCount;
  bool get canContinue;

  void initialize();
  AppRoute? onSelectBusinessTypePressed();
  void onUploadLogoPressed();
  void onUploadCoverPressed();
  void onUploadGalleryPressed();
  AppRoute? onNextPressed();
}

class _CreateFoodTruckViewModelImpl extends ChangeNotifier
    implements CreateFoodTruckViewModel {
  _CreateFoodTruckViewModelImpl() {
    for (final controller in _controllers) {
      controller.addListener(_onInputChanged);
    }
  }

  @override
  final nameController = TextEditingController();
  @override
  final introductionController = TextEditingController();
  @override
  final lineController = TextEditingController();
  @override
  final instagramController = TextEditingController();
  @override
  final facebookController = TextEditingController();
  @override
  final otherSocialController = TextEditingController();

  String? _businessType;
  int _logoCount = 0;
  int _coverCount = 0;
  int _galleryCount = 0;

  List<TextEditingController> get _controllers => [
    nameController,
    introductionController,
    lineController,
    instagramController,
    facebookController,
    otherSocialController,
  ];

  @override
  String? get businessType => _businessType;
  @override
  int get logoCount => _logoCount;
  @override
  int get coverCount => _coverCount;
  @override
  int get galleryCount => _galleryCount;

  @override
  bool get canContinue =>
      nameController.text.trim().isNotEmpty &&
      introductionController.text.trim().isNotEmpty &&
      businessType != null &&
      logoCount > 0 &&
      coverCount > 0 &&
      galleryCount > 0;

  @override
  void initialize() {
    for (final controller in _controllers) {
      controller.clear();
    }
    _businessType = null;
    _logoCount = 0;
    _coverCount = 0;
    _galleryCount = 0;
    notifyListeners();
  }

  @override
  AppRoute? onSelectBusinessTypePressed() {
    // TODO: Return the business-type selection route when it exists.
    return null;
  }

  @override
  void onUploadLogoPressed() {
    // TODO: Open the image picker and update _logoCount after a successful upload.
  }

  @override
  void onUploadCoverPressed() {
    // TODO: Open the image picker and update _coverCount after a successful upload.
  }

  @override
  void onUploadGalleryPressed() {
    // TODO: Open the image picker and update _galleryCount after a successful upload.
  }

  @override
  AppRoute? onNextPressed() {
    if (!canContinue) return null;
    // TODO: Return the next food-truck setup route when it exists.
    return null;
  }

  void _onInputChanged() => notifyListeners();

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller
        ..removeListener(_onInputChanged)
        ..dispose();
    }
    super.dispose();
  }
}
