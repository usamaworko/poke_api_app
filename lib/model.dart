
import 'dart:convert';

class PokemonList {
  final List<Pokemon> pokemons;

  PokemonList({required this.pokemons});

  factory PokemonList.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<Pokemon> pokemonList = list.map((i) => Pokemon.fromJson(i)).toList();
    return PokemonList(pokemons: pokemonList);
  }
}

class Pokemon {
  final String name;
  final String url;

  Pokemon({
    required this.name,
    required this.url,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      url: json['url'],
    );
  }
}

class PokemonDetail {
  final String name;
  final int id;
  final String spriteUrl;
  final List<String> abilities;
  final List<String> moves;

  PokemonDetail({
    required this.name,
    required this.id,
    required this.spriteUrl,
    required this.abilities,
    required this.moves,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final spriteUrl = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';

    final abilities = (json['abilities'] as List)
        .map((ability) => ability['ability']['name'] as String)
        .toList();
    final moves = (json['moves'] as List)
        .map((move) => move['move']['name'] as String)
        .toList();

    return PokemonDetail(
      name: json['name'],
      id: id,
      spriteUrl: spriteUrl,
      abilities: abilities,
      moves: moves,
    );
  }
}
