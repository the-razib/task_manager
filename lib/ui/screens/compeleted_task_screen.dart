import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/ui/controllers/compeleted_task_controller.dart';
import 'package:task_manager_with_getx/ui/widgets/centerted_circular_progress_indicator.dart';
import 'package:task_manager_with_getx/ui/widgets/snackber_message.dart';
import 'package:task_manager_with_getx/ui/widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  static const String name = '/completed-task-screen';

  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  void initState() {
    _getCompletedTaskList();
    super.initState();
  }

  final CompletedTaskController completedTaskController=Get.find<CompletedTaskController>();


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await _getCompletedTaskList();
      },
      child: GetBuilder<CompletedTaskController>(
        builder: (controller) {
          return Visibility(
            visible: !controller.inProgress,
            replacement: const CenterCircularProgressIndicator(),
            child: ListView.separated(
                itemBuilder: (context, int index) {
                  return TaskCard(
                    taskModel: completedTaskController.completedTaskList[index],
                    onRefreshList: () {
                      _getCompletedTaskList();
                    },
                  );
                },
                separatorBuilder: (context, int index) {
                  return const SizedBox(height: 8);
                },
                itemCount: controller.completedTaskList.length),
          );
        }
      ),
    );
  }

  Future<void> _getCompletedTaskList() async {
    completedTaskController.completedTaskList.clear();
    final bool result = await completedTaskController.getCompletedTaskList();

    if (result==false) {
      showSnackBerMessage(completedTaskController.errorMessage!,true);
    }

  }
}
