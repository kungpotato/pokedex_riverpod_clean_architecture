import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/presentation/pages/home/providers/home.dart';
import 'package:pokedex/app/presentation/pages/home/providers/state/home_state.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<HomeState> homeState = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon List'),
      ),
      body: SingleChildScrollView(
        child: homeState.when(
          data: (data) => Center(
            child: Wrap(
              children: data.pokemonList
                  .map((e) => _buildCardItem(name: e.name, url: e.imgUrl))
                  .toList(),
            ),
          ),
          error: (error, stackTrace) => const Text('error'),
          loading: CircularProgressIndicator.new,
        ),
      ),
    );
  }

  Widget _buildCardItem({required String name, required String url}) {
    return SizedBox(
      width: 180,
      height: 180,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        margin: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  url,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16), // Padding around text
              child: Text(name),
            ),
          ],
        ),
      ),
    );
  }
}
