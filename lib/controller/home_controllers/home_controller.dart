import 'package:behalal/app/assets/images.dart';
import 'package:behalal/core/injector/injector.dart';
import 'package:behalal/data/models/dashboard/dashboard_response_model.dart';
import 'package:behalal/data/repository/dashboard_repository/dashboard_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  final DashboardServices _dashboardServices = sl<DashboardServices>();
  String? userAvatar;

  final sendMoneyTagModels = [
    {
      "image": PNGImages.transfer,
      "title": "Bank Transfer",
      "subTitle": "Send money to other banks"
    },
    {
      "image": PNGImages.p2p,
      "title": "P2P Transfer",
      "subTitle": "Use Phone or Halal tag for instant transaction"
    },
    {
      "image": PNGImages.qrcode,
      "title": "Scan QR Code",
      "subTitle": "Pay for Ride, Restaurants, Cabs, Mall conveniently "
    },
    {
      "image": PNGImages.security,
      "title": "Pay with Escrow",
      "subTitle": "We will hold the money until you get the value"
    },
  ];

  final airTimeBills = [
    {
      "image": PNGImages.buyAirtime,
      "title": "Buy Airtime",
      "subTitle": ""
    },
    {
      "image": PNGImages.buyData,
      "title": "Buy Data",
      "subTitle": ""
    },
    {
      "image": PNGImages.electricity,
      "title": "Electricity",
      "subTitle": ""
    },
    {
      "image": PNGImages.cableTv,
      "title": "Cable TV",
      "subTitle": ""
    },
    {
      "image": PNGImages.religiousInstitution,
      "title": "Religious Institution",
      "subTitle": ""
    },
    {
      "image": PNGImages.flightTicket,
      "title": "Flight Tickets",
      "subTitle": ""
    },
    {
      "image": PNGImages.moveTicket,
      "title": "Movie Tickets",
      "subTitle": ""
    },
  ];

  final sendReceiveTagModels = [
    {
      "image": PNGImages.qrcodeOrange,
      "title": "Show QR Code",
      "subTitle": "Present your QR code to receive money "
    },
    {
      "image": PNGImages.p2pPurple,
      "title": "Receive Money with Paylink",
      "subTitle": "Create & share payment link to others"
    },
    {
      "image": PNGImages.securityBlue,
      "title": "Receive Money with Escrow",
      "subTitle": "Build trust with your customers or partners"
    },
  ];

  final rowMoreServices = [
    {
      "image": PNGImages.report,
      "title": "Report",
    },
    {
      "image": PNGImages.storeFront,
      "title": "Store Front",
    },
    {
      "image": PNGImages.invoice,
      "title": "Invoice",
    },
    {
      "image": PNGImages.checkOut,
      "title": "Checkout",
    },
  ];

  final columnMoreServices = [
    {
      "image": PNGImages.ajo,
      "title": "Do Ajo with Family & Friends",
      "subtitle": "Create & share payment link to others"
    },
    {
      "image": PNGImages.budgetTracker,
      "title": "Budget Tracker",
      "subtitle": "Present your QR code to receive money"
    },
    {
      "image": PNGImages.raiseMoney,
      "title": "Raise Money",
      "subtitle": "Be it for an event or medical bills, raise it now."
    },
    {
      "image": PNGImages.createEvents,
      "title": "Create Events",
      "subtitle": "Present your QR code to receive money"
    },
  ];

  DashBoardResponseModel? dashBoardResponseModel;
  Future<void> getDashboard() async {
    try {
     dashBoardResponseModel = await _dashboardServices.getDashboardProfile();
     update();
    }catch (err){
      update();
      throw err.toString();
    }
  }
}
