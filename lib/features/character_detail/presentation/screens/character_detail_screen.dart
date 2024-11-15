import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/character_detail_bloc.dart';
import '../bloc/character_detail_event.dart';
import '../bloc/character_detail_state.dart';

class CharacterDetailScreen extends StatelessWidget {
  final int characterId;

  const CharacterDetailScreen({super.key, required this.characterId});

  @override
  Widget build(BuildContext context) {
    context.read<CharacterDetailBloc>().add(LoadCharacterDetail(characterId));

    return Scaffold(
      appBar: AppBar(title: const Text('Character Details')),
      body: BlocBuilder<CharacterDetailBloc, CharacterDetailState>(
        builder: (context, state) {
          if (state is CharacterDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CharacterDetailLoaded) {
            final character = state.characterDetail;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.network(
                        character.img,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Container(
                          color: Colors.black54,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            character.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Table(
                          columnWidths: const {
                            0: FixedColumnWidth(120),
                          },
                          border: TableBorder.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          children: [
                            _buildTableRow('Gender', character.gender),
                            _buildTableRow('Age', '${character.age}'),
                            _buildTableRow('Occupation', character.occupation),
                            _buildTableRow('Birthplace', character.birthplace),
                            _buildTableRow('Status', character.status),
                            _buildTableRow('Height', character.height),
                          ],
                        ),
                        const SizedBox(height: 16.0),

                        // Species Tags
                        const Text(
                          'Species',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Wrap(
                          spacing: 8.0,
                          children: character.species
                              .map((species) => Chip(
                                    label: Text(species),
                                    labelStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.brown,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CharacterDetailError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('No data'));
        },
      ),
    );
  }

  TableRow _buildTableRow(String title, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
