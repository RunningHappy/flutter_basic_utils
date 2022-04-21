import 'dart:io';
import 'package:app_assembly/src/utils/base.dart';
import 'package:app_assembly/src/widgets/toast/hq_loading.dart';
import 'package:flutter/material.dart';

///
/// app 通用头部组件
///
class CommonHeader extends StatefulWidget {
  final double? height;
  final double opacity;
  final BoxDecoration? decoration;
  final Function? onTapCallback;

  const CommonHeader(
      {Key? key,
      this.height,
      this.opacity = 1.0,
      this.decoration,
      this.onTapCallback})
      : super(key: key);

  @override
  _CommonHeader createState() => _CommonHeader();
}

class _CommonHeader extends State<CommonHeader> with HQBase {
  final TextEditingController _search = TextEditingController();

  // ScanResult _scanResult;

  Future _scan() async {
    // try {
    //   _scanResult = await BarcodeScanner.scan();
    //   if (_scanResult.rawContent != '') {
    //     _search.text = _scanResult.rawContent;
    //   }
    // } on PlatformException catch (e) {
    //   if (e.code == BarcodeScanner.cameraAccessDenied) {
    //     HQDialog.alert(context, text: '设备未获得权限');
    //   } else {
    //     HQDialog.alert(context, text: '未捕获的错误: $e');
    //   }
    // }
  }

  _onTap(index) {
    HQDialog.showLoading(context);
    if (widget.onTapCallback != null) {
      widget.onTapCallback!.call(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? HQBase.statusBarHeight + dp(55),
      width: HQBase.screenWidth,
      decoration: widget.decoration ??
          const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xffff8633),
                Color(0xffff6634),
              ],
            ),
          ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Positioned(
            bottom: dp(10),
            child: Opacity(
              opacity: widget.opacity,
              child: SizedBox(
                width: HQBase.screenWidth - dp(30),
                height: dp(60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(dp(20)),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          _onTap(0);
                        },
                        child: Image.asset(
                          'img/head/default-avatar.webp',
                          width: dp(60),
                          height: dp(60),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: dp(55),
                        margin: EdgeInsets.only(left: dp(15)),
                        padding: EdgeInsets.only(left: dp(5), right: dp(5)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(dp(35 / 2)),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            // 搜索ICON
                            Image.asset(
                              'img/head/search.webp',
                              width: dp(40),
                              height: dp(25),
                            ),
                            // 搜索输入框
                            Expanded(
                              flex: 1,
                              child: TextField(
                                controller: _search,
                                cursorColor: HQBase.defaultColor,
                                cursorWidth: 1.5,
                                style: const TextStyle(
                                  color: HQBase.defaultColor,
                                  fontSize: 14.0,
                                ),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  contentPadding: EdgeInsets.all(0),
                                  hintText: '搜你喜欢的主播吧～',
                                ),
                              ),
                            ),
                            Platform.isAndroid
                                ? GestureDetector(
                                    onTap: _scan,
                                    child: Image.asset(
                                      'img/head/camera.webp',
                                      width: dp(40),
                                      height: dp(25),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: dp(10)),
                      child: GestureDetector(
                        onTap: () {
                          _onTap(1);
                        },
                        child: Image.asset(
                          'img/head/history.webp',
                          width: dp(40),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: dp(10)),
                      child: GestureDetector(
                        onTap: () {
                          _onTap(2);
                        },
                        child: Image.asset(
                          'img/head/game.webp',
                          width: dp(40),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: dp(10)),
                      child: GestureDetector(
                        onTap: () {
                          _onTap(3);
                        },
                        child: Image.asset(
                          'img/head/chat.webp',
                          width: dp(40),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
