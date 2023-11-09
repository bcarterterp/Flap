import 'package:flap_app/domain/repository/flavor/flavor_repository.dart';
import 'package:flap_app/util/flavor/flavor_config.dart';

class FlavorRepositoryImpl extends FlavorRepository {
  FlavorRepositoryImpl();

  @override
  String getAppTitle() {
    return FlavorConfig.appTitle;
  }

  @override
  String getFlavorName() {
    return FlavorConfig.flavorName;
  }

  @override
  String getBaseUrlHost() {
    return FlavorConfig.baseUrlHost;
  }
}