import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/data/model/model.dart';
import 'package:pokedex/data/repository/pokemon_repository.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final _pokemonRepository = PokemonRepository();
  PokemonBloc() : super(PokemonInitial()) {
    on<PokemonEvent>((event, emit) async {
      if (event is PokemonRequest) {
        emit(PokemonPageLoading());

        try {
          final pokemonPageResponse =
              await _pokemonRepository.getPokemonPage(event.page);
          emit(PokemonPageLoadSucess(
              pokemonListing: pokemonPageResponse.pokemonListings,
              canLoadNextPage: pokemonPageResponse.canLoadNextPage));
        } catch (e) {
          emit(PokemonPageLoadFailed());
        }
      }
    });
  }
  // @override
  // Stream<PokemonState> mapEventToState(PokemonEvent event) async* {
  //   if (event is PokemonRequest) {
  //     yield PokemonPageLoading();

  //     try {
  //       final pokemonPageResponse =
  //           await _pokemonRepository.getPokemonPage(event.page);
  //       yield PokemonPageLoadSucess(
  //           pokemonListing: pokemonPageResponse.pokemonListings,
  //           canLoadNextPage: pokemonPageResponse.canLoadNextPage);
  //     } catch (e) {
  //       yield PokemonPageLoadFailed();
  //     }
  //   }
  // }
}
