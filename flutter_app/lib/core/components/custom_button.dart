import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/global_provider.dart';
import '../utils/colors.dart';

class CustomButton extends StatelessWidget {
  
  final String text;
  final String? iconPath, loadingText, fontFamily;
  final double? fontSize, width, radius, iconSpacing, height, iconSize; 
  final bool? isLoading, enabled, noColor; 
  final EdgeInsets? padding;
  final DateTime? loadingTimeout;
  final FontWeight? fontWeight;
  final Color? textColor, iconColor,  color, borderColor, startColor, endColor;
  final Function() onTap;
  final Function()? onTimeout; 
  final IconData? icon, suffixIcon, prefixIcon;
  final Widget? prefix, suffix, textWidget;

  const CustomButton({super.key, required this.text, this.iconPath, this.textWidget, this.fontSize, this.width, this.noColor, this.radius, this.suffix, this.suffixIcon, this.prefixIcon, this.padding, this.prefix, this.fontFamily, this.loadingText, this.fontWeight, this.loadingTimeout, this.iconSpacing, this.height, this.iconSize, this.isLoading, this.enabled, this.textColor, this.iconColor, this.color, this.borderColor, this.startColor, this.endColor, this.onTimeout, required this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<GlobalProvider>(context).isDark;
    bool isDisabled = enabled == false || isLoading == true;
    bool onlyInactive = enabled == false && isLoading != true;
    Color? buttonColor = isDisabled ? (isDark ? Colors.grey[600] : Colors.grey.withValues(alpha: 0.5)) : (color ?? (noColor == true ? Theme.of(context).secondaryHeaderColor : color));

    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Stack(
        children: [
          Container(
            height: height ?? 55,
            width: width,
            constraints: const BoxConstraints(maxHeight: 60),
            padding: EdgeInsets.symmetric(vertical: isLoading == true ? 0 : 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius ?? 50),
              color: buttonColor ?? (primaryColor),
              border: isDisabled ? null : (borderColor != null ? Border.all(color: borderColor!, width: 1.5) : null),
            ),
            child: isDisabled ? SizedBox(width: double.infinity, child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(!onlyInactive)
                //LoadingAnimationWidget.inkDrop(color: , size: 22),
                SizedBox(width: 25, height: 25, child: CircularProgressIndicator(color: isDark ? blackColor : Colors.grey[600],)),
                SizedBox(width: 10,),
                Text(onlyInactive ? text : (loadingText ?? "Loading.."), style: TextStyle(color: Theme.of(context).hintColor, fontWeight: FontWeight.w700, fontFamily: fontFamily, fontSize: fontSize ?? 16),),
                SizedBox(width: 10,)
              ],
            )) 
            : Center(
              child: Column(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isDisabled ? null : onTap,
                      style: ElevatedButton.styleFrom(backgroundColor: buttonColor ?? color ?? Colors.transparent, shadowColor: Colors.transparent, surfaceTintColor: buttonColor ?? color ?? transparentColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 50)), padding: padding ?? const EdgeInsets.all(0)),
                      child: Row(
                        children: [
                          Expanded(child: textWidget ?? Text(text, style: TextStyle(color: textColor ?? (isDark ? blackColor : whiteColor), fontFamily: fontFamily, fontSize: fontSize ?? 16, fontWeight: fontWeight ?? FontWeight.w700), textAlign: TextAlign.center,)),
                        ],
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
          if(prefix != null || prefixIcon != null)
          Positioned(left: 5, child: SizedBox(height: height ?? 55, width: height ?? 55, child: Center(child: prefix ?? Icon(prefixIcon, color: iconColor ?? textColor ?? Theme.of(context).scaffoldBackgroundColor, size: iconSize ?? 25,)))),
          if(suffix != null || suffixIcon != null || iconPath != null)
          Positioned(
            right: 20, 
            child: SizedBox(
              height: height ?? 55, 
              width: height, 
              child: Center(
                child: suffix ?? (iconPath != null ? (Image.asset(iconPath!, width: iconSize ?? 30, color: iconColor,)) : Icon(suffixIcon, size: iconSize ?? 25, color: iconColor ?? textColor ?? Theme.of(context).scaffoldBackgroundColor,))
              )
            )
          )
        ],
      ),
    );
  }
}