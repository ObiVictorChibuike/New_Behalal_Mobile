import 'dart:convert';

import 'package:behalal/app/constants/api_path.dart';
import 'package:behalal/core/network/dio_core/dio_client.dart';
import 'package:behalal/core/network/dio_core/dio_error.dart';
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
import 'package:behalal/data/repository/dashboard_repository/dashboard_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DashboardServiceImpl extends DashboardServices {
  final NetworkProvider _networkProvider = NetworkProvider();

  @override
  Future<DashBoardResponseModel> getDashboardProfile() async {
    try{
      var response = await _networkProvider.call(path: ApiPaths.dashboardProfile, method: RequestMethod.get);
      return DashBoardResponseModel.fromJson(response?.data);
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }

  @override
  Future<AirtimeBillProviderResponseModel> getAirtimeBillProviders() async{
    try{
      var response = await _networkProvider.call(path: ApiPaths.airTime, method: RequestMethod.get);
      return AirtimeBillProviderResponseModel.fromJson(response?.data);
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }

  @override
  Future<CableTvProviderResponseModel> getCableTvBillProviders() async{
    try{
      var response = await _networkProvider.call(path: ApiPaths.cableTv, method: RequestMethod.get);
      return CableTvProviderResponseModel.fromJson(response?.data);
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }

  @override
  Future<DataProviderResponseModel> getDataBillProviders() async{
    try{
      var response = await _networkProvider.call(path: ApiPaths.data, method: RequestMethod.get);
      return DataProviderResponseModel.fromJson(response?.data);
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }

  @override
  Future<ElectricityBillProviderResponseModel> getElectricityBillProviders() async{
    try{
      var response = await _networkProvider.call(path: ApiPaths.electricity, method: RequestMethod.get);
      return ElectricityBillProviderResponseModel.fromJson(response?.data);
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }

  @override
  Future<UtilityBillsProviderResponseModel> getUtilityBillProviders() async{
    try{
      var response = await _networkProvider.call(path: ApiPaths.data, method: RequestMethod.get);
      return UtilityBillsProviderResponseModel.fromJson(response?.data);
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }

  @override
  Future<GetAirtimeBillersByIdResponseModel> getAirtimeProvidersById({required String id}) async{
    try{
      var response = await _networkProvider.call(path: ApiPaths.billById+id, method: RequestMethod.get);
      return GetAirtimeBillersByIdResponseModel.fromJson(response?.data);
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }

  @override
  Future<GetAllBeneficiariesResponseModel> getAllBeneficiaries() async{
    try{
      var response = await _networkProvider.call(path: ApiPaths.getAllBeneficiary, method: RequestMethod.get);
      return GetAllBeneficiariesResponseModel.fromJson(response?.data);
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }

  @override
  Future<AddABeneficiaryResponseModel> addABeneficiary({required Map<String, dynamic> body}) async{
    try{
      var response = await _networkProvider.call(path: ApiPaths.getAllBeneficiary, method: RequestMethod.get, body: body);
      return AddABeneficiaryResponseModel.fromJson(response?.data);
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }

  @override
  Future<Response> purchaseAirtime({required Map<String, dynamic> body}) async {
    try{
      var response = await _networkProvider.call(path: ApiPaths.purchaseAirtime, method: RequestMethod.post, body: body);
      return response?.data;
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }

  @override
  Future<Response> purchaseData({required Map<String, dynamic> body}) async{
    try{
      var response = await _networkProvider.call(path: ApiPaths.purchaseAirtime, method: RequestMethod.post, body: body);
      return response?.data;
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }

  @override
  Future<Response> purchaseElectricity({required Map<String, dynamic> body}) async{
    try{
      var response = await _networkProvider.call(path: ApiPaths.purchaseAirtime, method: RequestMethod.post, body: body);
      return response?.data;
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }

  @override
  Future<Response> purchaseTvSubscription({required Map<String, dynamic> body}) async{
    try{
      var response = await _networkProvider.call(path: ApiPaths.purchaseAirtime, method: RequestMethod.post, body: body);
      return response?.data;
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }

  @override
  Future<DataBundleProvidersByIdResponseModel> getDataProvidersById({required String id}) async {
    try{
      var response = await _networkProvider.call(path: ApiPaths.dataById+id, method: RequestMethod.get);
      return DataBundleProvidersByIdResponseModel.fromJson(response?.data);
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }
}