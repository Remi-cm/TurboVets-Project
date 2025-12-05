
import 'package:flutter/material.dart';

import '../utils/colors.dart';

Widget width(double value) => SizedBox(width: value);
Widget height(double value) => SizedBox(height: value);

Widget buildCircleAvatar({required double radius, Color? color = primaryColor, String? imageUrl, List<Color>? gradientColors, Color? borderColor, Function()? onTap, required Widget child}) => GestureDetector(
  onTap: onTap,
  child: Container(
    height: radius*2,
    width: radius*2, 
    decoration: BoxDecoration(
      shape: BoxShape.circle, 
      color: color, 
      image: imageUrl != null ? DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover) : null,
      border: borderColor != null ? Border.all(color: borderColor) : null, 
      gradient: gradientColors == null ? null : LinearGradient(colors: gradientColors)
    ), 
    child: Center(child: child)
  ),
);