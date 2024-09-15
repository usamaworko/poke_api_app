
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'model.dart';

class PokemonDetailScreen extends StatelessWidget {
  final String pokemonUrl;
  final String name;

  PokemonDetailScreen({required this.pokemonUrl, required this.name});

  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$name Details'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<PokemonDetail>(
          future: apiService.fetchPokemonDetail(pokemonUrl),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No details found'));
            } else {
              final details = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(details.spriteUrl),
                    SizedBox(height: 20),
                    Text(
                      'ID: ${details.id}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Name: ${details.name}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Abilities:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    ...details.abilities.map((ability) => Text(ability)),
                    SizedBox(height: 20),
                    Text(
                      'Moves:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    ...details.moves.map((move) => Text(move)),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
