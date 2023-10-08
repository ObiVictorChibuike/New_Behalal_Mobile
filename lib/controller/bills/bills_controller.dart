import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/constants/strings.dart';
import 'package:behalal/app/universal_utils/dialog_util.dart';
import 'package:behalal/app/universal_utils/snackbar_util.dart';
import 'package:behalal/controller/home_controllers/home_controller.dart';
import 'package:behalal/core/injector/injector.dart';
import 'package:behalal/data/models/beneficiary/add_a_beneficiary_response.dart';
import 'package:behalal/data/models/beneficiary/get_all_beneficiaries.dart';
import 'package:behalal/data/models/bill_models/airtime_provider_response_model.dart';
import 'package:behalal/data/models/bill_models/airtime_providers_by_id.dart';
import 'package:behalal/data/models/bill_models/cable_tv_provider_response_model.dart';
import 'package:behalal/data/models/bill_models/data_provider_response_model.dart';
import 'package:behalal/data/models/bill_models/data_providers_by_id.dart';
import 'package:behalal/data/models/bill_models/electricity_bill_provider_response_model.dart';
import 'package:behalal/data/models/bill_models/utility_bills_provider_response_model.dart';
import 'package:behalal/data/repository/dashboard_repository/dashboard_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillController extends GetxController{
  String? _pinCode;
  final DashboardServices _dashboardServices = sl<DashboardServices>();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  void onOTPCodeChanged(String value) {
    _pinCode = value;
    update();
  }

  final todayTransactions = [
    {
      "amount": "-₦4,600.00",
      "status": "Successful",
      "provider": "DSTV",
      "transactionType": "Card transaction"
    },
    {
      "amount": "-₦500.00",
      "status": "Successful",
      "provider": "SWema Ijoko, Lagos",
      "transactionType": "Cash"
    },
    {
      "amount": "₦16,600",
      "status": "Successful",
      "provider": "Mtn",
      "transactionType": "Airtime"
    },
  ];

  final yesterdayTransactions = [
    {
      "amount": "-₦4,600.00",
      "status": "Successful",
      "provider": "Aminat Motunrayo",
      "transactionType": "Money received"
    },
    {
      "amount": "-₦500.00",
      "status": "Successful",
      "provider": "Ismail Adeola",
      "transactionType": "Transfer"
    },
  ];


  final olderTransaction = [
    {
      "amount": "-₦4,600.00",
      "status": "Successful",
      "provider": "Teamapt Limited Moniepo665",
      "transactionType": "Card transaction"
    },
    {
      "amount": "-₦500.00",
      "status": "Successful",
      "provider": "Teamapt Limited Moniepo665",
      "transactionType": "Card transaction"
    },
  ];

  final meterTypeList = [
    "PREPAID",
    "POSTPAID"
  ];

  final package = [
    "DStv Premium",
    "GOtv",
    "Star Times",
    "Ajazeera"
  ];

  final packageAmount = [
    {
      "amount": "₦16,600",
      "package": "DStv Compact Plus"
    },
    {
      "amount": "₦24,500",
      "package": "DStv Premium"
    },
    {
      "amount": "₦16,600",
      "package": "DStv Compact "
    },
    {
      "amount": "₦16,600",
      "package": "DStv Compact Plus"
    },
    {
      "amount": "₦16,600",
      "package": "DStv Compact Plus"
    },
    {
      "amount": "₦16,600",
      "package": "DStv Compact Plus"
    },
    {
      "amount": "₦16,600",
      "package": "DStv Compact Plus"
    },
  ];

  final homeController = Get.lazyPut(() => HomeController());
  final amounts = [
    "₦ 100",
    "₦ 200",
    "₦ 500",
    "₦ 1000",
    "₦ 1500",
    "₦ 2000",
    "₦ 2500",
    "₦ 3000",
    "₦ 4000",
    "₦ 5000",
  ];

  final electricityProvidersOptions = [
    "Ibadan Electricity Distribution Company Postpaid",
    "Kaduna Electricity Distribution Company Postpaid",
    "Jos Electricity Distribution Company Prepaid",
    "Yola Electricity Distribution Company",
    "Ibadan Electricity Distribution Company Prepaid",
    "Enugu Electricity Distribution Company Prepaid",
    "Benin Electricity Distribution Company Postpaid",
    "Jos Electricity Distribution Company Postpaid",
    "Kaduna Electricity Distribution Company Prepaid",
    "Eko Electricity Distribution Company Plc Prepaid",
    "Enugu Electricity Distribution Company Postpaid",
    "Benin Electricity Distribution Company Prepaid",
    "Eko Electricity Distribution Company Plc Postpaid",
  ];

  final bank = [
    {
      "bank": "GT Bank",
      "bank_icon": PNGImages.gtBank
    },
    {
      "bank": "First bank of Nigeria",
      "bank_icon": PNGImages.firstBank
    },
    {
      "bank": "Zenith Bank",
      "bank_icon": PNGImages.zenithBank
    },
  ];

  final beneficiary = [
    {
      "name": "Aweni House Flat 5",
      "meter_number": "3895-354-4535-44",
      "provider": "Electricity "
    },
  ];

  final bankBeneficiary = [
    {
      "name": "Yusuf",
      "account_number": "UBA • 0123456789",
    },
    {
      "name": "Ibrahim Lukman",
      "account_number": "First Bank of Nigeria • 0123456789",
    },
    {
      "name": "Anonymous",
      "account_number": "UBA • 0123456789",
    },
    {
      "name": "Adebola Sodiq",
      "account_number": "Opay Digital Service • 0123456789",
    },
  ];

  final cableTv = [
    {
      "name": "Ayanfe Lukman",
      "card_number": "3895-354-4",
      "provider": "DSTV "
    },
  ];

  final dataPlan = [
    {
      "bundle": "100MB",
      "duration": "1 day",
      "amount": "₦100"
    },
    {
      "bundle": "100MB",
      "duration": "1 day",
      "amount": "₦100"
    },
    {
      "bundle": "100MB",
      "duration": "1 day",
      "amount": "₦100"
    },
    {
      "bundle": "100MB",
      "duration": "1 day",
      "amount": "₦100"
    },
    {
      "bundle": "100MB",
      "duration": "1 day",
      "amount": "₦100"
    },
    {
      "bundle": "100MB",
      "duration": "1 day",
      "amount": "₦100"
    },
  ];


  DataProviderResponseModel? dataProviders;
  String? dataProviderState;
  Future<void> getDataProviders() async {
    dataProviderState = AppString.loading;
    try {
      dataProviders = await _dashboardServices.getDataBillProviders();
      dataProviderState = AppString.completed;
      update();
    }catch (err){
      dataProviderState = AppString.error;
      update();
      throw err.toString();
    }
  }

  CableTvProviderResponseModel? cableTvProviders;
  String? cableProviderState;
  Future<void> getCableTvProviders() async {
    cableProviderState = AppString.loading;
    try {
      cableTvProviders = await _dashboardServices.getCableTvBillProviders();
      cableProviderState = AppString.completed;
      update();
    }catch (err){
      cableProviderState = AppString.error;
      update();
      throw err.toString();
    }
  }

  ElectricityBillProviderResponseModel? electricityProviders;
  String? electricityProviderState;
  Future<void> getElectricityProviders() async {
    electricityProviderState = AppString.loading;
    try {
      electricityProviders = await _dashboardServices.getElectricityBillProviders();
      electricityProviderState = AppString.completed;
      update();
    }catch (err){
      electricityProviderState = AppString.error;
      update();
      throw err.toString();
    }
  }

  UtilityBillsProviderResponseModel? utilityProviders;
  String? utilityProviderState;
  Future<void> getUtilityProviders() async {
    utilityProviderState = AppString.loading;
    try {
      utilityProviders = await _dashboardServices.getUtilityBillProviders();
      utilityProviderState = AppString.completed;
      update();
    }catch (err){
      utilityProviderState = AppString.error;
      update();
      throw err.toString();
    }
  }

  AirtimeBillProviderResponseModel? airtimeProviders;
  String? airtimeProviderState;
  Future<void> getAirtimeProviders() async {
    airtimeProviderState = AppString.loading;
    try {
      airtimeProviders = await _dashboardServices.getAirtimeBillProviders();
      airtimeProviderState = AppString.completed;
      update();
    }catch (err){
      airtimeProviderState = AppString.error;
      update();
      throw err.toString();
    }
  }

  GetAirtimeBillersByIdResponseModel? mtn, airtel, mobile9, glo ;
  String? airTimeProviderById;
  String? providerId;

  Future<void> getAirtimeProvidersById({required String id}) async {
    providerId = id;
    airTimeProviderById = AppString.loading;
    try {
      if(id == "109"){
        mtn = await _dashboardServices.getAirtimeProvidersById(id: id);
        update();
      }else if(id == "901"){
        airtel = await _dashboardServices.getAirtimeProvidersById(id: id);
        update();
      }else if(id == "402"){
        glo = await _dashboardServices.getAirtimeProvidersById(id: id);
        update();
      }else if(id == "120"){
        mobile9 = await _dashboardServices.getAirtimeProvidersById(id: id);
        update();
      }
      airTimeProviderById = AppString.completed;
      update();
    }catch (err){
      airTimeProviderById = AppString.error;
      update();
      throw err.toString();
    }
  }

  AddABeneficiaryResponseModel? addABeneficiaryResponseModel;
  String? addBeneficiaryState;
  Future<void> addABeneficiary({required String type, required String name, required String target, required String provider}) async {
    addBeneficiaryState = AppString.loading;
    try {
      var postBody = {
        "type": type,
        "name": name,
        "target": target,
        "provider": provider
      };
      addABeneficiaryResponseModel = await _dashboardServices.addABeneficiary(body: postBody);
      addBeneficiaryState = AppString.completed;
      update();
    }catch (err){
      addBeneficiaryState = AppString.error;
      update();
      throw err.toString();
    }
  }


  String? purchaseAirtimeState;
  Future<void> purchaseAirtime({
    required String amount,
    required String itemCode,
    required String phoneNumber,
    required String transactionPin,
    required bool saveAsBeneficiary,
    required String provider,
  }) async {
    loaderDialog(context: Get.context!);
    purchaseAirtimeState = AppString.loading;
    try {
      var postBody = {
        "amount": int.parse(amount),
        "paymentCode": itemCode,
        "customerMobile": phoneNumber,
        "transaction_pin": transactionPin,
        "saveAsBeneficiary": saveAsBeneficiary
      };
      await _dashboardServices.purchaseAirtime(body: postBody);
      purchaseAirtimeState = AppString.completed;
      update();
      Get.back();
      showBillSuccessDialog(context: Get.context!, smartCardNumber: "21340000789", provider: provider);
    }catch (err){
      Get.back();
      SnackbarUtil.showErrorSnackbar(err.toString());
      purchaseAirtimeState = AppString.error;
      update();
      throw err.toString();
    }
  }

  GetAllBeneficiariesResponseModel? getAllBeneficiariesResponseModel;
  String? beneficiaryState;
  Future<void> getAllBeneficiaries() async {
    beneficiaryState = AppString.loading;
    try {
      getAllBeneficiariesResponseModel = await _dashboardServices.getAllBeneficiaries();
      beneficiaryState = AppString.completed;
      update();
    }catch (err){
      beneficiaryState = AppString.error;
      update();
      throw err.toString();
    }
  }


  DataBundleProvidersByIdResponseModel? mtnData, airtelData, mobile9Data, gloData;
  String? dataProviderById;
  String? dataProviderId;
  Future<void> getDataProvidersById({required String id}) async {
    dataProviderId = id;
    dataProviderById = AppString.loading;
    try {
      if(id == "109"){
        mtnData = await _dashboardServices.getDataProvidersById(id: id);
        update();
      }else if(id == "901"){
        airtelData = await _dashboardServices.getDataProvidersById(id: id);
        update();
      }else if(id == "402"){
        gloData = await _dashboardServices.getDataProvidersById(id: id);
        update();
      }else if(id == "120"){
        mobile9Data = await _dashboardServices.getDataProvidersById(id: id);
        update();
      }
      dataProviderById = AppString.completed;
      update();
    }catch (err){
      dataProviderById = AppString.error;
      update();
      throw err.toString();
    }
  }

  ElectricityBillProviderResponseModel? getAllElectricityProviders;
  String? electricityProvidersState;
  Future<void> getAllElectricityProvider() async {
    electricityProvidersState = AppString.loading;
    try {
      getAllElectricityProviders = await _dashboardServices.getElectricityBillProviders();
      electricityProvidersState = AppString.completed;
      update();
    }catch (err){
      electricityProvidersState = AppString.error;
      update();
      throw err.toString();
    }
  }

  void loadBillProviders() async{
    await getAirtimeProviders();
    await getCableTvProviders();
    await getElectricityProviders();
    await getUtilityProviders();
    await getDataProviders();
  }

  @override
  void onInit(){
    super.onInit();
    getAllBeneficiaries();
    getAllElectricityProvider();
    loadBillProviders();
  }

}