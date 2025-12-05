import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:turbovets/core/components/gradient_wrapper.dart';
import 'package:turbovets/router.dart';

import '../../core/components/custom_button.dart';
import '../../core/components/global_components.dart';
import '../../core/controllers/global_provider.dart';
import '../../core/services/global_methods.dart';
import '../../core/utils/colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    super.initState();
    onInit();
  }

  onInit() async {}

  @override
  Widget build(BuildContext context) {
    GlobalProvider provider = Provider.of<GlobalProvider>(context);
    return GradientWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: false,
          title: Row(
            children: [
              buildCircleAvatar(radius: 20, color: Theme.of(context).dividerColor, borderColor: Theme.of(context).dividerColor, child: Icon(FluentIcons.person_12_regular,)),
              width(7),
              Text("John Doe", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
            ],
          ),
          actions: [
            CustomButton(
              text: provider.isDark ? "Try Light Mode" : "Try Dark Mode",
              fontSize: 12,
              width: 120,
              height: 40,
              onTap: ()=>provider.setTheme(!provider.isDark)
            ),
            width(20)
          ],
        ),
        body: Column(
          children: [
            width(double.infinity),
            height(5),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    height(20),
                    Text(
                      "What are we\ndoing today ?", 
                      style: TextStyle(
                        fontSize: 37, 
                        letterSpacing: -1.5,
                        fontWeight: FontWeight.w800, 
                        height: 1
                      ), 
                      textAlign: TextAlign.center
                    ),
                    height(20),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildHomeActionCard(
                          title: "Go to dashboard",
                          iconBorderColor: primaryColor,
                          iconWidget: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(FluentIcons.data_pie_16_regular, color: primaryColor, size: 25,),
                              Icon(FluentIcons.data_histogram_16_regular, color: primaryColor, size: 25,),
                            ],
                          ),
                          onTap: ()=>context.push(dashboard)
                        ),
                        width(wv(context)*5),
                        _buildHomeActionCard(
                          title: "Check latest articles", 
                          icon: FluentIcons.text_12_filled, 
                          iconSize: 20, 
                          onTap: (){}
                        ),
                      ],
                    ),
                    height(wv(context)*5),
                    // Some random features that we can define later, maybe a Turbovets personal video calling service
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildHomeActionCard(
                          title: "Some random feature ", 
                          icon: FluentIcons.arrow_up_right_12_regular, 
                          onTap: (){}
                        ),
                        width(wv(context)*5),
                        _buildHomeActionCard(
                          title: "Some random feature ", 
                          icon: FluentIcons.arrow_down_left_12_regular, 
                          onTap: (){}
                        ),
                      ],
                    ),
                    height(30),
                  ],
                ),
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentDirectional.topCenter,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(26), topRight: Radius.circular(26)),
                    border: Border(top: BorderSide(width: 1.3, color: Theme.of(context).secondaryHeaderColor), right: BorderSide(width: 1.3, color: Theme.of(context).secondaryHeaderColor), left: BorderSide(width: 1.3, color: Theme.of(context).secondaryHeaderColor))
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 300,
                      child: Column(
                        children: [
                          height(60),
                          Text("Start a conversation ...", style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: primaryColor),),
                          height(5),
                          Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                              children: [
                                TextSpan(text: "We have an agent "),
                                TextSpan(text: "always available", style: TextStyle(color: primaryColor)),
                                TextSpan(text: " to assist you in case of need"),
                              ]
                            )
                          ),
                          height(15),
                          CustomButton(
                            text: "Go to chat",
                            suffixIcon: FluentIcons.arrow_right_12_filled,
                            fontSize: 15,
                            iconSize: 18,
                            onTap: ()=>context.push(chatroom)
                          ),
                          height(hv(context)*3+MediaQuery.of(context).padding.bottom)
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -30,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(width: 1.3)
                    ),
                    child: Image.asset(imageAsset("LogoDark.png"), color: Theme.of(context).scaffoldBackgroundColor, width: 75,)
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHomeActionCard({required String title, Color? iconBorderColor, IconData? icon, Widget? iconWidget, double? iconSize, required Function() onTap}){
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        width: isMobile(context) ? wv(context)*40 : 170,
        height: isMobile(context) ? wv(context)*39 : 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          border: Border.all(width: 1.3, color: Theme.of(context).secondaryHeaderColor)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 1.3, color: iconBorderColor ?? Theme.of(context).secondaryHeaderColor)
              ),
              child: icon != null ? Icon(icon, size: iconSize ?? 25) : iconWidget,
            ),
            Row(
              children: [
                Expanded(child: Text(title, style: TextStyle(fontSize: 13.5, height: 1.1, fontWeight: FontWeight.w700),)),
                width(2),
                Icon(FluentIcons.arrow_right_12_filled, size: 18,)
              ],
            )
          ],
        ),
      ),
    );
  }
}