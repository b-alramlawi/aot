import '../../domain/entities/character_detail.dart';

class CharacterDetailModel extends CharacterDetail {
  CharacterDetailModel({
    required super.id,
    required super.name,
    required super.img,
    required super.gender,
    required super.age,
    required super.occupation,
    required super.birthplace,
    required super.status,
    required super.height,
    required super.species,
  });

  factory CharacterDetailModel.fromJson(Map<String, dynamic> json) {
    return CharacterDetailModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? 'Unknown',
      img: json['img'] ?? '',
      gender: json['gender'] ?? 'Unknown',
      age: int.tryParse(json['age'].toString()) ?? 0,
      occupation: json['occupation'] ?? 'Unknown',
      birthplace: json['birthplace'] ?? 'Unknown',
      status: json['status'] ?? 'Unknown',
      height: json['height'] ?? 'Unknown',
      species: (json['species'] as List<dynamic>?)
              ?.map((item) => item.toString())
              .toList() ??
          [],
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
      'birthplace': birthplace,
      'status': status,
      'height': height,
      'species': species,
    };
  }
}
