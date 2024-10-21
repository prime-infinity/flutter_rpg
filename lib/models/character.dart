import 'package:cloud_firestore/cloud_firestore.dart';
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

  //character from firestore... here we use the factory
  factory Character.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    //get data from snapshot
    final data = snapshot.data()!;

    //use data to make character instance
    Character character = Character(
        name: data["name"],
        slogan: data['slogan'],
        vocation:
            Vocation.values.firstWhere((v) => v.toString() == data['vocation']),
        id: snapshot.id);

    //update skill
    for (String id in data['skills']) {
      Skill skill = allSkills.firstWhere((sk) => sk.id == id);
      character.updateSkill(skill);
    }

    //set isFav
    if (data['isFav'] == true) {
      character.toggleIsFav();
    }

    return character;
  }
}
