import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/data/models/network_response.dart';
import 'package:task_manager_with_getx/data/models/task_list_model.dart';
import 'package:task_manager_with_getx/data/models/task_model.dart';
import 'package:task_manager_with_getx/data/services/network_caller.dart';
import 'package:task_manager_with_getx/data/utils/urls.dart';
import 'package:task_manager_with_getx/ui/controllers/progress_task_controller.dart';
import 'package:task_manager_with_getx/ui/widgets/centerted_circular_progress_indicator.dart';
import 'package:task_manager_with_getx/ui/widgets/snackber_message.dart';
import 'package:task_manager_with_getx/ui/widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  static const String name = '/progress_task_screen';

  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  void initState() {
    _getProgressTaskList();
    super.initState();
  }

  final ProgressTaskController progressTaskController = Get.find<
      ProgressTaskController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await _getProgressTaskList();
      },
      child: GetBuilder<ProgressTaskController>(
          builder: (controller) {
            return Visibility(
              visible: !controller.inProgress,
              replacement: const CenterCircularProgressIndicator(),
              child: ListView.separated(
                  itemBuilder: (context, int index) {
                    return TaskCard(
                      taskModel: controller.progressTaskList[index],
                      onRefreshList: () {
                        _getProgressTaskList();
                      },
                    );
                  },
                  separatorBuilder: (context, int index) {
                    return const SizedBox(height: 8);
                  },
                  itemCount: controller.progressTaskList.length),
            );
          }
      ),
    );
  }

  Future<void> _getProgressTaskList() async {
    final bool result = await progressTaskController.getProgressTaskList();

    if (result == false) {
      showSnackBerMessage(progressTaskController.errorMessage!);
    }
  }
}