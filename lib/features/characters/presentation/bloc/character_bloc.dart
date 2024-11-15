import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/character_repository.dart';
import 'character_event.dart';
import 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository characterRepository;
  int currentPage = 1;
  bool hasMoreCharacters = true;

  CharacterBloc(this.characterRepository) : super(CharacterInitial()) {
    on<LoadCharacters>((event, emit) async {
      try {
        emit(CharacterLoading());
        currentPage = 1;
        final characters =
            await characterRepository.getAllCharacters(page: currentPage);
        hasMoreCharacters = characters.isNotEmpty && currentPage < 12;
        emit(CharacterLoaded(characters, hasMoreCharacters: hasMoreCharacters));
      } catch (e) {
        emit(CharacterError(e.toString()));
      }
    });

    on<LoadMoreCharacters>((event, emit) async {
      try {
        if (state is CharacterLoaded && hasMoreCharacters) {
          final currentCharacters = (state as CharacterLoaded).characters;
          if (!(state as CharacterLoaded).isLoadingMore) {
            emit(CharacterLoaded(currentCharacters,
                isLoadingMore: true, hasMoreCharacters: hasMoreCharacters));
            currentPage++;

            if (currentPage <= 11) {
              final moreCharacters =
                  await characterRepository.getAllCharacters(page: currentPage);

              if (moreCharacters.isNotEmpty) {
                hasMoreCharacters = true;
                emit(CharacterLoaded([...currentCharacters, ...moreCharacters],
                    hasMoreCharacters: hasMoreCharacters));
              } else {
                hasMoreCharacters = false;
                emit(CharacterLoaded(currentCharacters,
                    isLoadingMore: false,
                    hasMoreCharacters: hasMoreCharacters));
              }
            } else {
              hasMoreCharacters = false;
              emit(CharacterLoaded(currentCharacters,
                  isLoadingMore: false, hasMoreCharacters: hasMoreCharacters));
            }
          }
        }
      } catch (e) {
        emit(CharacterError(e.toString()));
      }
    });
  }
}
