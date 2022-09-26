import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../utils/app_utils.dart';
import '../error/exceptions.dart';

class DioHelper {
  final Dio dio;

  DioHelper({required this.dio});

  Options options() {
    return Options(
      followRedirects: false,
      validateStatus: (status) {
        return status! <= 500;
      },
    );
  }

  Future<Response> generalGet(String url) async {
    try {
      Response response = await dio.get(
        url,
        options: options(),
      );
      return AppUtils.handleStatuesCodeResponse(response);
    } on SocketException catch (e) {
      throw NoInternetConnectionException();
    } on DioError catch (e) {
      return AppUtils.handleDioError(e);
    }
  }

  Future<Response> generalDelete(String url) async {
    try {
      Response response = await dio.delete(
        url,
        options: options(),
      );

      return AppUtils.handleStatuesCodeResponse(response);
    } on SocketException catch (e) {
      throw NoInternetConnectionException();
    } on DioError catch (e) {
      return AppUtils.handleDioError(e);
    }
  }

  Future<Response> generalPost(String url, request) async {
    log('request -> ${json.encode(request)}');
    try {
      Response response = await dio.post(
        url,
        options: options(),
        data: request,
      );

      return AppUtils.handleStatuesCodeResponse(response);
    } on SocketException catch (e) {
      log('DioHelper in generalPost SocketException erroe is $e');
      throw NoInternetConnectionException();
    } on DioError catch (e) {
      log('DioHelper in generalPost error is $e');
      throw AppUtils.handleDioError(e);
    }
  }
}
