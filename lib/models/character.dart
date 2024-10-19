import 'package:flutter_rpg/models/skill.dart';
import 'package:flutter_rpg/models/stats.dart';
import 'package:flutter_rpg/models/vocation.dart';

class Character with Stats {
  //constructor
  Character(
      {required this.name,
      required this.slogan,
      required this.vocation,
      required this.id});

  //fields
  final Set<Skill> skills = {};
  final Vocation vocation;
  final String name;
  final String slogan;
  final String id;
  bool _isFav = false; //private field cannot be mutated from outside class

  //getters
  bool get isFav => _isFav;

  //methods
  void toggleIsFav() {
    _isFav = !_isFav;
  }

  void updateSkill(Skill skill) {
    skills.clear();
    skills.add(skill);
  }

  //typecasting character to firestore(map)
  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "slogan": slogan,
      "isFav": _isFav,
      "vocation": vocation.toString(),
      "skills": skills.map((s) => s.id).toList(),
      "stats": statsAsMap,
      "points": points,
    };
  }
}
