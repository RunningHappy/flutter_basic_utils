import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';
import 'package:tapped/tapped.dart';

///
/// 基础 header 多个导航
///
class BasicHeader extends StatefulWidget {
  final List<String>? titleList;
  final Function? onSearch;

  const BasicHeader({
    Key? key,
    this.titleList,
    this.onSearch,
  }) : super(key: key);

  @override
  _BasicHeaderState createState() => _BasicHeaderState();
}

class _BasicHeaderState extends State<BasicHeader> {
  int currentSelect = 0;

  @override
  Widget build(BuildContext context) {
    List<String> list = widget.titleList ?? ['推荐', '本地'];
    List<Widget> headList = [];
    for (var i = 0; i < list.length; i++) {
      headList.add(Expanded(
        child: GestureDetector(
          child: SelectText(
            title: list[i],
            isSelect: i == currentSelect,
          ),
          onTap: () {
            setState(() {
              currentSelect = i;
            });
          },
        ),
      ));
    }
    Widget headSwitch = Row(
      children: headList,
    );
    return Container(
      // color: Colors.black.withOpacity(0.3),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Tapped(
              child: Container(
                color: Colors.black.withOpacity(0),
                padding: const EdgeInsets.all(4),
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.search,
                  color: Colors.white.withOpacity(0.66),
                ),
              ),
              onTap: widget.onSearch,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.black.withOpacity(0),
              alignment: Alignment.center,
              child: headSwitch,
            ),
          ),
          Expanded(
            child: Tapped(
              child: Container(
                color: Colors.black.withOpacity(0),
                padding: const EdgeInsets.all(4),
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.tv,
                  color: Colors.white.withOpacity(0.66),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
