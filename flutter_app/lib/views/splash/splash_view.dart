import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:turbovets/core/components/gradient_wrapper.dart';
import 'package:turbovets/core/services/global_methods.dart';
import 'package:turbovets/core/utils/colors.dart';

import '../../core/controllers/global_provider.dart';
import '../../core/services/local_database.dart';
import '../../router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    onInit();
    super.initState();
  }

  onInit() async {
    GlobalProvider globalProvider = Provider.of<GlobalProvider>(context, listen: false);
    bool isDark = await LocalDatabase().getTheme();
    globalProvider.setTheme(isDark);
    await Future.delayed(const Duration(milliseconds: 1000));
    if(mounted) context.go(home);
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<GlobalProvider>(context).isDark;
    return GradientWrapper(
      child: Scaffold(
        backgroundColor: whiteColor.withValues(alpha: 0),
        body: Center(
          child: Image.asset(imageAsset(isDark ? "LogoDark.png" : "LogoLight.png"), width: 270,),
        ),
      ),
    );
  }
}