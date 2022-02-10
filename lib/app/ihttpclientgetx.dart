// ignore_for_file: avoid_print
import 'package:flut_getx_dev/model/return_model.dart';
import 'package:get/get.dart';
import 'package:flut_getx_dev/app/config.dart';

class IHttpClientGetx extends GetConnect {
  @override
  void onInit() {
    print('load IHttpClientGetx');
  }

  var paramData = <String, dynamic>{};
  var tokenBearer = "";

  setTokenBearer(token) {
    tokenBearer = token;
  }

  addParameterData(name, value) {
    paramData[name] = value;
  }

  Future sendAsnycPost(url, urlsub) async {
    var res = ReturnModel();
    // var headerPost = <String, String>{};
    // headerPost['Content-Type'] = 'application/json charset=UTF-8';
    // headerPost['Accept'] = 'application/json';
    // headerPost['Authorization'] = 'Bearer $tokenBearer';

    var formData = FormData(paramData);
    var urlEncode = Uri.encodeFull(url + "/" + urlsub);
    final response = await post(
      urlEncode,
      formData,
      // headers: headerPost,
    ).catchError((err) => throw Exception(err));

    // refresh paramData
    paramData = {};

    print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      res.Number = 0;
      res.Data = response.body;
    } else {
      res.Number = int.parse(response.statusCode.toString());
      res.Message = 'Error Post Data, Message : ${response.body['error']['message']}';
    }

    return res;

    // if (response.statusCode == 200) {
    //   return response.body;
    // } else if (response.statusCode == 401) {
    //   throw Exception('Error 401, Unauthorized');
    // } else {
    //   print(response.body);
    //   throw Exception('Gagal melakukan request data, ke $urlEncode');
    // }
  }

  postData() async {
    // final form = FormData({
    //   'katakunci': '',
    // });

    // var res = await post(AppConfig.APP_URL + '/user/getlist', form);
    // print(res.body);

    // return res;
  }

  sendDataAsync(url, action, data, token, deviceinfo) async {
    try {
      // final form = FormData({
      //   'postdata': data,
      // });

      var rowMapBody = <String, dynamic>{};
      rowMapBody['postdata'] = data;

      final form = FormData(rowMapBody);

      var res = await post(url + "/" + action, form);

      return res.body;
    } catch (e) {
      print("KESALAHAN :: " + e.toString());
    }
  }

  sendDataAsync2(url, action, data, token, deviceinfo) async {
    try {} catch (e) {
      print("KESALAHAN :: " + e.toString());
    }
  }
}
