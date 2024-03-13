import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:todo_y_pomodoro_app/core/ad_helper.dart';
import 'package:todo_y_pomodoro_app/core/date_utils.dart';
import 'package:todo_y_pomodoro_app/core/task_state_enum.dart';
import 'package:todo_y_pomodoro_app/core/utils.dart';
import 'package:todo_y_pomodoro_app/features/common/models/error_response.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/alerts.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/app_header.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/custom_icon_button.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/h_spacing.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/page_loader.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/scaffold_wrapper.dart';
import 'package:todo_y_pomodoro_app/features/common/widgets/v_spacing.dart';
import 'package:todo_y_pomodoro_app/features/tasks/models/task_model.dart';
import 'package:todo_y_pomodoro_app/features/tasks/providers/tasks_provider.dart';
import 'package:todo_y_pomodoro_app/features/tasks/widgets/task_list_item.dart';

class PomodoroPage extends StatefulWidget {
  final TaskModel taskModel;
  final bool rewarded;
  const PomodoroPage({
    super.key,
    required this.taskModel,
    required this.rewarded,
  });

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  InterstitialAd? _interstitialAd;
  RewardedInterstitialAd? _rewardedInterstitialAd;
  CountDownController pomodoroController = CountDownController();

  @override
  void initState() {
    super.initState();
    loadInterstitialAd(widget.rewarded);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const VSpacing(5),
                AppHeader(title: FlutterI18n.translate(context, "pages.pomodoro.title")),
                const VSpacing(2),
                TaskListItem(
                  taskModel: widget.taskModel,
                  fromPomodoroPage: true,
                  onCompleteTask: () async {
                    pomodoroController.pause();
                    await showSuccessAlert(context, FlutterI18n.translate(context, "general.dear"), FlutterI18n.translate(context, "pages.pomodoro.finished"));
                    showInterstitialAd(widget.rewarded);
                  },
                ),
                const VSpacing(3),
                CircularCountDownTimer(
                  controller: pomodoroController,
                  // duration: widget.taskModel.pomodoro,
                  duration: 10,
                  width: mqWidth(context, 70),
                  height: mqWidth(context, 70),
                  fillColor: Colors.white,
                  strokeWidth: 20,
                  isReverse: true,
                  ringColor: Theme.of(context).primaryColor,
                  textStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                  onComplete: () async {
                    // ignore: use_build_context_synchronously
                    if(!context.mounted) return;
                    final tasksProvider = Provider.of<TasksProvider>(context, listen: false);
                    final resp = await tasksProvider.updateTask(widget.taskModel.copyWith(
                      updatedAt: DateTime.now(), 
                      deletedAt: null,
                      state: TaskState.completed.value
                    ));
                    if(resp == null) return;
                    if(resp is ErrorResponse){
                      // ignore: use_build_context_synchronously
                      if(!context.mounted) return;
                      showErrorAlert(context, FlutterI18n.translate(context, "general.dear"), [resp.message]);
                      return;
                    }
                    if(!mounted) return;
                    await showSuccessAlert(context, FlutterI18n.translate(context, "general.dear"), FlutterI18n.translate(context, "pages.pomodoro.finished"));
                    showInterstitialAd(widget.rewarded);
                  },
                ),
                const VSpacing(3),
                Text("${FlutterI18n.translate(context, "pages.pomodoro.focus")} ${formatSeconds(context, widget.taskModel.pomodoro)}", style: Theme.of(context).textTheme.bodyMedium),
                const VSpacing(2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconButton(
                      borderRadius: 30,
                      size: 15, 
                      onPressed: (){
                        pomodoroController.restart();
                        setState(() {});
                      }, 
                      fillColor: const Color(0xffF2F2F2),
                      icon: const Icon(Icons.refresh_rounded, color: Color(0xffAFAFAF))
                    ),
                    const HSpacing(3),
                    CustomIconButton(
                      borderRadius: 50,
                      size: 24, 
                      fillColor: Theme.of(context).primaryColor,
                      onPressed: (){
                        if(pomodoroController.isPaused){
                          pomodoroController.resume();
                        }else{
                          pomodoroController.pause();
                        }
                        setState(() {});
                      }, 
                      icon: Icon(pomodoroController.isPaused ? Icons.play_arrow_rounded : Icons.pause, color: Colors.white, size: 30)
                    ),
                    const HSpacing(3),
                    CustomIconButton(
                      borderRadius: 30,
                      size: 15, 
                      fillColor: const Color(0xffF2F2F2),
                      onPressed: (){
                        pomodoroController.reset();
                      }, 
                      icon: const Icon(Icons.stop_rounded, color: Color(0xffAFAFAF))
                    ),
                  ],
                )
              ]
            )
          ),
          Selector<TasksProvider, bool>(
            selector: (context, tasksProvider) => tasksProvider.updateTaskLoading,
            builder: (context, updateTaskLoading, _) {
              return PageLoader(
                loading: updateTaskLoading, 
                message: FlutterI18n.translate(context, "pages.pomodoro.completing")
              );
            },
          ),
        ]
      )
    );
  }
  void loadInterstitialAd(bool rewarded) async {
    if(rewarded){
      RewardedInterstitialAd.load(
        adUnitId: AdHelper.bannerAdUnitId,
        request: const AdRequest(),
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            _rewardedInterstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedInterstitialAd failed to load: $error');
          },
        ));
      return;
    }
    InterstitialAd.load(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint("AD LOADED");
          _interstitialAd = ad;
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (error) {
          debugPrint("AD FAILED");
          _interstitialAd?.dispose();
          Navigator.pop(context);
        },
      )
    );
  }
  void showInterstitialAd(bool rewarded) async {
    if(rewarded){
      if(_rewardedInterstitialAd == null){
        Navigator.pop(context);
      }
      debugPrint("AD SHOWED");
      _rewardedInterstitialAd!.show(
        onUserEarnedReward: (ad, reward) {
          
        },
      );
      _rewardedInterstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          _rewardedInterstitialAd?.dispose();
          ad.dispose();
          debugPrint("AD CLOSED");
          Navigator.pop(context);
        },
        onAdFailedToShowFullScreenContent:(ad, error) {
          _rewardedInterstitialAd?.dispose();
          ad.dispose();
          debugPrint("AD CLOSED");
          Navigator.pop(context);
        },
      );
    }
    if(_interstitialAd == null){
      Navigator.pop(context);
    }
    debugPrint("AD SHOWED");
    _interstitialAd!.show();
    _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        _interstitialAd?.dispose();
        ad.dispose();
        debugPrint("AD FAILED");
        Navigator.pop(context);
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _rewardedInterstitialAd?.dispose();
        ad.dispose();
        debugPrint("AD FAILED");
        Navigator.pop(context);
      },
    );
  }
}