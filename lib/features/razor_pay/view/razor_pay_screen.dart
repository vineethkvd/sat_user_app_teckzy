import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


import '../../../core/configs/styles/app_colors.dart';
import '../../payment/controller/payment_controller.dart';
import '../../recharge/controller/recharge_controller.dart';
import '../../show_ticket/view/show_ticket.dart';

class PaymentPage extends StatefulWidget {
  final String orderId;
  final String amount;
  final String razorKey;
  final String url;
  final String t_id;

  const PaymentPage({
    Key? key,
    required this.orderId,
    required this.amount,
    required this.razorKey,
    required this.url,
    required this.t_id,
  }) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Razorpay _razorpay;
  final PaymentController paymentController = Get.put(PaymentController());
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // _razorpay.on(Razorpay.PAYMENT_CANCELLED, _handlePaymentCancelled);

    _startPayment();
  }

  void _startPayment() {
    var options = {
      'key': widget.razorKey,
      'amount': num.parse(widget.amount) * 100,
      'name': 'SAT User',
      'description': 'Ticket',
      'image':
          'https://rzp-1415-prod-dashboard-activation.s3.ap-south-1.amazonaws.com/org_100000razorpay/main_logo/phplgbGKN',
      'order_id': widget.orderId,
      'prefill': {'contact': '9488461008', 'email': 'test@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }

  // void _handlePaymentCancelled() {
  //   Fluttertoast.showToast(
  //       msg: 'Payment Cancelled',
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM);
  //   Get.off(HomeScreen(),transition: Transition.leftToRightWithFade);
  // }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.defaultDialog(
      title: 'Payment Success',
      textConfirm: 'Ok',
      middleText: 'Payment Successful',
      titleStyle: TextStyle(
        fontSize: 18.sp, // Adjust the font size as needed
        fontWeight: FontWeight.bold, // Adjust the font weight as needed
      ),
      buttonColor: AppColor.appMainColor, // Set the button color
      radius: 10.0, // Set the border radius
      onConfirm: () {
        Get.back();
        print("${widget.url}");
        paymentController.hitPayment(
            url: widget.url,
            t_id: widget.t_id,
            singnature: response.signature!,
            order_id: response.orderId!,
            payment_id: response.paymentId!);
        if (paymentController.paymentHitApiMidel.value.status == "Success") {
          print("Sigm  hvhbjjb${response.signature}");
          Get.back();
          Get.off(const ShowTicketScreen(),
              transition: Transition.leftToRightWithFade);
        }
      },
    );
    // Fluttertoast.showToast(
    //     msg: 'Payment Success: ' + response.paymentId!,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: 'Payment Error: ' + response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: 'External Wallet: ' + response.walletName!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [CircularProgressIndicator()],
        ),
      ),
    );
  }
}
