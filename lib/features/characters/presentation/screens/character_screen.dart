import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../character_detail/presentation/screens/character_detail_screen.dart';
import '../bloc/character_bloc.dart';
import '../bloc/character_event.dart';
import '../bloc/character_state.dart';
import '../../domain/entities/character.dart';
import '../widgets/character_card.dart';
import '../widgets/character_search.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  CharacterScreenState createState() => CharacterScreenState();
}

class CharacterScreenState extends State<CharacterScreen> {
  List<Character> allCharacters = [];
  String searchTerm = '';
  bool isGridView = true;
  bool isRefreshing = false;

  Future<void> _refreshCharacters() async {
    setState(() {
      isRefreshing = true;
    });
    context.read<CharacterBloc>().add(LoadCharacters());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AOT Characters'),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          CharacterSearch(
            searchTerm: searchTerm,
            onChanged: (value) {
              setState(() {
                searchTerm = value;
              });
            },
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshCharacters,
              child: BlocListener<CharacterBloc, CharacterState>(
                listener: (context, state) {
                  if (state is CharacterLoaded) {
                    setState(() {
                      isRefreshing = false;
                    });
                  }
                },
                child: BlocBuilder<CharacterBloc, CharacterState>(
                  builder: (context, state) {
                    if (state is CharacterLoading && allCharacters.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CharacterLoaded) {
                      allCharacters = state.characters;
                      final filteredCharacters = allCharacters
                          .where((character) => character.name
                              .toLowerCase()
                              .contains(searchTerm.toLowerCase()))
                          .toList();

                      return NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (!scrollInfo.metrics.atEdge ||
                              scrollInfo.metrics.pixels == 0) return false;

                          if (state.hasMoreCharacters) {
                            context
                                .read<CharacterBloc>()
                                .add(LoadMoreCharacters());
                          }
                          return true;
                        },
                        child: isGridView
                            ? GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 0.6,
                                ),
                                itemCount: filteredCharacters.length +
                                    (state.isLoadingMore ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (index < filteredCharacters.length) {
                                    return CharacterCard(
                                      character: filteredCharacters[index],
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CharacterDetailScreen(
                                                    characterId:
                                                        filteredCharacters[
                                                                index]
                                                            .id),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                },
                              )
                            : ListView.builder(
                                itemCount: filteredCharacters.length +
                                    (state.isLoadingMore ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (index < filteredCharacters.length) {
                                    return CharacterCard(
                                      character: filteredCharacters[index],
                                      isList: true,
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CharacterDetailScreen(
                                                    characterId:
                                                        filteredCharacters[
                                                                index]
                                                            .id),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                },
                              ),
                      );
                    } else if (state is CharacterError) {
                      return Center(
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.yellow[200],
                            border: Border.all(
                                color: Colors.brown.shade300, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text('Error: ${state.message}'),
                        ),
                      );
                    }
                    if (isRefreshing) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return const Center(child: Text('No data'));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
