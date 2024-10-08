import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todidu/models/task.dart';
import 'package:todidu/utils/app_colors.dart';
import 'package:todidu/views/tasks/task_view.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TextEditingController textEditingControllerForTitle = TextEditingController();
  TextEditingController textEditingControllerForSubTitle =
      TextEditingController();

  @override
  void initState() {
    textEditingControllerForTitle.text = widget.task.title;
    textEditingControllerForSubTitle.text = widget.task.subTitle;
    super.initState();
  }

  @override
  void dispose() {
    textEditingControllerForTitle.dispose();
    textEditingControllerForSubTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (ctx) => TaskView(
              titleTaskController: textEditingControllerForTitle,
              descriptionTaskController: textEditingControllerForSubTitle,
              task: widget.task,
            ),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: widget.task.isCompleted
              ? const Color.fromARGB(154, 119, 144, 229)
              : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              offset: const Offset(
                0,
                4,
              ),
              blurRadius: 10,
            ),
          ],
        ),
        child: ListTile(
          // Check Icon
          leading: GestureDetector(
            onTap: () {
              widget.task.isCompleted = !widget.task.isCompleted;
              widget.task.save();
            },
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 600,
              ),
              decoration: BoxDecoration(
                color: widget.task.isCompleted
                    ? AppColors.primaryColor
                    : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey,
                  width: .8,
                ),
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),

          // Task title
          title: Padding(
            padding: const EdgeInsets.only(
              bottom: 5,
              top: 3,
            ),
            child: Text(
              textEditingControllerForTitle.text,
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
                decoration:
                    widget.task.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
          ),

          // Task description
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Description of Task
              Text(
                textEditingControllerForSubTitle.text,
                style: TextStyle(
                  color: widget.task.isCompleted
                      ? AppColors.primaryColor
                      : Colors.black,
                  fontWeight: FontWeight.w300,
                  decoration: widget.task.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),

              // Date of Task
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 10,
                    top: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('hh:mm a').format(widget.task.createdAtTime),
                        style: TextStyle(
                          fontSize: 14,
                          color: widget.task.isCompleted
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMEd().format(widget.task.createdAtTime),
                        style: TextStyle(
                          fontSize: 14,
                          color: widget.task.isCompleted
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Date of Task
        ),
      ),
    );
  }
}
