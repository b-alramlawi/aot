import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/character_detail_repository.dart';
import 'character_detail_event.dart';
import 'character_detail_state.dart';

class CharacterDetailBloc
    extends Bloc<CharacterDetailEvent, CharacterDetailState> {
  final CharacterDetailRepository characterDetailRepository;

  CharacterDetailBloc(this.characterDetailRepository)
      : super(CharacterDetailInitial()) {
    on<LoadCharacterDetail>((event, emit) async {
      try {
        emit(CharacterDetailLoading());
        final characterDetail =
            await characterDetailRepository.getCharacterDetail(event.id);
        emit(CharacterDetailLoaded(characterDetail));
      } catch (e) {
        emit(CharacterDetailError(e.toString()));
      }
    });
  }
}
