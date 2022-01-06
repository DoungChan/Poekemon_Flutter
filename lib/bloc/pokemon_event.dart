part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonEvent {}

class PokemonRequest extends PokemonEvent {
  final int page;

  PokemonRequest({required this.page});
}
