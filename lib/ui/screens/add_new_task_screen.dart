import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/data/models/network_response.dart';
import 'package:task_manager_with_getx/data/services/network_caller.dart';
import 'package:task_manager_with_getx/data/utils/urls.dart';
import 'package:task_manager_with_getx/ui/controllers/add_new_task_controller.dart';
import 'package:task_manager_with_getx/ui/widgets/background_screen.dart';
import 'package:task_manager_with_getx/ui/widgets/centerted_circular_progress_indicator.dart';
import 'package:task_manager_with_getx/ui/widgets/snackber_message.dart';
import 'package:task_manager_with_getx/ui/widgets/task_background.dart';
import 'package:task_manager_with_getx/ui/widgets/task_manager_app_ber.dart';

class AddNewTaskScreen extends StatefulWidget {
  static const String name = '/add-new-task-screen';

  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AddNewTaskController addNewTaskController =
      Get.find<AddNewTaskController>();
  bool _shoudRefreshPreviousPage = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        Navigator.pop(context, _shoudRefreshPreviousPage);
      },
      child: Scaffold(
        appBar: const TaskManagerAppBer(),
        body: TaskBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 56),
                    Text(
                      'Add New Task',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _titleTEController,
                      decoration: const InputDecoration(hintText: 'Title'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                        controller: _descriptionTEController,
                        maxLines: 4,
                        decoration:
                            const InputDecoration(hintText: 'Description'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Enter Description';
                          }
                          return null;
                        }),
                    const SizedBox(height: 24),
                    GetBuilder<AddNewTaskController>(builder: (controller) {
                      return Visibility(
                        visible: !controller.inProgress,
                        replacement: const CenterCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: _onTabAddNewTask,
                          child: const Text(
                            'Add New Task',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTabAddNewTask() {
    if (_formKey.currentState!.validate()) {
      _addNewTask();
    }
  }

  Future<void> _addNewTask() async {
    final bool result = await addNewTaskController.addNewTask(
        _titleTEController.text, _descriptionTEController.text);

    if (result) {
      _onTabClearTextFiled();
      _shoudRefreshPreviousPage = true;
      showSnackBerMessage('New task added');
    } else {
      showSnackBerMessage(
          addNewTaskController.errorMessage?.isNotEmpty == true
              ? addNewTaskController.errorMessage!
              : 'An error occurred',
          true);
    }
  }

  _onTabClearTextFiled() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
