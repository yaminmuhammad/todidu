import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.createdAtTime,
    required this.createdAtDate,
    required this.isCompleted,
  });

  @HiveField(0) // id
  final String id;
  @HiveField(1) // title
  String title;
  @HiveField(2) // subTitle
  final String subTitle;
  @HiveField(3) // createdAtTime
  DateTime createdAtTime;
  @HiveField(4) // createdAtDate
  DateTime createdAtDate;
  @HiveField(5) // isCompleted
  bool isCompleted;

  // created new Task
  factory Task.create({
    required String? title,
    required String? subTitle,
    required DateTime? createdAtTime,
    required DateTime? createdAtDate,
  }) =>
      Task(
        id: const Uuid().v1(),
        title: title ?? "",
        subTitle: subTitle ?? "",
        createdAtTime: createdAtTime ?? DateTime.now(),
        createdAtDate: createdAtDate ?? DateTime.now(),
        isCompleted: false,
      );
}
