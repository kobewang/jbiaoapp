/// 商标搜索model
///
/// auth:wyj date:20190304
class  TmSearchInfo {
  String tmTypes;//国际分类，支持多选
  String cbTypes;//组合分类，支持多选
  int price; //价格
  int len; //长度
  String tmNameKey;  //名称关键字
  String tmRegnoKey; //注册号关键字
  String tmGroupKey; //分组关键字
  String tmRangeKey; //范围关键字
  TmSearchInfo({this.tmTypes,this.cbTypes,this.price,this.len,this.tmNameKey,this.tmRegnoKey,this.tmGroupKey,this.tmRangeKey});
}