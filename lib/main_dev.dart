import 'package:flap_app/my_app.dart';
import 'package:flap_app/presentation/navigation.dart';
import 'package:flap_app/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  FlavorConfig(name: "dev", location: BannerLocation.topEnd, variables: {
    "appTitle": "Boiler Plate - Dev Flavor",
    "baseUrlHost": "api.spoonacular.com" //replace this baseUrl host used for your staging API
  });
  runApp(const ProviderScope(child: MyApp()));
}