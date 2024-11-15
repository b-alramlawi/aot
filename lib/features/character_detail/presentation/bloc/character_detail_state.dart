import '../../domain/entities/character_detail.dart';

abstract class CharacterDetailState {}

class CharacterDetailInitial extends CharacterDetailState {}

class CharacterDetailLoading extends CharacterDetailState {}

class CharacterDetailLoaded extends CharacterDetailState {
  final CharacterDetail characterDetail;

  CharacterDetailLoaded(this.characterDetail);
}

class CharacterDetailError extends CharacterDetailState {
  final String message;

  CharacterDetailError(this.message);
}
