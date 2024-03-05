import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';

class AppVersionLabel extends StatefulWidget {
  const AppVersionLabel({Key? key}) : super(key: key);

  @override
  State<AppVersionLabel> createState() => _AppVersionLabelState();
}

class _AppVersionLabelState extends State<AppVersionLabel> {
  String version = "";
  @override
  void initState() {
    super.initState();
    loadVersion();
  }

  Future<void> loadVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    if(mounted){
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: mqWidth(context, 8)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "V $version",
            style: const TextStyle(
              color: Colors.black54
            )
          ),
        ],
      ),
    );
  }
}