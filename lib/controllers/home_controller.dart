import 'dart:async';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_app/models/training.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  List<TrainingModel> trainingModels = [
    TrainingModel(
      id: 1,
      offset: const Offset(50, 600),
      duration: 5,
      title: 'InHale',
    ),
    TrainingModel(
      id: 2,
      offset: const Offset(100, 100),
      duration: 6,
      title: 'Retain',
    ),
    TrainingModel(
      id: 3,
      offset: const Offset(200, 100),
      duration: 6,
      title: 'Exhale',
    ),
    TrainingModel(
      id: 4,
      offset: const Offset(300, 600),
      duration: 3,
      title: 'Sustain',
    ),
    TrainingModel(
      id: 5,
      offset: const Offset(400, 600),
      duration: 3,
      title: '',
    ),
  ];

  List<Offset> nodes = [];
  List<int> durations = [];

  late AnimationController controller;
  late Animation<Offset> animation;
  late AnimationController animationController;

  RxInt currentIndex = 0.obs;
  RxDouble currentDuration = 0.0.obs;
  RxString currentTitle = 'Calming'.obs;
  RxBool isPlaying = false.obs;
  RxBool isPausing = false.obs;
  RxBool isReady = false.obs;

  Future<void> playAnimation() async {
    if (animationController.isAnimating) {
      return;
    }

    isPlaying(true);
    currentIndex(0);
    animationController.reset();
    animationController.forward(from: 0.0);
    currentTitle(trainingModels[currentIndex.value].title);
  }

  void stopAnimation() {
    isPausing.value = true;
    animationController.stop();
  }

  void resumeAnimation() {
    if (!animationController.isAnimating) {
      isPausing(false);
      animationController.forward();
    }
  }

  void pauseAnimation() {
    if (animationController.isAnimating) {
      animationController.stop();
    }
  }

  @override
  void onInit() {
    super.onInit();
    nodes = trainingModels.map((e) => e.offset).toList();
    durations = trainingModels.map((e) => e.duration.toInt()).toList();

    // Tạo animation controller
    animationController = AnimationController(
      duration: const Duration(seconds: 69),
      vsync: this,
    );

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: durations[currentIndex.value]),
    );

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        currentIndex.value++;

        if (currentIndex.value >= nodes.length - 1) {
          currentIndex.value = 0;
          animationController.stop();
          isPlaying.value = false;
          return;
        }

        animation = TweenSequence([
          TweenSequenceItem(
            tween: Tween<Offset>(
              begin: nodes[currentIndex.value],
              end: nodes[currentIndex.value + 1],
            ),
            weight: 1,
          ),
        ]).animate(animationController);

        animationController.duration =
            Duration(seconds: durations[currentIndex.value]);
        animationController.forward(from: 0.0);
      }
    });

    animation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: nodes[currentIndex.value],
          end: nodes[currentIndex.value + 1],
        ),
        weight: 1,
      ),
    ]).animate(animationController);

    ever(currentIndex, (currentIndexNew) {
      if (currentIndex.value == trainingModels.length - 1) {
        isPlaying.value = false;
      }
      currentDuration.value =
          trainingModels[currentIndexNew].duration.toDouble();
      countDown();
      currentTitle(trainingModels[currentIndex.value].title);
    });
  }

  void countDown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentDuration.value > 0) {
        currentDuration.value--;
      }
      if (currentDuration.value <= 0) {
        timer.cancel();
      }
    });
  }

  Future<void> isReadyToPlay() async {
    isReady.value = true;
    // Claming 3s, prepare 3s.
    // currentDuration(3);
    // countDown();
    // await Future.delayed(const Duration(seconds: 3));
    // currentTitle('Repare');
    // currentDuration(3);
    // countDown();
    // await Future.delayed(const Duration(seconds: 3));
  }
}
