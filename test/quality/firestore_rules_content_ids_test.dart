import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/data/algebra_course_data.dart';
import 'package:calcquest/shared/data/continuity_course_data.dart';
import 'package:calcquest/shared/data/derivatives_course_data.dart';
import 'package:calcquest/shared/data/equations_course_data.dart';
import 'package:calcquest/shared/data/limits_course_data.dart';

void main() {
  test('Firestore accepts every content lesson id used by the app', () {
    final rules = File('firestore.rules').readAsStringSync();
    final appContentLessonIds = <String>{
      ...algebraCourseLessons.map((lesson) => lesson.id),
      ...equationsCourseLessons.map((lesson) => lesson.id),
      ...limitsCourseLessons.map((lesson) => lesson.id),
      ...continuityCourseLessons.map((lesson) => lesson.id),
      ...derivativesCourseLessons.map((lesson) => lesson.id),
    };

    for (final lessonId in appContentLessonIds) {
      expect(
        rules,
        contains("'$lessonId'"),
        reason:
            'completedContentLessonIds sync would reject progress for $lessonId.',
      );
    }

    expect(rules, contains('values.size() <= ${appContentLessonIds.length}'));
  });
}
