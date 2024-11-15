abstract class CharacterDetailEvent {}

class LoadCharacterDetail extends CharacterDetailEvent {
  final int id;

  LoadCharacterDetail(this.id);
}
