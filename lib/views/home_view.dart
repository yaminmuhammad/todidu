import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:todidu/extensions/space_exs.dart';
import 'package:todidu/utils/app_colors.dart';
import 'package:todidu/utils/app_str.dart';
import 'package:todidu/views/home/widget/fab.dart';

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
                  return AnimatedContainer(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.primaryColor.withOpacity(0.3),
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
                    duration: const Duration(milliseconds: 600),
                    child: ListTile(
                      // Check Icon
                      leading: GestureDetector(
                        onTap: () {
                          // checklist or unchecklist task
                        },
                        child: AnimatedContainer(
                          duration: const Duration(
                            milliseconds: 600,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
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
                      title: const Padding(
                        padding: const EdgeInsets.only(
                          bottom: 5,
                          top: 3,
                        ),
                        child: Text(
                          "Done",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),

                      // Task description
                      subtitle: Column(
                        children: [
                          Text(
                            "Description",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
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
