import 'package:flutter/material.dart';

class TrainingModel {
  final int id;
  final Offset offset;
  final double duration;
  final String title;

  TrainingModel({
    required this.id,
    required this.offset,
    required this.duration,
    required this.title,
  });
}
