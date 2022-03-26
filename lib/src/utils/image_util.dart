import 'dart:convert';
import 'dart:io';
import 'package:app_assembly/app_assembly.dart';
import 'package:app_assembly/src/utils/index_util.dart';
import 'package:app_assembly/src/widgets/pop_alert/pop_my_image_action_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageUtil {
  static Function? _imageInfoCallback;
  static BuildContext? _mContext;

  static void showActionSheet(BuildContext context, Function callback) {
    _imageInfoCallback = callback;
    _mContext = context;
    hideKeyboard(_mContext!);
    MyActionSheet.showMyActionSheet(context, ["拍照上传", "相册选择"], onTap: (index) {
      _requestPermission(context, index);
    });
  }

  // 申请权限
  static Future<void> _requestPermission(
      BuildContext context, int index) async {
    MyActionSheet.disMissActionSheet(_mContext!);
    bool isCameraPermissions = await requestPermissions(
        index == 0 ? [Permission.camera] : [Permission.photos]);
    if (isCameraPermissions) {
      _selectFigure(index == 0 ? ImageSource.camera : ImageSource.gallery);
    } else {
      EasyLoadingHelper.showToast(
          '您禁止了${index == 0 ? '相机' : '相册'}访问权限,需要在权限设置中打开!');
    }
  }

  static Future<void> _selectFigure(ImageSource source) async {
    var image = await ImagePicker().getImage(source: source);
    String? originalPath = image?.path;
    if (originalPath != null) {
      // 图片压缩
      File file = await imageCompressAndGetFile(File(originalPath));
      String compressPath = file.absolute.path;
      // 上传图片
      _imageInfoCallback!(compressPath);
    }
  }

  // 图片压缩
  static Future<File> imageCompressAndGetFile(File file) async {
    // 500KB 作为压缩标准
    if (file.lengthSync() < 0.5 * 1024 * 1024) {
      return file;
    }
    var quality = 100;
    if (file.lengthSync() > 4 * 1024 * 1024) {
      quality = 50;
    } else if (file.lengthSync() > 2 * 1024 * 1024) {
      quality = 65;
    } else if (file.lengthSync() > 0.5 * 1024 * 1024) {
      quality = 75;
    }
    var dir = await getTemporaryDirectory();
    var targetPath = dir.absolute.path +
        "/" +
        DateTime.now().millisecondsSinceEpoch.toString() +
        ".jpg";
    File? result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, targetPath,
        quality: quality);

    debugPrint("压缩前：${file.lengthSync() / 1024}");
    debugPrint("压缩后：${result!.lengthSync() / 1024}");

    return result;
  }

  // 图片转Base64
  static Future image2Base64(String path) async {
    File file = File(path);
    List<int> imageBytes = await file.readAsBytes();
    return base64Encode(imageBytes);
  }
}
