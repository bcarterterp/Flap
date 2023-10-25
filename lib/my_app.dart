import 'package:flap_app/presentation/navigation.dart';
import 'package:flap_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: (ref.read(flavorRepositoryProvider)).getAppTitle(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _flavorBanner(
        child: MaterialApp.router(routerConfig: navigationRouter),
        ref: ref,
      ),
    );
  }

  Widget _flavorBanner(
          {required Widget child, bool show = true, required WidgetRef ref}) =>
      show
          ? Banner(
              child: child,
              location: BannerLocation.topEnd,
              message: (ref.read(flavorRepositoryProvider)).getFlavorName(),
              color: Colors.green,
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.0,
                  letterSpacing: 1.0),
              textDirection: TextDirection.ltr,
            )
          : Container(
              child: child,
            );
}
