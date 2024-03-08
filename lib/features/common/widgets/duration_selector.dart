import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:todo_y_pomodoro_app/core/date_utils.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';

class DurationSelector extends StatefulWidget {
  final Function(Duration) onSelectDuration;
  final Duration? currentDuration;
  final String hintText;
  const DurationSelector({
    Key? key,
    required this.onSelectDuration,
    required this.currentDuration,
    required this.hintText
  }) : super(key: key);

  @override
  State<DurationSelector> createState() => _DurationSelectorState();
}

class _DurationSelectorState extends State<DurationSelector> {
  DateTime tempDate = DateTime.now();
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(widget.currentDuration != null){
        controller.text = formatDuration(widget.currentDuration!);
      }
    });
  }

  @override
  void didUpdateWidget(covariant DurationSelector oldWidget) {
    if(widget.currentDuration != null){
      controller.text = formatDuration(widget.currentDuration!);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var resultingDuration = await showDurationPicker(
          context: context,
          initialTime: const Duration(minutes: 15),
        );
        if(resultingDuration == null) return;
        widget.onSelectDuration(resultingDuration);
      },
      child: Container(
        width: mqWidth(context, 90),
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[400]!
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.only(
          left: mqWidth(context, 3)
        ),
        child: Row(
          children: [
            Text(widget.currentDuration != null ? formatDuration(widget.currentDuration!) : widget.hintText, style: TextStyle(
              fontSize: 18,
              color: Colors.grey[400],
              fontWeight: FontWeight.w400
            )),
          ],
        )
      ),
    );
  }
}