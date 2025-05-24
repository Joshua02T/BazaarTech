import 'package:bazaartech/widget/customtoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HelpCenterController extends GetxController {
  RxString downloadSpeed = ''.obs;
  RxBool isLoading = false.obs;
  RxString connectionQuality = ''.obs;
  RxBool isLoadingPing = false.obs;

  final String pingUrl = 'https://www.google.com/';

  Future<void> performPingTest() async {
    try {
      isLoadingPing(true);
      final stopwatch = Stopwatch()..start();

      final response = await http.get(Uri.parse(pingUrl));

      if (response.statusCode == 200) {
        stopwatch.stop();

        final pingTime = stopwatch.elapsedMilliseconds;

        if (pingTime < 50) {
          connectionQuality.value = 'Excellent';
        } else if (pingTime < 150) {
          connectionQuality.value = 'Good';
        } else if (pingTime < 300) {
          connectionQuality.value = 'Average';
        } else {
          connectionQuality.value = 'Poor';
        }
      } else {
        ToastUtil.showToast("Unable to ping server, Try again later");
        connectionQuality.value = "";
      }
    } catch (e) {
      ToastUtil.showToast("Unable to ping server, Try again later");
      connectionQuality.value = "";
    } finally {
      isLoadingPing(false);
    }
  }

  final String fileUrl =
      "https://www.google.com/images/branding/googlelogo/2x/googlelogo_light_color_92x30dp.png"; // Small image file for testing

  Future<void> performSpeedTest() async {
    try {
      isLoading(true);
      final stopwatch = Stopwatch()..start();

      final response = await http.get(Uri.parse(fileUrl));

      if (response.statusCode == 200) {
        stopwatch.stop();

        final fileSizeInBytes = response.bodyBytes.length;
        final timeInSeconds = stopwatch.elapsedMilliseconds / 1000;
        final speedMbps = (fileSizeInBytes * 8) / (1024 * 1024 * timeInSeconds);

        downloadSpeed.value = '${speedMbps.toStringAsFixed(2)} Mbps';
      } else {
        ToastUtil.showToast("No Internet Connection, Try again later");
        downloadSpeed.value = "";
      }
    } catch (e) {
      ToastUtil.showToast("No Internet Connection, Try again later");
      downloadSpeed.value = "";
    } finally {
      isLoading(false);
    }
  }
}
