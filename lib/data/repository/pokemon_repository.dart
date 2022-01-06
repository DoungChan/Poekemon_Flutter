import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:pokedex/data/model/model.dart';

class PokemonRepository {
  final baseUrl = 'pokeapi.co';
  final clinet = http.Client();

  Future<PokemonPageResponse> getPokemonPage(int pageIndex) async {
    // pokemon?limit=100&offset=200

    final queryParameters = {
      'limit': '200',
      'offset': (pageIndex * 200).toString()
    };

    final uri = Uri.https(baseUrl, '/api/v2/pokemon', queryParameters);

    final response = await clinet.get(uri);
    final json = jsonDecode(response.body);

    return PokemonPageResponse.formJson(json);
  }
}
