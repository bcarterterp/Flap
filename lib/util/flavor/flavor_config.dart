import 'package:flap_app/util/flavor/flavor.dart';

class FlavorConfig {
  //default flavor will be dev
  static Flavor flavor = Flavor.dev;

  static String get flavorName => flavor.name;

  static String get appTitle {
    switch (flavor) {
      case Flavor.dev:
        return 'Flap Boilerplate (Dev Flavor)';
      case Flavor.prod:
        return 'Flap Boilerplate (Prod Flavor)';
    }
  }

  static String get baseUrlHost {
    switch (flavor) {
      case Flavor.dev:
        return 'api.spoonacular.com'; //replace this with staging api host
      case Flavor.prod:
        return 'api.spoonacular.com'; //replace this with production api host
    }
  }
}
