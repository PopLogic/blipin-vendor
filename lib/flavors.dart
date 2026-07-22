import 'package:flutter/services.dart';

enum Flavor {
  development,
  staging,
  production,
  ;

  static Flavor currentFlavor() {

    switch (appFlavor) {
      case 'development':
        return Flavor.development;
      case 'staging':
        return Flavor.staging;
      case 'production':
        return Flavor.production;
      default:
        return Flavor.production;
    }
  }
}

class F {
  static final Flavor appFlavor = Flavor.currentFlavor();

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.development:
        return 'Blipin Vendor Dev';
      case Flavor.staging:
        return 'Blipin Vendor Stg';
      case Flavor.production:
        return 'Blipin Vendor';
    }
  }

  static String get appIcon {
    switch (appFlavor) {
      case Flavor.development:
        return 'assets/development/app-icon.png';
      case Flavor.staging:
        return 'assets/staging/app-icon.png';
      case Flavor.production:
        return 'assets/production/app-icon.png';
    }
  }

}
