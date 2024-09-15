import 'package:flutter/material.dart';
import 'package:poke_api_app/pokemon_detail_screen.dart';

import 'api_service.dart';
import 'model.dart';

class PokemonListScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon List'),
      ),
      body: FutureBuilder<PokemonList>(
        future: apiService.fetchPokemonList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.pokemons.isEmpty) {
            return Center(child: Text('No Pokémon found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.pokemons.length,
              itemBuilder: (context, index) {
                final pokemon = snapshot.data!.pokemons[index];
                return ListTile(
                  title: Text(pokemon.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PokemonDetailScreen(
                          pokemonUrl: pokemon.url,
                          name: pokemon.name,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
