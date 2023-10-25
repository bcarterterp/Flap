import 'package:flap_app/my_app.dart';
import 'package:flap_app/presentation/navigation.dart';
import 'package:flap_app/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  FlavorConfig(name: "prod", location: BannerLocation.topEnd, variables: {
    "appTitle": "Boiler Plate - Prod Flavor",
    "baseUrl": "api.spoonacular.com" //replace this baseUrl with the baseUrl used for your production API
  });
  runApp(const ProviderScope(child: MyApp()));
}