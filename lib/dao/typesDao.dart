import 'dart:convert';

import 'package:jbiaoapp/dao/dataResult.dart';
import 'package:jbiaoapp/model/goodsInfo.dart';
import 'package:jbiaoapp/model/goodsSearchInfo.dart';
import 'package:jbiaoapp/model/groupInfo.dart';
import 'package:jbiaoapp/model/typeInfo.dart';
import 'package:jbiaoapp/net/api.dart';

class TypesDao {
  static detail(int typeId) async {
    var params = {
      "Type": typeId
    };
    var res = await HttpManager.post(HttpManager.API_TYPE_DETAIL, params, null, null);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      TypeInfo typeInfo = TypeInfo.fromJson(data['Data']);
      var resGroup = await groupList(typeId);
      typeInfo.groupList = resGroup.data;
      return new DataResult(typeInfo, true);
    }
    return new DataResult(null,false);
  }

  //分组列表
  static groupList(int typeId) async {
    var params = {
      "Type": typeId,
      "Key": ''
    };
    var res = await HttpManager.post(HttpManager.API_GROUP_LIST, params, null, null);
    List<GroupInfo> groupList = new List<GroupInfo>();
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      print('res.data:${res.data}');
      for(var i=0 ; i<data['Data']['List'].length; i++) {
        GroupInfo groupInfo = GroupInfo.fromJson(data['Data']['List'][i]);
        groupList.add(groupInfo);
      }
    }
    return new DataResult(groupList, true);
  }
  //分组详情
  static  groupDetail(String groupId) async {
    var params = {
        "Id": groupId
    };
    var res = await HttpManager.post(HttpManager.API_GROUP_DETAIL, params, null, null);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      print('Data:${data['Data']}');
      GroupInfo groupInfo = GroupInfo.fromJson(data['Data']);
      return new DataResult(groupInfo,true);
    }
    return new DataResult(null,false);
  }
  

  //商品列表
  static goodsList(String groupId) async {     
    var params = {
      "GroupId": groupId,
      "Key": ''
    };
    var res = await HttpManager.post(HttpManager.API_GOODS_LIST, params, null, null);
    List<GoodsInfo> goodsList = new List<GoodsInfo>();
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      for(var i=0 ; i<data['Data']['List'].length; i++) {
        GoodsInfo goodsInfo = GoodsInfo.fromJson(data['Data']['List'][i]);
        goodsList.add(goodsInfo);
      }
    }
    return new DataResult(goodsList, true);
  }

  //商品搜索
  static goodsSearch(String key) async {
    var params = {
      "GroupId": '',
      "Key": key
    };
    var res = await HttpManager.post(HttpManager.API_GOODS_SEARCH, params, null, null);
    List<GoodsSearchInfo> goodsList = new List<GoodsSearchInfo>();
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      print('Data:${data['Data']}');
      for(var i=0 ; i<data['Data']['List'].length; i++) {
        GoodsSearchInfo goodsInfo = GoodsSearchInfo.fromJson(data['Data']['List'][i]);
        goodsList.add(goodsInfo);
      }
      return new DataResult(goodsList, true);
    }
    return new DataResult(null,false);
  }
}