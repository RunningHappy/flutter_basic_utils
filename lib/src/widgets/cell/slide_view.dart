import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';

///
/// 轮播图+点+标题
///
class SlideView extends StatefulWidget {
  final List data;
  final SlideViewIndicator slideViewIndicator;
  final GlobalKey<SlideViewIndicatorState> globalKey;
  final Function? onTapCallback;

  const SlideView(this.data, this.slideViewIndicator, this.globalKey,
      {Key? key, this.onTapCallback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SlideViewState();
  }
}

class SlideViewState extends State<SlideView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List _slideData;

  @override
  void initState() {
    super.initState();
    _slideData = widget.data;
    _tabController = TabController(
        length: _slideData.isEmpty ? 0 : _slideData.length, vsync: this);
    _tabController.addListener(() {
      widget.globalKey.currentState!.setSelectedIndex(_tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget generateCard() {
    return Card(
      color: Colors.blue,
      child: Image.asset(
        "images/ic_avatar_default.png",
        width: 20.0,
        height: 20.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    if (_slideData.isNotEmpty) {
      for (var i = 0; i < _slideData.length; i++) {
        BannerModel item = _slideData[i];
        var imgUrl = item.imgUrl;
        var title = item.title;
        var detailUrl = item.detailUrl;
        items.add(GestureDetector(
          onTap: () {
            // 点击跳转到详情
            if (widget.onTapCallback != null) {
              widget.onTapCallback!.call(detailUrl);
            }
          },
          child: Stack(
            children: <Widget>[
              Image.network(imgUrl,
                  width: MediaQuery.of(context).size.width, fit: BoxFit.cover),
              Container(
                  width: MediaQuery.of(context).size.width,
                  color: const Color(0x50000000),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(title,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 15.0)),
                  ))
            ],
          ),
        ));
      }
    }
    return TabBarView(
      controller: _tabController,
      children: items,
    );
  }
}

class BannerModel {
  late String title;
  late String imgUrl;
  late String detailUrl;

  BannerModel(
      {required this.title, required this.imgUrl, required this.detailUrl});
}
