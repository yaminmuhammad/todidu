import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:todidu/extensions/space_exs.dart';
import 'package:todidu/main.dart';
import 'package:todidu/models/task.dart';
import 'package:todidu/utils/app_colors.dart';
import 'package:todidu/utils/app_str.dart';
import 'package:todidu/utils/constants.dart';
import 'package:todidu/views/home/components/fab.dart';
import 'package:todidu/views/home/components/home_app_bar.dart';
import 'package:todidu/views/home/components/slider_drawer.dart';
import 'package:todidu/views/home/widget/task_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // final List<int> testing = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

  GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();

  // check done tasks
  // int checkDoneTasks(List<Task> task) {}

  dynamic valueOfIndicator(List<Task> task) {
    if (task.isNotEmpty) {
      return task.length;
    } else {
      return 3;
    }
  }

  int checkDoneTask(List<Task> tasks) {
    int i = 0;
    for (Task doneTask in tasks) {
      if (doneTask.isCompleted) {
        i++;
      }
    }
    return i;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final base = BaseWidget.of(context);

    return ValueListenableBuilder(
      valueListenable: base.dataStore.listenToTasks(),
      builder: (ctx, Box<Task> box, Widget? child) {
        var tasks = box.values.toList();

        // for sorting list of tasks
        tasks.sort((a, b) => a.createdAtDate.compareTo(b.createdAtDate));

        return Scaffold(
          backgroundColor: Colors.white,

          // FAB
          floatingActionButton: const Fab(),

          // Body
          body: SliderDrawer(
            // Drawer
            key: drawerKey,
            isDraggable: false,
            slider: CustomDrawer(),
            animationDuration: 1000,

            appBar: HomeAppBar(
              drawerKey: drawerKey,
            ),

            // main body
            child: _buildHomeBody(textTheme, base, tasks),
          ),
        );
      },
    );
  }

  // Home Body

  Widget _buildHomeBody(
    TextTheme textTheme,
    BaseWidget base,
    List<Task> tasks,
  ) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          // Custom App bar
          Container(
            margin: const EdgeInsets.only(
              top: 60,
            ),
            width: double.infinity,
            height: 100,
            // color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // progress indicator
                SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    value: checkDoneTask(tasks) / valueOfIndicator(tasks),
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation(
                      AppColors.primaryColor,
                    ),
                  ),
                ),

                // Space
                25.w,

                // top level task info
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStr.mainTitle,
                      style: textTheme.displayLarge,
                    ),
                    3.h,
                    Text(
                      "${checkDoneTask(tasks)} of ${tasks.length} task",
                      style: textTheme.titleMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Divider
          const Padding(
            padding: EdgeInsets.only(
              top: 10,
            ),
            child: Divider(
              thickness: 2,
              indent: 100,
            ),
          ),

          // Tasks
          Expanded(
            // width: double.infinity,
            // height: 745,
            child: tasks.isNotEmpty
                ? ListView.builder(
                    itemCount: tasks.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      var task = tasks[index];

                      return Dismissible(
                        direction: DismissDirection.horizontal,
                        onDismissed: (_) {
                          // remove current task from db
                          base.dataStore.deleteTask(task: task);
                        },
                        background: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.delete_outline,
                              color: Colors.grey,
                            ),
                            8.w,
                            const Text(
                              AppStr.deletedTask,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        key: Key(
                          task.id,
                        ),
                        child: TaskWidget(
                            // This is only for test

                            task: task),
                      );
                    },
                  )

                // Task List is empty
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Lottie animation
                      FadeIn(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Lottie.asset(
                            lottieURL,
                            animate: tasks.isNotEmpty ? false : true,
                          ),
                        ),
                      ),

                      // sub Text
                      FadeInUp(
                        from: 30,
                        child: const Text(
                          AppStr.doneAllTask,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
