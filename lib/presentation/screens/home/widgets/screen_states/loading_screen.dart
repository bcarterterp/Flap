import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingScreenWidget extends ConsumerWidget {
  const LoadingScreenWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(child: CircularProgressIndicator());
  }
}
