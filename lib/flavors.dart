enum Flavor {
  development,
  staging,
  production,
}

class F {
  static late final Flavor appFlavor;

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

}
