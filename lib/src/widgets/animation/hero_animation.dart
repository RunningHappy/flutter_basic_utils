import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// hero 转场动画
class HeroAnimation extends StatelessWidget {
  final Widget? child;
  const HeroAnimation({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("hero 转场动画")),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => NewPage(child: child),
                          fullscreenDialog: true));
                },
                child: Hero(
                  tag: "imgTag",
                  child: Container(
                    margin: EdgeInsets.only(top: 200.h),
                    color: Colors.red,
                    width: 300.w,
                    height: 300.w,
                    alignment: Alignment.center,
                    child: const Text("跳转", style: StandardTextStyle.big),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  final Widget? child;
  const NewPage({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Hero(
                        tag: "imgTag",
                        child: Container(color: Colors.red, height: 500.h))),
              )
            ],
          ),
          SizedBox(height: 30.h),
          const Text('阿斯达大所大所多'),
          SizedBox(height: 30.h),
          const Text('阿斯达大所大所多'),
          SizedBox(height: 30.h),
          const Text('阿斯达大所大所多'),
          SizedBox(height: 30.h),
          const Text('阿斯达大所大所多')
        ],
      ),
    );
  }
}
