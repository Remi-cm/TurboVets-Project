import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turbovets/core/utils/colors.dart';

import '../controllers/global_provider.dart';
import '../services/global_methods.dart';

class GradientWrapper extends StatelessWidget {
  final Widget child;
  const GradientWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<GlobalProvider>(context).isDark;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(right: 40, top: -100, child: Image.asset(imageAsset("shadow.png"), color: isDark ? secondaryColor.withValues(alpha: 0.15) : goldColor.withValues(alpha: 0.15))),
          Positioned(left: 0, bottom: -100, child: Image.asset(imageAsset("shadow.png"), color: isDark ? primaryColor.withValues(alpha: 0.25) : primaryColor.withValues(alpha: 0.2))),
          child
        ],
      ),
    );
  }
}