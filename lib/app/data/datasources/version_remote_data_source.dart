import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/data/models/version_info_model.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';

abstract class VersionRemoteDataSource {
  Future<VersionInfoModel> getVersionInfo();
}

class VersionRemoteDataSourceImpl extends VersionRemoteDataSource {
  final url = "https://www.naver.com";
  final Dio httpClient;

  VersionRemoteDataSourceImpl({
    @required this.httpClient
  });

  @override
  Future<VersionInfoModel> getVersionInfo() async {
    final response = await httpClient.get(url);
    if (response.statusCode == 200) {
      try {
        return VersionInfoModel.fromJson(json.decode(response.data));
      } catch (exception) {
        print('parseException : ' + exception.toString());
        throw ParseException();
      }
    } else {
      throw ServerException();
    }
  }

}