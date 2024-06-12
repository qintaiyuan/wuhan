// ICommandStrategy 抽象类定义
abstract class ICommandStrategy {
  // 获取内容数据
  List<int> getContentData() => [];

  // 根据序列号获取数据
  List<int> getData(int seq);

  // 获取操作码
  List<int> getOpCode();
}