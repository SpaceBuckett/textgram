import 'dart:math';

import 'package:flutter/material.dart';
import 'package:utor_technical_round/utils/constants/colors.dart';

Color getRandomColor() {
  Random random = Random();
  int randomNumber = random.nextInt(8);
  if (randomNumber < colors.length) return colors[randomNumber];
  return colors[0];
}
