import 'package:app_assembly/app_assembly.dart';
import 'package:app_assembly/src/widgets/text/ad_music_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tapped/tapped.dart';

///
/// 带 loading 的按钮
///
class AdMusicLoadingButton extends StatelessWidget {
  const AdMusicLoadingButton({
    Key? key,
    required this.buttonText,
    this.onTap,
    this.isLoading = false,
    this.primary = true,
    this.margin,
    this.height,
    this.backGroundColor,
    this.shadow = false,
    this.textColor,
  }) : super(key: key);

  final String buttonText;
  final Function? onTap;
  final bool isLoading;
  final bool primary;
  final bool shadow;
  final EdgeInsets? margin;
  final double? height;
  final Color? backGroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var body = Container(
      height: height ?? 44,
      width: double.infinity,
      padding: margin ?? const EdgeInsets.symmetric(horizontal: 60),
      color: ColorPlate.clear,
      child: Container(
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            shape: const StadiumBorder(),
            shadows: shadow
                ? [
                    BoxShadow(
                      color: ColorPlate.black.withOpacity(0.1),
                    )
                  ]
                : [],
            color: backGroundColor ??
                (primary ? ColorPlate.orange : ColorPlate.white),
          ),
          child: IndexedStack(
            alignment: Alignment.center,
            index: isLoading ? 0 : 1,
            children: <Widget>[
              const CupertinoActivityIndicator(),
              AdMusicText.normal(
                buttonText,
                enableOffset: true,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: textColor ??
                      (primary ? ColorPlate.white : ColorPlate.orange),
                ),
              ),
            ],
          )),
    );
    return Tapped(
      onTap: () {
        if (!isLoading) {
          onTap?.call();
        }
      },
      child: body,
    );
  }
}
