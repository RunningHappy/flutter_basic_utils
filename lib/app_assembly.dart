library app_assembly;

export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
export 'package:flutter_easyloading/flutter_easyloading.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:permission_handler/permission_handler.dart';
export 'package:image_picker/image_picker.dart';
export 'package:path_provider/path_provider.dart';
export 'package:flutter_image_compress/flutter_image_compress.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:flutter_swiper_plus/flutter_swiper_plus.dart';


/// style
export 'src/style/style.dart';

/// utils
// 事件
export 'src/utils/event_bus_util.dart';
export 'src/utils/bundle_util.dart';
// 存储
export 'src/utils/local_storage_util.dart';
export 'src/utils/shared_preferences_util.dart';
// 校验
export 'src/utils/number_text_input_formatter_util.dart';
export 'src/utils/validator_util.dart';
export 'src/utils/precision_limit_formatter_util.dart';
// toast
export 'src/utils/easy_loading_util.dart';
// 设置退出到手机桌面，仅Android可用
export 'src/utils/android_back_desktop_util.dart';
// 打印类，仅Android可用
export 'src/utils/log_util.dart';
// 图片
export 'src/utils/image_util.dart';
export 'src/utils/network_image_util.dart';
// index
export 'src/utils/index_util.dart';
// sizes
export 'src/utils/sizes_util.dart';
// ThemeData 配置
export 'src/utils/theme_data_util.dart';
// 中英文配置
export 'src/utils/locales_util/fz_localization_delegate.dart';
export 'src/utils/locales_util/more_localization.dart';
// 获取Widget宽高，在屏幕上的坐标，获取网络/本地图片尺寸
export 'src/utils/widget_util.dart';
// 日期转换格式化输出
export 'src/utils/date_util.dart';
// 正则验证手机号，身份证，邮箱等等
export 'src/utils/regex_util.dart';
// 判断对象是否为空(String List Map),判断两个List是否相等.
export 'src/utils/object_util.dart';
// 银行卡号每隔4位加空格，每隔3三位加逗号，隐藏手机号等等.
export 'src/utils/text_util.dart';




/// widgets
// page
export 'src/widgets/page/order_list_frame.dart';
export 'src/widgets/page/my_customer_frame.dart';
export 'src/widgets/page/scroll_stop_table_frame.dart';
// 导航栏
export 'src/widgets/appbar/common_search_bar.dart';
export 'src/widgets/appbar/common_trans_appbar.dart';
export 'src/widgets/appbar/appbar_get.dart';
export 'src/widgets/appbar/appbar_new.dart';
export 'src/widgets/appbar/appbar_opacity.dart';
export 'src/widgets/appbar/appbar_search.dart';
export 'src/widgets/appbar/hq_app_bar.dart';
export 'src/widgets/appbar/custom_appbar.dart';
export 'src/widgets/appbar/custom_switch_appbar.dart';
// 按钮
export 'src/widgets/button/common_gradient_btn.dart';
export 'src/widgets/button/lsj_button.dart';
export 'src/widgets/button/button_common.dart';
export 'src/widgets/button/button_login.dart';
export 'src/widgets/button/button_more_color_login.dart';
export 'src/widgets/button/button_detail.dart';
export 'src/widgets/button/button_icon_title.dart';
export 'src/widgets/button/button_left_icon_right_text.dart';
export 'src/widgets/button/button_left_text_right_icon.dart';
export 'src/widgets/button/button_top_icon_bottom_text.dart';
export 'src/widgets/button/button_top_text_bottom_icon.dart';
export 'src/widgets/button/button_message_avatar_num.dart';
export 'src/widgets/button/button_message_top_icon_bottom_text.dart';
export 'src/widgets/button/button_loading.dart';
export 'src/widgets/button/button_gradient.dart';
export 'src/widgets/button/ios_back_button.dart';
export 'src/widgets/button/cycle_button.dart';
// 表单-输入框
export 'src/widgets/form/common_textfiled.dart';
export 'src/widgets/form/text_area.dart';
export 'src/widgets/form/textfield_common.dart';
export 'src/widgets/form/textfield_right_left_text.dart';
export 'src/widgets/form/textfield_code.dart';
export 'src/widgets/form/textfield_password.dart';
export 'src/widgets/form/textfield_pay_password.dart';
export 'src/widgets/form/textfield_phone.dart';
export 'src/widgets/form/textfield_search.dart';
export 'src/widgets/form/textfield_star_view.dart'; // 样式：*文本：输入框（视图）
export 'src/widgets/form/textfield_star_view_item.dart'; // 样式：*文本：输入框（视图）
// 弹出框
export 'src/widgets/pop_alert/pop_center_frame_alert.dart';
export 'src/widgets/pop_alert/pop_bottom_show_big_sheet.dart';
export 'src/widgets/pop_alert/pop_bottom_frame_sheet.dart';
export 'src/widgets/pop_alert/pop_my_image_action_alert.dart';
export 'src/widgets/pop_alert/pop_confirm_alert.dart';
// text
export 'src/widgets/text/select_text.dart';
//switchCell
export 'src/widgets/cell/common_title_switch_view.dart';
// Cell 单元格
export 'src/widgets/cell/cell_line.dart';
// 单选框
export 'src/widgets/select_box/radio_box.dart';
// 复选框
export 'src/widgets/select_box/check_box.dart';
// 同意某协议
export 'src/widgets/agreement/agree_agreement.dart';
// Form 表单外必须包裹，点击隐藏键盘
export 'src/widgets/form/form_hide_keyboard_widget.dart';
// 空页面
export 'src/widgets/empty_widget.dart';
// 错误 widget(由于数据错误导致的错误)
export 'src/widgets/error_widget.dart';
// 成功 toast
export 'src/widgets/toast/toast_success.dart';
// 跑马灯
export 'src/widgets/marquee_horizontal.dart';
// 日期/时间选择器
export 'src/widgets/picker/custom_month_picker.dart';
// 星级评分
export 'src/widgets/rate_star.dart';
// 步骤条
export 'src/widgets/steps_bar.dart';
// 数量+/-
export 'src/widgets/stepper_num.dart';
// 弹出菜单
export 'src/widgets/pop_menu/pop_menu_alert.dart';
// 日历选择器
export 'src/widgets/calender/show_calendar_bottom_sheet.dart';
//上拉抽屉效果
export 'src/widgets/uppanel/sliding_up_panel.dart';
//中间凸起bottombar
export 'src/widgets/uppanel/center_floating_bottom_bar.dart';
//图片浏览与下载
export 'src/widgets/uppanel/common_see_image_view.dart';
//banner
export 'src/widgets/banner/common_banner.dart';
export 'src/widgets/banner/common_segment.dart';