import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/models/skill.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';

class SkillList extends StatefulWidget {
  const SkillList(this.character, {super.key});

  final Character character;

  @override
  State<SkillList> createState() => _SkillListState();
}

class _SkillListState extends State<SkillList> {
  late List<Skill> availableSkills;
  //the "late" keyword is self explanatory

  late Skill selectedSkill;

  @override
  void initState() {
    /** we use this LC hook which is runs after we have access to the
     * widget and any arg in the widget.. so inside here, we have
     * access to the "widgit". and we can assign this as needed
     */
    availableSkills = allSkills.where((skill) {
      return skill.vocation == widget.character.vocation;
    }).toList();

    if (widget.character.skills.isEmpty) {
      selectedSkill = availableSkills[0];
    }
    if (widget.character.skills.isNotEmpty) {
      selectedSkill = widget.character.skills.first;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        color: AppColors.secondaryColor.withOpacity(0.5),
        child: Column(
          children: [
            const StyledHeading("choose an active skill"),
            const StyledText("skills are unique to your character vocation"),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: availableSkills.map((skill) {
                return Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(2),
                  color: skill == selectedSkill
                      ? Colors.yellow
                      : Colors.transparent,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.character.updateSkill(skill);
                        selectedSkill = skill;
                      });
                    },
                    child: Image.asset(
                      "assets/img/skills/${skill.image}",
                      width: 70,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 10,
            ),
            StyledText(selectedSkill.name),
          ],
        ),
      ),
    );
  }
}
