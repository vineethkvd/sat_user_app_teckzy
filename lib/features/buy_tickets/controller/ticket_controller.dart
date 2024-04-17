import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/utils/helpers/cache_helper/cache_helper.dart';
import '../model/ticket_model.dart';
import 'package:http/http.dart' as http;

class TicketController extends GetxController {
  var message = ''.obs;
  var routeId = ''.obs;
  var choosenMetro = ''.obs;
  var choosenCampus = ''.obs;
  var perTicket = ''.obs;
  var dailyFare = ''.obs;
  var weeklyFare = ''.obs;
  var monthlyFare = ''.obs;
  var dailyValidity = ''.obs;
  var weeklyValidity = ''.obs;
  var monthlyValidity = ''.obs;
  final RxString currentPrice = ''.obs;
//date
  RxBool isDateValid = false.obs;
  RxBool isWeekValid = false.obs;
  RxBool isMonthValid = false.obs;
  //PRICE
  RxInt count = 1.obs;

  void calculateNext24HoursValidity() {
    DateTime currentDate = DateTime.now();
    DateTime next24Hours = currentDate.add(Duration(hours: 24));

    // Format the next 24 hours date as "dd/mm/yyyy"
    String formattedDate = '${next24Hours.day.toString().padLeft(2, '0')}/'
        '${next24Hours.month.toString().padLeft(2, '0')}/'
        '${next24Hours.year}';
    dailyValidity.value = formattedDate;
  }

  void calculateNextWeekValidity() {
    DateTime currentDate = DateTime.now();
    DateTime nextWeek = currentDate.add(Duration(days: 7));
    String formattedDate = '${nextWeek.day.toString().padLeft(2, '0')}/'
        '${nextWeek.month.toString().padLeft(2, '0')}/'
        '${nextWeek.year}';
    weeklyValidity.value = formattedDate;
  }

  void calculateNextMonthValidity() {
    DateTime currentDate = DateTime.now();
    DateTime nextMonth =
        DateTime(currentDate.year, currentDate.month + 1, currentDate.day);
    DateTime nextMonthEnd = DateTime(nextMonth.year, nextMonth.month + 1, 0);
    String formattedDate = '${nextMonthEnd.day.toString().padLeft(2, '0')}/'
        '${nextMonthEnd.month.toString().padLeft(2, '0')}/'
        '${nextMonthEnd.year}';
    monthlyValidity.value = formattedDate;
  }

  Future<void> fetchTicket() async {
    final apiUrl = 'http://teckzy.in/satapi/restapi/userapi/ticket.php';
    const apiToken = "SAT@2024";

    final headers = {'Content-Type': 'application/json'};
    final cusId = await CacheHelper.getData('cusid');
    final routes = await CacheHelper.getData('routeId');
    final requestData = {
      "api_key": apiToken,
      "cus_id": cusId,
      "route_id": routes
    };
    final jsonBody = json.encode(requestData);

    try {
      final response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: jsonBody);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final ticketModel = TicketModel.fromJson(responseData);
        if (ticketModel.status != null && ticketModel.status!) {
          message.value = ticketModel.message ?? '';

          if (ticketModel.data != null && ticketModel.data!.isNotEmpty) {
            final data = ticketModel.data!.first;
            routeId.value = data.routeId ?? '';
            choosenMetro.value = data.choosenMetro ?? '';
            choosenCampus.value = data.choosenCampus ?? '';
            perTicket.value = data.perTicket ?? '';
            dailyFare.value = data.dailyFare ?? '';
            weeklyFare.value = data.weeklyFare ?? '';
            monthlyFare.value = data.monthlyFare ?? '';
            dailyValidity.value = data.dailyValidity ?? '';
            weeklyValidity.value = data.weeklyValidity ?? '';
            monthlyValidity.value = data.monthlyValidity ?? '';
            currentPrice.value = dailyFare.value;
          }
        } else {
          throw Exception('Status is not true');
        }
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('HTTP Client Exception: $e');
    } on SocketException catch (e) {
      throw Exception('Socket Exception: $e');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void incPrice() {
    count.value = count.value + 1;

    dailyFare.value =
        (int.parse(dailyFare.value) + (int.parse(currentPrice.value)))
            .toString();
  }

  void decPrice() {
    if (count.value > 1) {
      count.value = count.value - 1;
      dailyFare.value =
          (int.parse(dailyFare.value) - (int.parse(currentPrice.value)))
              .toString();
    }
  }
}
