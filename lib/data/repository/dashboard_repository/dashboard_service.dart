import 'package:behalal/data/models/beneficiary/add_a_beneficiary_response.dart';
import 'package:behalal/data/models/beneficiary/get_all_beneficiaries.dart';
import 'package:behalal/data/models/bill_models/airtime_provider_response_model.dart';
import 'package:behalal/data/models/bill_models/airtime_providers_by_id.dart';
import 'package:behalal/data/models/bill_models/cable_tv_provider_response_model.dart';
import 'package:behalal/data/models/bill_models/data_provider_response_model.dart';
import 'package:behalal/data/models/bill_models/data_providers_by_id.dart';
import 'package:behalal/data/models/bill_models/electricity_bill_provider_response_model.dart';
import 'package:behalal/data/models/bill_models/utility_bills_provider_response_model.dart';
import 'package:behalal/data/models/dashboard/dashboard_response_model.dart';
import 'package:dio/dio.dart';

abstract class DashboardServices{
  Future<DashBoardResponseModel> getDashboardProfile();
  Future<AirtimeBillProviderResponseModel> getAirtimeBillProviders();
  Future<ElectricityBillProviderResponseModel> getElectricityBillProviders();
  Future<CableTvProviderResponseModel> getCableTvBillProviders();
  Future<UtilityBillsProviderResponseModel> getUtilityBillProviders();
  Future<DataProviderResponseModel> getDataBillProviders();
  Future<GetAirtimeBillersByIdResponseModel> getAirtimeProvidersById({required String id});
  Future<DataBundleProvidersByIdResponseModel> getDataProvidersById({required String id});
  Future<GetAllBeneficiariesResponseModel> getAllBeneficiaries();
  Future<Response<dynamic>> purchaseAirtime({required Map<String, dynamic> body});
  Future<Response<dynamic>> purchaseData({required Map<String, dynamic> body});
  Future<Response<dynamic>> purchaseElectricity({required Map<String, dynamic> body});
  Future<Response<dynamic>> purchaseTvSubscription({required Map<String, dynamic> body});
  Future<AddABeneficiaryResponseModel> addABeneficiary({required Map<String, dynamic> body});
}