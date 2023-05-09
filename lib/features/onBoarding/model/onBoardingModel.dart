import 'package:bus_navigation/core/utils/utils.dart';
import 'package:flutter/material.dart';

class OnboardingModel {
  final String title;
  final String description;
  final String image;
  final Color bgColor;
  final Color textColor;

  OnboardingModel(
      {required this.title,
      required this.description,
      required this.image,
      this.bgColor = Colors.blue,
      this.textColor = Colors.white});
}
