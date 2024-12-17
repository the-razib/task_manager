import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/data/models/task_status_model.dart';
import 'package:task_manager_with_getx/data/services/network_caller.dart';
import 'package:task_manager_with_getx/ui/controllers/new_task_list_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/task_status_count_controller.dart';
import 'package:task_manager_with_getx/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_with_getx/ui/utils/app_colors.dart';
import 'package:task_manager_with_getx/ui/widgets/background_screen.dart';
import 'package:task_manager_with_getx/ui/widgets/centerted_circular_progress_indicator.dart';
import 'package:task_manager_with_getx/ui/widgets/snackber_message.dart';
import 'package:task_manager_with_getx/ui/widgets/task_background.dart';
import 'package:task_manager_with_getx/ui/widgets/task_card.dart';
import 'package:task_manager_with_getx/ui/widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  static const String name = '/new-task-screen';

  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final NewTaskListController newTaskListController =
      Get.find<NewTaskListController>();
  final TaskStatusCountController taskStatusCountController =
      Get.find<TaskStatusCountController>();

  @override
  void initState() {
    _getNewTaskList();
    _getTaskStatusCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TaskBackground(
        child: RefreshIndicator(
          onRefresh: () async {
            _getNewTaskList();
            _getTaskStatusCount();
          },
          child: Column(
            children: [
              _buildSummarySection(),
              Expanded(
                child: GetBuilder<NewTaskListController>(builder: (controller) {
                  return Visibility(
                    visible: !controller.inProgress,
                    replacement: const CenterCircularProgressIndicator(),
                    child: ListView.separated(
                        itemBuilder: (context, int index) {
                          return TaskCard(
                            taskModel: controller.taskList[index],
                            onRefreshList: () {
                              _getNewTaskList();
                            },
                          );
                        },
                        separatorBuilder: (context, int index) {
                          return const SizedBox(height: 8);
                        },
                        itemCount: controller.taskList.length ?? 0),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.themeColor,
        onPressed: _onTabFAButton,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSummarySection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<TaskStatusCountController>(builder: (controller) {
        return Visibility(
          visible: controller.inProgress == false,
          replacement: const CenterCircularProgressIndicator(),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _getTaskSummaryCardList(),
            ),
          ),
        );
      }),
    );
  }

  List<TaskSummaryCard> _getTaskSummaryCardList() {
    List<TaskSummaryCard> taskSummaryCardList = [];

    for (TaskStatusModel t in taskStatusCountController.taskStatusCountList) {
      taskSummaryCardList.add(TaskSummaryCard(title: t.sId!, count: t.sum!));
    }
    return taskSummaryCardList;
  }

  Future<void> _onTabFAButton() async {
    final bool? shouldRefresh = await Get.to(() => const AddNewTaskScreen());
    if (shouldRefresh == true) {
      _getNewTaskList();
    }
  }

  Future<void> _getNewTaskList() async {
    final bool result = await newTaskListController.getNewTaskList();
    if (result == false) {
      showSnackBerMessage(newTaskListController.errorMessage!);
    }
  }

  Future<void> _getTaskStatusCount() async {
    final bool result = await taskStatusCountController.getTaskStatusCount();

    if (result == false) {
    } else {
      // showSnackBerMessage(taskStatusCountController.errorMessage!);
    }
  }
}
