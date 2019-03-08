import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jbiaoapp/dao/dataResult.dart';
import 'package:jbiaoapp/model/mytm_detailInfo.dart';
import 'package:jbiaoapp/model/regtmInfo.dart';
import 'package:jbiaoapp/net/api.dart';

/// 商标数据处理
///
///
class TmDao {
  //增加商标提交申请
  static addRegTm(RegTmInfo info, File imgFile) async {
    var params = FormData.from({
      "TmName": info.tmName,
      "TmType": info.tmType,
      "ReMark": info.reMark,
      "ApplyName": info.applyName,
      "Province": info.province,
      "City": info.city,
      "Area": info.area,
      "Address": info.address,
      "Mobile": info.mobile,
      "filename": new UploadFileInfo(imgFile, "YYZZImg.jpg",
          contentType: ContentType.parse('image/jpeg')),
      "files": [imgFile, "YYZZImg.jpg"]
    });
    var res =
        await HttpManager.post(HttpManager.API_TM_REG, params, null, null);
    //print(params);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      return new DataResult(data, true);
    }
    return new DataResult(null, false);
  }

  //我的商标列表
  static myTmList(int pageIndex) async {
    var params = {
      "pageRequest": {
        "LastId": 0,
        "PageSize": 20,
        "Sort": "",
        "KeyWord": "",
        "PageIndex": 1
      },
      "userRequest": {
        "Token": "token987",
        "Plat": 0,
        "TimeStamp": 0,
        "Sign": ""
      }
    };
    var res =
        await HttpManager.post(HttpManager.API_TM_MYLIST, params, null, null);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      return new DataResult(data, true);
    }
    return new DataResult(null, false);
  }

  //我的商标详情
  static myTmDetail(int tmId) async {
    var params = {
      "userRequest": {
        "Token": "token987",
        "Plat": 0,
        "TimeStamp": 0,
        "Sign": ""
      },
      "Id": tmId
    };
    var res =
        await HttpManager.post(HttpManager.API_TM_MY_DETAIL, params, null, null);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      print(data);
      MyTmDetailInfo myTmDetailInfo=MyTmDetailInfo.fromJson(data['Data']);
      return new DataResult(myTmDetailInfo, true);
    }
    return new DataResult(null, false);
  }
}
