import 'package:flap_app/util/flavor/flavor.dart';
import 'package:flap_app/util/flavor/flavor_config.dart';

import 'main.dart' as runner;

Future<void> main() async {
  FlavorConfig.flavor = Flavor.mock;
  await runner.main();
}
