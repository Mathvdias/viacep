import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:viacep/src/model/api_request.dart';

class ApiService {
  TextEditingController cepNumber = TextEditingController();
  late final bool isLoading;
  ApiService(this.isLoading, this.cepNumber);
  Future<CepList> getCepInput() {
    var dio = Dio();
    int cep = int.parse(cepNumber.text);
    return dio.get('https://viacep.com.br/ws/$cep/json').then((res) {
      return res.data.map<CepList>((end) => CepList.fromJson(end)).toList();
    }).then((data) async {
        return data;
    });



  }
}
