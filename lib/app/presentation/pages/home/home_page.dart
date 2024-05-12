import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/presentation/pages/home/notifier/home_notifier.dart';
import 'package:pokedex/app/presentation/pages/home/widgets/home_component_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return HomeComponentWidget(
      child: Text(
        ref.read(homeNotifierProvider),
      ),
    );
  }
}
