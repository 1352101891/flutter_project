import 'dart:convert';

import 'package:http/http.dart' as http;
import '../shopcart.dart';

typedef Callback(Map<String, dynamic> responseData);

//get(getBanner,
//  (map){
//    map["data"].forEach((item){
//      var bm = new BannerModel.fromJson(item);
//      banners.add(bm);
//    });
//    setState(() {isloading=false; });
//  }
//);

//get(dynamic url, { Map<String, String> headers }) → Future<Response>
//(必须)url:请求地址
//(可选)headers:请求头
void get(String url,Callback callback) async{
  await http.get(url).then((http.Response response) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    callback(responseData);
    //处理响应数据
  }).catchError((error) {
    print('$error错误');
  });
}


//post(dynamic url, { Map<String, String> headers, dynamic body, Encoding encoding }) → Future<Response>
//(必须)url:请求地址
//(可选)headers:请求头
//(可选)body:参数
//(编码)Encoding:编码 例子
void post(String url,Object param,Callback cb){
  http.post(url,
  body: json.encode(param),encoding: Utf8Codec())
  .then((http.Response response) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    cb(responseData);
    //处理响应数据
  }).catchError((error) {
    print('$error错误');
  });
}


void addProduct(Production product) async {
  Map<String, dynamic> param = {
    'name': product.name,
    'icon': product.icon,
    'price': product.price
  };
  try {
    final http.Response response = await http.post(
        'https://flutter-cn.firebaseio.com/products.json',
        body: json.encode(param),
        encoding: Utf8Codec());

    final Map<String, dynamic> responseData = json.decode(response.body);
    print('$responseData 数据');

  } catch (error) {
    print('$error错误');
  }
}

