import '../../domain/entities/character.dart';

abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<Character> characters;
  final bool isLoadingMore;
  final bool hasMoreCharacters;

  CharacterLoaded(this.characters,
      {this.isLoadingMore = false, this.hasMoreCharacters = true});
}

class CharacterError extends CharacterState {
  final String message;

  CharacterError(this.message);
}
