import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  const Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.height,
    required this.weight,
  });

  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final int height;
  final int weight;

  @override
  List<Object?> get props => [id, name, imageUrl, types, height, weight];
}
