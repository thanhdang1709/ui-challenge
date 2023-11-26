import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/home_controller.dart';
import 'package:flutter_app/widgets/graph_pointer.dart';
import 'package:get/get.dart';

class GraphWidget extends GetView<HomeController> {
  const GraphWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Training'),
        actions: [
          Obx(
            () => controller.isPlaying.value
                ? IconButton(
                    onPressed: controller.stopAnimation,
                    icon: const Icon(Icons.stop),
                  )
                : IconButton(
                    onPressed: controller.playAnimation,
                    icon: const Icon(Icons.play_arrow),
                  ),
          ),
          Obx(() => controller.isPausing.value
              ? IconButton(
                  onPressed: controller.resumeAnimation,
                  icon: const Icon(Icons.play_arrow),
                )
              : const SizedBox())
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 20,
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.currentTitle.toString(),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  controller.isPlaying.value
                      ? Text(
                          controller.currentDuration.toString(),
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                        )
                      : Container()
                ],
              )),
          Expanded(
            child: Stack(
              children: [
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return RadialGradient(
                      center: Alignment.topLeft,
                      radius: 1.0,
                      colors: <Color>[
                        Colors.purple.shade100,
                        Colors.purple.shade900,
                      ],
                      tileMode: TileMode.mirror,
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcIn,
                  child: CustomPaint(
                    painter: GraphPainter(controller.nodes),
                    size: Size.infinite,
                  ),
                ),
                AnimatedBuilder(
                  animation: controller.animation,
                  builder: (BuildContext context, Widget? child) {
                    return Stack(
                      children: [
                        Positioned(
                          left: controller.animation.value.dx - 10,
                          top: controller.animation.value.dy - 10,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 1),
                          width: controller.animation.value.dx,
                          color: Colors.transparent,
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return RadialGradient(
                                center: Alignment.topLeft,
                                radius: 1.0,
                                colors: <Color>[
                                  Colors.purple.shade100,
                                  const Color.fromARGB(255, 161, 223, 231)
                                ],
                                tileMode: TileMode.mirror,
                              ).createShader(bounds);
                            },
                            child: CustomPaint(
                              painter: GraphPainter(controller.nodes,
                                  color:
                                      const Color.fromARGB(255, 161, 223, 231)),
                              size: Size(controller.animation.value.dx,
                                  double.infinity),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: controller.animation,
                  builder: (BuildContext context, Widget? child) {
                    return Stack(
                      children: [
                        Positioned(
                          left: controller.animation.value.dx - 10,
                          top: controller.animation.value.dy - 10,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
