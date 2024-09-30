import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:todidu/extensions/space_exs.dart';
import 'package:todidu/utils/app_colors.dart';
import 'package:todidu/utils/app_str.dart';
import 'package:todidu/views/home/components/fab.dart';
import 'package:todidu/views/home/widget/task_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<SliderDrawerState> dkey = GlobalKey<SliderDrawerState>();

  // check done tasks
  // int checkDoneTasks(List<Task> task) {}

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,

      // FAB
      floatingActionButton: const Fab(),

      // Body
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          // Custom App bar

          children: [
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
                  const SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      value: 1 / 3,
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
                        "1 of 3 task",
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
            SizedBox(
              width: double.infinity,
              height: 745,
              child: ListView.builder(
                itemCount: 20,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Dismissible(
                    direction: DismissDirection.horizontal,
                    onDismissed: (_) {
                      // remove current task from db
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
                      index.toString(),
                    ),
                    child: const TaskWidget(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
