import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'title': 'Welcome to Superhexa',
      'description': 'SuperhexaAPP is an application to manage SuperhexaAI audio glasses. To provide you with a smarter AI experience, the following permissions may be required during use. You can also manage system permissions in Settings - About APP.',
      'notificationPermissionTitle': 'Notification Permission',
      'notificationPermissionDescription': 'During use, this application needs to access notification usage rights for notification and reporting related services.',
      'bluetoothPermissionTitle': 'Bluetooth Permission',
      'bluetoothPermissionDescription': 'Bluetooth permissions will be used for scanning, adding, and using devices. If turned off, the aforementioned functions cannot be realized.',
      'termsAgreementPrefix': 'I have read and agree to the ',
      'termsAgreementUser': '"User Agreement"',
      'termsAgreementAnd': ' and ',
      'termsAgreementPrivacy': '"Privacy Policy"',
      'userExperiencePlanJoin': 'Join the ',
      'userExperiencePlan': '"User Experience Improvement Plan"',
      'agreeAndContinue': 'Agree and Continue',
      'thinkAgain': 'I need to think again',
    },
    'zh_CN': {
      'title': '欢迎使用Superhexa',
      'description': 'SuperhexaAPP是用来管理SuperhexaAI音频眼镜的应用。为了给您提供更智能的AI体验，使用过程中可能想您申请如下权限，您也可以我的设置-关于APP中管理系统权限。',
      'notificationPermissionTitle': '通知权限',
      'notificationPermissionDescription': '在使用过程中，本应用需要访问通知使用权，用于通知和播报相关服务。',
      'bluetoothPermissionTitle': '蓝牙权限',
      'bluetoothPermissionDescription': '蓝牙权限将用于扫描、添加和使用设备。如果关闭，将不能实现前述功能。',
      'termsAgreementPrefix': '已阅读并同意',
      'termsAgreementUser': '《用户协议》',
      'termsAgreementAnd': '和',
      'termsAgreementPrivacy': '《隐私政策》',
      'userExperiencePlanJoin': '加入',
      'userExperiencePlan': '《用户体验改进计划》',
      'agreeAndContinue': '同意并继续',
      'thinkAgain': '我再想想',
    },
  };
}

