import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_with_getx/data/models/task_model.dart';
import 'package:task_manager_with_getx/ui/controllers/chang_task_status_controller.dart';
import 'package:task_manager_with_getx/ui/controllers/task_delet_controller.dart';
import 'package:task_manager_with_getx/ui/utils/app_colors.dart';
import 'package:task_manager_with_getx/ui/widgets/centerted_circular_progress_indicator.dart';
import 'package:task_manager_with_getx/ui/widgets/snackber_message.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskModel,
    required this.onRefreshList,
  });

  final TaskModel taskModel;
  final VoidCallback onRefreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  String _selectedStatus = '';

  final TaskDeleteController taskDeleteController =
  Get.find<TaskDeleteController>();
  final ChangeTaskStatusController changeTaskStatusController =
  Get.find<ChangeTaskStatusController>();

  @override
  void initState() {
    _selectedStatus = widget.taskModel.status!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime createdDate = DateTime.parse(widget.taskModel.createdDate.toString());
    String formattedDate = DateFormat('h:mm a, MMM d, y').format(createdDate);

    return Card(
      color: Colors.white,
      elevation: 5, // Adding shadow for a raised effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title ?? '',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.taskModel.description ?? '',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Date: $formattedDate',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTaskStatusChip(),
                Wrap(
                  spacing: 8,
                  children: [
                    _buildEditButton(),
                    _buildDeleteButton(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Task Status Chip with improved design
  Widget _buildTaskStatusChip() {
    return Chip(
      label: Text(
        widget.taskModel.status!,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: _getStatusColor(widget.taskModel.status!),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    );
  }

  Widget _buildEditButton() {
    return GetBuilder<ChangeTaskStatusController>(
      builder: (controller) {
        return Visibility(
          visible: !controller.inProgress,
          replacement: const CenterCircularProgressIndicator(),
          child: IconButton(
            onPressed: _onTabEditButton,
            icon: const Icon(
              Icons.edit,
              color: Colors.blue,
            ),
            tooltip: 'Edit Task Status',
          ),
        );
      },
    );
  }

  Widget _buildDeleteButton() {
    return GetBuilder<TaskDeleteController>(
      builder: (controller) {
        return Visibility(
          visible: !controller.inProgress,
          replacement: const CenterCircularProgressIndicator(),
          child: IconButton(
            onPressed: _onTabDeleteButton,
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            tooltip: 'Delete Task',
          ),
        );
      },
    );
  }

  // Handling the edit button click
  void _onTabEditButton() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners for dialog
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Select Task Status',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                // List of status options with improved design
                ...['New', 'Completed', 'Cancelled', 'Progress'].map((e) {
                  return GestureDetector(
                    onTap: () {
                      _changesStatues(e);
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: _selectedStatus == e
                            ? Colors.blueAccent.withOpacity(0.2) // Light background for selected item
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _selectedStatus == e
                              ? Colors.blueAccent
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: _selectedStatus == e ? Colors.blueAccent : Colors.black87,
                            ),
                          ),
                          if (_selectedStatus == e)
                            const Icon(
                              Icons.check,
                              size: 24,
                              color: Colors.blueAccent, // Green check for selected status
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                const SizedBox(height: 16),
                // Cancel and Confirm buttons with professional design

              ],
            ),
          ),
        );
      },
    );
  }

  // Deleting the task
  Future<void> _onTabDeleteButton() async {
    final bool result = await taskDeleteController.onTabDeleteButton(widget.taskModel.sId!);
    if (result) {
      widget.onRefreshList();
    } else {
      showSnackBerMessage(taskDeleteController.errorMessage!);
    }
  }

  // Handling the task status change
  Future<void> _changesStatues(String newStatus) async {
    final bool result = await changeTaskStatusController.changesStatues(
      widget.taskModel.sId!,
      newStatus,
    );
    if (result) {
      widget.onRefreshList();
    } else {
      showSnackBerMessage(changeTaskStatusController.errorMessage!);
    }
  }

  // Get the color for task status chip
  Color? _getStatusColor(String status) {
    switch (status) {
      case 'New':
        return Colors.blue[400];
      case 'Completed':
        return Colors.green[400];
      case 'Cancelled':
        return Colors.red[400];
      case 'Progress':
        return Colors.orange[400];
      default:
        return Colors.grey;
    }
  }
}
