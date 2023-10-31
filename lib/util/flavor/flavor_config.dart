import 'package:flap_app/util/flavor/flavor.dart';

class FlavorConfig {
  static Flavor? flavor;

  static String get flavorName => flavor?.name ?? '';

  static String get appTitle {
    switch (flavor) {
      case Flavor.dev:
        return 'Flap Boilerplate (Dev Flavor)';
      case Flavor.prod:
        return 'Flap Boilerplate (Prod Flavor)';
      default:
        return 'Flap Boilerplate';
    }
  }

  static String get baseUrlHost {
    switch (flavor) {
      case Flavor.dev:
        return 'api.spoonacular.com'; //replace this with staging api host
      case Flavor.prod:
        return 'api.spoonacular.com'; //replace this with production api host
      default:
        return 'api.spoonacular.com';
    }
  }
}
