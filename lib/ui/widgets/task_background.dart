import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager_with_getx/ui/utils/asstes_path.dart';

class TaskBackground extends StatelessWidget {
  const TaskBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size screenSize=MediaQuery.sizeOf(context);
    return Stack(
      children: [
        SvgPicture.asset(
          AssetsPath.taskBackgroundSVG,
          height: screenSize.height,
          width: screenSize.width,
          fit: BoxFit.cover,
        ),
        SafeArea(child: child)
      ],
    );
  }
}