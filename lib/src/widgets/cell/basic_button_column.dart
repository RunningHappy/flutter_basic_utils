import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';
import 'package:tapped/tapped.dart';

///
/// 基础纵向按钮column
///
class BasicButtonColumn extends StatelessWidget {
  final double? bottomPadding;
  final bool isFavorite;
  final Function? onFavorite;
  final Function? onComment;
  final Function? onShare;
  final Function? onAvatar;

  const BasicButtonColumn({
    Key? key,
    this.bottomPadding,
    this.onFavorite,
    this.onComment,
    this.onShare,
    this.isFavorite = false,
    this.onAvatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SystemFontSize.avatar,
      margin: EdgeInsets.only(
        bottom: bottomPadding ?? 50,
        right: 12,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Tapped(
            child: const BasicAvatar(),
            onTap: onAvatar,
          ),
          FavoriteIcon(
            onFavorite: onFavorite,
            isFavorite: isFavorite,
          ),
          _IconButton(
            icon: const IconToText(Icons.mode_comment,
                size: SystemFontSize.iconBig - 4),
            text: '4213',
            onTap: onComment,
          ),
          _IconButton(
            icon: const IconToText(Icons.share, size: SystemFontSize.iconBig),
            text: '346',
            onTap: onShare,
          ),
          Container(
            width: SystemFontSize.avatar,
            height: SystemFontSize.avatar,
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SystemFontSize.avatar / 2.0),
              // color: Colors.black.withOpacity(0.8),
            ),
          )
        ],
      ),
    );
  }
}

class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon({
    Key? key,
    required this.onFavorite,
    this.isFavorite,
  }) : super(key: key);
  final bool? isFavorite;
  final Function? onFavorite;

  @override
  Widget build(BuildContext context) {
    return _IconButton(
      icon: IconToText(
        Icons.favorite,
        size: SystemFontSize.iconBig,
        color: isFavorite! ? ColorPlate.red : null,
      ),
      text: '1.0w',
      onTap: onFavorite,
    );
  }
}

class BasicAvatar extends StatelessWidget {
  const BasicAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget avatar = Container(
      width: SystemFontSize.avatar,
      height: SystemFontSize.avatar,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(SystemFontSize.avatar / 2.0),
        color: Colors.orange,
      ),
      child: ClipOval(
        child: Image.network(
          "https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif",
          fit: BoxFit.cover,
        ),
      ),
    );
    Widget addButton = Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorPlate.orange,
      ),
      child: const Icon(
        Icons.add,
        size: 16,
      ),
    );
    return Container(
      width: SystemFontSize.avatar,
      height: 66,
      margin: const EdgeInsets.only(bottom: 6),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[avatar, addButton],
      ),
    );
  }
}

/// 把IconData转换为文字，使其可以使用文字样式
class IconToText extends StatelessWidget {
  final IconData? icon;
  final TextStyle? style;
  final double? size;
  final Color? color;

  const IconToText(
    this.icon, {
    Key? key,
    this.style,
    this.size,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      String.fromCharCode(icon!.codePoint),
      style: style ??
          TextStyle(
            fontFamily: 'MaterialIcons',
            fontSize: size ?? 30,
            inherit: true,
            color: color ?? ColorPlate.white,
          ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final Widget? icon;
  final String? text;
  final Function? onTap;

  const _IconButton({
    Key? key,
    this.icon,
    this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shadowStyle = TextStyle(
      shadows: [
        Shadow(
          color: Colors.black.withOpacity(0.15),
          offset: const Offset(0, 1),
          blurRadius: 1,
        ),
      ],
    );
    Widget body = Column(
      children: <Widget>[
        Tapped(
          child: icon ?? Container(),
          onTap: onTap,
        ),
        Container(height: 2),
        Text(
          text ?? '??',
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: SystemFontSize.small,
            color: ColorPlate.white,
          ),
        ),
      ],
    );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: DefaultTextStyle(
        child: body,
        style: shadowStyle,
      ),
    );
  }
}
