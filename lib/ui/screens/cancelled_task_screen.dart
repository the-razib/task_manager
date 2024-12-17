import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/ui/controllers/cancelled_task_controller.dart';
import 'package:task_manager_with_getx/ui/widgets/centerted_circular_progress_indicator.dart';
import 'package:task_manager_with_getx/ui/widgets/snackber_message.dart';
import 'package:task_manager_with_getx/ui/widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  static const String name = '/cancelledTaskScreen';

  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  void initState() {
    _getCancelledTaskList();
    super.initState();
  }

final CancelledTaskController cancelledTaskController=Get.find<CancelledTaskController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await _getCancelledTaskList();
      },
      child: GetBuilder<CancelledTaskController>(
        builder: (controller) {
          return Visibility(
            visible: !controller.inProgress,
            replacement: const CenterCircularProgressIndicator(),
            child: ListView.separated(
                itemBuilder: (context, int index) {
                  return TaskCard(
                    taskModel: controller.cancelledTaskList[index],
                    onRefreshList: () {
                      _getCancelledTaskList();
                    },
                  );
                },
                separatorBuilder: (context, int index) {
                  return const SizedBox(height: 8);
                },
                itemCount: controller.cancelledTaskList.length),
          );
        }
      ),
    );
  }

  Future<void> _getCancelledTaskList() async {
    final bool result= await cancelledTaskController.getCancelledTaskList();

    if (result==false) {
      showSnackBerMessage(cancelledTaskController.errorMessage!);
    }
  }
}
