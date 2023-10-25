import 'package:flap_app/domain/entity/flavors.dart';
import 'package:flap_app/domain/repository/flavor/flavor_repository.dart';

class FlavorRepositoryImpl extends FlavorRepository {
  final F flavor;

  FlavorRepositoryImpl({required this.flavor});

  @override
  String getAppTitle() {
    return F.appTitle;
  }

  @override
  String getFlavorName() {
    return F.name;
  }

  @override
  String getBaseUrlHost() {
    return F.baseUrlHost;
  }
}
