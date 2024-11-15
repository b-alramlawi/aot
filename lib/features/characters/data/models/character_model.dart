import '../../domain/entities/character.dart';

class CharacterModel extends Character {
  CharacterModel({
    required super.id,
    required super.name,
    required super.img,
    required super.gender,
    required super.age,
    required super.occupation,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? 'Unknown',
      img: json['img'] ?? '',
      gender: json['gender'] ?? 'Unknown',
      age: int.tryParse(json['age'].toString()) ?? 0,
      occupation: json['occupation'] ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'img': img,
      'gender': gender,
      'age': age,
      'occupation': occupation,
    };
  }
}
