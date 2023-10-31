import 'package:flap_app/util/flavor/flavor_config.dart';
import 'package:flap_app/util/flavor/flavor.dart';

import 'main.dart' as runner;

Future<void> main() async {
  FlavorConfig.flavor = Flavor.prod;
  await runner.main();
}