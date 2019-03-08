import 'package:event_bus/event_bus.dart';
import 'package:jbiaoapp/model/goodsInfo.dart';
import 'package:jbiaoapp/model/groupInfo.dart';
import 'package:jbiaoapp/model/typeInfo.dart';
EventBus eventBus = new EventBus();
class TypeSelectEvent {
  TypeInfo typeInfo;
  TypeSelectEvent(this.typeInfo);
}
class GroupSelectEvent {
  List<GoodsInfo> goodsInfoList;
  GroupInfo groupInfo;
  GroupSelectEvent(this.goodsInfoList,this.groupInfo);
}