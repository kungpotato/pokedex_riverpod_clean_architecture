import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/presentation/pages/home/providers/home_state_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon List'),
      ),
      body: ListView.builder(
        itemCount: homeState.pokemonList.length,
        itemBuilder: (context, index) {
          final pokemon = homeState.pokemonList[index];
          return ListTile(title: Text(pokemon.name));
        },
      ),
    );
  }
}
