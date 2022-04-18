import 'package:test/test.dart';

import '../lib/model/task.dart';

void main() {
  group('Default Task', () {
    final task = Task(id: '0891423');
    test('Task create date is created', () {
      final now = DateTime.now();
      expect(task.createDate.year, now.year);
      expect(task.createDate.month, now.month);
      expect(task.createDate.day, now.day);
      expect(task.createDate.hour, now.hour);
      expect(task.createDate.minute, now.minute);
    });
    test('Default task should have an empty description', () {
      expect(task.description, '');
    });
    test('Default task should not be complete', () {
      expect(task.isCompleted, false);
    });
    test('Task id is being assigned properly', () {
      expect(task.id, '0891423');
    });
    test('Task due date is not null', () {
      expect(task.dueDate != null, true);
    });
  });
  group('Normal Task', () {
    final dueDate = DateTime(2022, 7, 1);
    final now = DateTime.now();
    final id = '2534867';
    final description = 'This is the description';
    final task = Task(
      id: id,
      description: description,
      dueDate: dueDate,
      createDate: now,
    );
  //   // TODO Write 5 tests to ensure your Task constructor works correctly
    test('Normal task should not have an empty description', () {
      expect(task.description, description);
    });
    test('Normal task should not be complete', () {
      expect(task.isCompleted, false);
    });
    test('Task id is being assigned properly', () {
      expect(task.id, id);
    });
    test('Task due date is being assigned properly', () {
      expect(task.dueDate, dueDate);
    });
    test('Task create date is being assigned properly', () {
      expect(task.createDate, now);
    });

  });
  group('Task Comparison', () {
    void artificialDelay() {
      int i = 0;
      while (i++ < 10000000) {}
    }

    final taskA = Task(
      id: 'A',
      dueDate: DateTime(2021, 4, 20),
      createDate: DateTime.now(),
    );
    artificialDelay();
    final taskB = Task(
      id: 'B',
      dueDate: DateTime(2021, 4, 10),
      createDate: DateTime.now(),
    );
    artificialDelay();
    final taskC = Task(
      id: 'C',
      createDate: DateTime.now(),
    );

    test('A is before B', () => expect(taskA.compareTo(taskB) < 0, true));
    test('A is before C', () => expect(taskA.compareTo(taskB) < 0, true));
    test('B is before C', () => expect(taskB.compareTo(taskC) < 0, true));

    test('A is after B in compareToByDueDate',
            () => expect(taskA.compareToByDueDate(taskB) > 0, true));
    test('A is before C in compareToByDueDate',
            () => expect(taskA.compareToByDueDate(taskC) < 0, true));
    test('B is before C in compareToByDueDate',
            () => expect(taskB.compareToByDueDate(taskC) < 0, true));
  });
  group('Task Comparison 2', () {
    void artificialDelay() {
      int i = 0;
      while (i++ < 10000000) {}
    }

    final taskA = Task(
      id: 'A',
      dueDate: DateTime(2021, 4, 20),
      createDate: DateTime.now(),
    );
    artificialDelay();
    final taskB = Task(
      id: 'B',
      dueDate: DateTime(2021, 4, 10),
      createDate: DateTime.now(),
    );
    artificialDelay();
    final taskC = Task(
      id: 'C',
      createDate: DateTime.now(),
    );

    test('A is after B in compareToByDueDate',
            () => expect(taskA.compareToByDueDate(taskB) > 0, true));
    test('A is before C in compareToByDueDate',
            () => expect(taskA.compareToByDueDate(taskC) < 0, true));
    test('B is before C in compareToByDueDate',
            () => expect(taskB.compareToByDueDate(taskC) < 0, true));
  });
}