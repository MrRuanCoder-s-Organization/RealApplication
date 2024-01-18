import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../app/log.dart';

class LocalStorageService extends GetxService {
    static LocalStorageService get instance => Get.find<LocalStorageService>();     //find在存储库中查找该类型实例

    /// 首次运行
    static const String kFirstRun = "FirstRun";

    /// 缩放模式
    static const String kPlayerScaleMode = "ScaleMode";

    /// 网站排序
    static const String kSiteSort = "SiteSort";

    /// 首页排序
    static const String kHomeSort = "HomeSort";

    /// 显示模式
    /// * [0] 跟随系统
    /// * [1] 浅色模式
    /// * [2] 深色模式
    static const String kThemeMode = "ThemeMode";

    /// DEBUG模式
    static const String kDebugModeKey = "DebugMode";

    /// 弹幕大小
    static const String kDanmuSize = "DanmuSize";

    /// 弹幕速度
    static const String kDanmuSpeed = "DanmuSpeed";

    /// 弹幕区域
    static const String kDanmuArea = "DanmuArea";

    /// 弹幕透明度
    static const String kDanmuOpacity = "DanmuOpacity";

    /// 弹幕描边大小
    static const String kDanmuStrokeWidth = "DanmuStrokeWidth";

    /// 弹幕-屏蔽滚动
    static const String kDanmuHideScroll = "DanmuHideScroll";

    /// 弹幕-屏蔽底部
    static const String kDanmuHideBottom = "DanmuHideBottom";

    /// 弹幕-屏蔽顶部
    static const String kDanmuHideTop = "DanmuHideTop";

    /// 弹幕-顶部边距
    static const String kDanmuTopMargin = "DanmuTopMargin";

    /// 弹幕-底部边距
    static const String kDanmuBottomMargin = "DanmuBottomMargin";

    /// 弹幕开启
    static const String kDanmuEnable = "DanmuEnable";

    /// 硬件解码
    static const String kHardwareDecode = "HardwareDecode";

    /// 聊天区文字大小
    static const String kChatTextSize = "ChatTextSize";

    /// 聊天区间隔
    static const String kChatTextGap = "ChatTextGap";

    /// 聊天区-气泡样式
    static const String kChatBubbleStyle = "ChatBubbleStyle";

    /// 播放清晰度，0=低，1=中，2=高
    static const String kQualityLevel = "QualityLevel";

    /// 蜂窝网络下播放清晰度，0=低，1=中，2=高
    static const String kQualityLevelCellular = "QualityLevelCellular";

    /// 开启定时关闭
    static const String kAutoExitEnable = "AutoExitEnable";

    /// 定时关闭时间（分钟）
    static const String kAutoExitDuration = "AutoExitDuration";

    /// 播放器兼容模式
    static const String kPlayerCompatMode = "PlayerCompatMode";

    /// 播放器后台自动暂停
    static const String kPlayerAutoPause = "PlayerAutoPause";

    /// 自动全屏
    static const String kAutoFullScreen = "AutoFullScreen";

    /// 小窗隐藏弹幕
    static const String kPIPHideDanmu = "PIPHideDanmu";

    /// 哔哩哔哩cookie
    static const String kBilibiliCookie = "BilibiliCookie";

    ///主题色
    static const String kStyleColor = "kStyleColor";

    ///动态取色
    static const String kIsDynamic = "kIsDynamic";

    /// 提示哔哩哔哩登录
    static const String kBilibiliLoginTip = "BilibiliLoginTip";

    late Box settingsBox;
    late Box<String> shieldBox;

    Future init() async {
        settingsBox = await Hive.openBox(
                "LocalStorage",
                );
        shieldBox = await Hive.openBox(
                "DanmuShield",
                );
    }

    T getValue<T>(dynamic key, T defaultValue) {
        var value = settingsBox.get(key, defaultValue: defaultValue) as T;
        Log.d("Get LocalStorage：$key\r\n$value");
        return value;
    }

    Future setValue<T>(dynamic key, T value) async {
        Log.d("Set LocalStorage：$key\r\n$value");
        return await settingsBox.put(key, value);
    }

    Future removeValue<T>(dynamic key) async {
        Log.d("Remove LocalStorage：$key");
        return await settingsBox.delete(key);
    }
}
