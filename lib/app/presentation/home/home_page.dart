import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/presentation/home/providers/home_notifier.dart';
import 'package:pokedex/app/presentation/home/widgets/home_component_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      //
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon List'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Wrap(
            key: const Key('pokemonList'),
            children: homeState.pokemonList
                .map((e) => PokemonItem(name: e.name, url: e.imgUrl))
                .toList(),
          ),
        ),
      ),
    );
  }
}
