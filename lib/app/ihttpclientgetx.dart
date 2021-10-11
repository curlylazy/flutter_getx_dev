// ignore_for_file: avoid_print
import 'package:get/get.dart';
import 'package:flut_getx_dev/app/config.dart';

class IHttpClientGetx extends GetConnect {
  @override
  void onInit() {
    print('load IHttpClientGetx');
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
