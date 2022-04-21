import 'package:app_assembly/src/utils/base.dart';
import 'package:flutter/material.dart';

///
/// 点击图片放大显示
///
class AnimalPhoto {
  AnimalPhoto.show(BuildContext context, String url, {double? width}) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(10.0),
        alignment: Alignment.center,
        child: _PhotoHero(
          photo: url,
          width: width ?? HQBase.screenWidth,
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      );
    }));
  }
}

class _PhotoHero extends StatelessWidget {
  const _PhotoHero(
      {Key? key, required this.photo, required this.onTap, required this.width})
      : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.network(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
