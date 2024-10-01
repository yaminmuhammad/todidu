import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:lottie/lottie.dart';
import 'package:todidu/extensions/space_exs.dart';
import 'package:todidu/utils/app_colors.dart';
import 'package:todidu/utils/app_str.dart';
import 'package:todidu/utils/constants.dart';
import 'package:todidu/views/home/components/fab.dart';
import 'package:todidu/views/home/widget/task_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<int> testing = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

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
            Expanded(
              // width: double.infinity,
              // height: 745,
              child: testing.isNotEmpty
                  ? ListView.builder(
                      itemCount: testing.length,
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
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeIn(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Lottie.asset(
                              lottieURL,
                              animate: testing.isNotEmpty ? false : true,
                            ),
                          ),
                        ),
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
      ),
    );
  }
}
