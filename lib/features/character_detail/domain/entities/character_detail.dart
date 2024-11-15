abstract class CharacterDetail {
  final int id;
  final String name;
  final String img;
  final String gender;
  final int age;
  final String occupation;
  final String birthplace;
  final String status;
  final String height;
  final List<String> species;

  CharacterDetail({
    required this.id,
    required this.name,
    required this.img,
    required this.gender,
    required this.age,
    required this.occupation,
    required this.birthplace,
    required this.status,
    required this.height,
    required this.species,
  });
}
