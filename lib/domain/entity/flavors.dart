enum Flavor {
  dev,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get appTitle {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Flap Boilerplate (Dev Flavor)';
      case Flavor.prod:
        return 'Flap Boilerplate (Prod Flavor)';
      default:
        return 'Flap Boilerplate';
    }
  }

  static String get baseUrlHost {
    switch (appFlavor) {
      case Flavor.dev:
        return 'api.spoonacular.com'; //replace this with staging api host
      case Flavor.prod:
        return 'api.spoonacular.com'; //replace this with production api host
      default:
        return 'api.spoonacular.com';
    }
  }
}
