import 'package:flutter/material.dart';

class PokemonItem extends StatelessWidget {
  const PokemonItem({required this.name, required this.url, super.key});

  final String name;
  final String url;

  @override
  Widget build(BuildContext context) {
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
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox(),
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
