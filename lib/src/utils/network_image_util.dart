import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// 网络图片加载类,作为异常处理
class MyNetWorkImage extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;
  final String? defImagePath;
  final BoxFit? fit;
  final Widget? placeHodlerWidget;

  const MyNetWorkImage(
      {Key? key,
      required this.url,
      this.width,
      this.height,
      this.defImagePath,
      this.fit,
      this.placeHodlerWidget})
      : super(key: key);

  @override
  _MyNetWorkImageState createState() => _MyNetWorkImageState();
}

class _MyNetWorkImageState extends State<MyNetWorkImage> {
  ImageStream? stream;
  ImageStreamListener? _imageStreamListener;
  Image? _image;
  Widget? _cacheImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initImage();
  }

  void initCacheImage() {
    _cacheImage = CachedNetworkImage(
      imageUrl: widget.url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              colorFilter:
                  const ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
        ),
      ),
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  void initImage() {
    if ((widget.url == null || widget.url == '') &&
        widget.placeHodlerWidget != null) {
      setState(() {
        _image = widget.placeHodlerWidget as Image?;
      });
      return;
    }
    _image = Image(
      image: CachedNetworkImageProvider(widget.url),
      width: widget.width,
      height: widget.height,
      fit: widget.fit ?? BoxFit.cover,
    );
    if (_image == null) {
      initCacheImage();
    }
    // _image = Image.network(
    //   widget.url,
    //   width: widget.width,
    //   height: widget.height,
    //   fit:widget.fit ?? BoxFit.cover,
    // );
    stream = _image!.image.resolve(ImageConfiguration.empty);
    _imageStreamListener = ImageStreamListener((_, __) {},
        onError: (dynamic exception, StackTrace? stackTrace) {
      // todo 加载异常显示默认图片
      setState(() {
        if (widget.placeHodlerWidget != null) {
          _image = widget.placeHodlerWidget as Image?;
        }
      });
    });
    stream!.addListener(_imageStreamListener!);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _image!;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    stream?.removeListener(_imageStreamListener!);
  }
}
