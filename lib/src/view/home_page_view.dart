import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:viacep/src/model/api_request.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'return_info_cep.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;
  bool isComposing = false;
  TextEditingController cepNumber = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<CepList> getCepInput() async {
    int cep = int.parse(cepNumber.text);
    var url = Uri.parse('https://viacep.com.br/ws/$cep/json');
    var response = await http.get(url);
    var json = jsonDecode(response.body);

    var ceplist = CepList.fromJson(json);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
    }
    return ceplist;
  }

  void _resetFields() {
    cepNumber.clear();

    setState(() {
      isLoading = false;
      isComposing = false;
      _formKey = GlobalKey<FormState>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: const Text('Pesquisar CEP'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        actions: [
          IconButton(
              padding: const EdgeInsets.all(24),
              onPressed: () {
                _resetFields();
              },
              icon: const Icon(
                Icons.find_replace_outlined,
                size: 30,
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SvgPicture.asset('assets/logo1.svg'),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (text) {
                  setState(() {
                    isComposing = text.isNotEmpty;
                  });
                },
                inputFormatters: [LengthLimitingTextInputFormatter(8)],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.greenAccent),
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.greenAccent),
                        borderRadius: BorderRadius.circular(30)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.greenAccent),
                        borderRadius: BorderRadius.circular(30)),
                    labelText: 'Digite seu Cep',
                    fillColor: Colors.greenAccent,
                    labelStyle: const TextStyle(
                        color: Colors.greenAccent, fontSize: 25)),
                controller: cepNumber,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Insira seu Cep!';
                  }
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child:
                    SizedBox(height: 50, child: buttonValidateInput(context)),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: SizedBox(
        height: MediaQuery.of(context).size.height * .06,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(
              size: MediaQuery.of(context).size.height * .05,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .01,
            ),
            Text(
              'Matheus',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).padding.bottom + 20),
            )
          ],
        ),
      ),
    );
  }

  buttonValidateInput(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        textStyle: const TextStyle(fontSize: 25),
        shape: const StadiumBorder(),
        primary: Colors.greenAccent,
      ),
      onPressed: isComposing
          ? () async {
              if (isLoading) return;
              setState(() {
                isLoading = true;
              });

              final ceplist = await getCepInput();
              const Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              ));
              modalResultImc(context, ceplist);
            }
          : null,
      child: isLoading
          ? const CircularProgressIndicator()
          : const Text(
              'Buscar',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
    );
  }
}

Future<dynamic> modalResultImc(BuildContext context, ceplist) {
  return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(10),
      )),
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ReturnInfoText(infotext: 'CEP', ceplist: ceplist.cep),
              ReturnInfoText(
                  infotext: 'Logradouro', ceplist: ceplist.logradouro),
              ReturnInfoText(
                  infotext: 'Complemento', ceplist: ceplist.complemento),
              ReturnInfoText(infotext: 'Bairro', ceplist: ceplist.bairro),
              ReturnInfoText(
                  infotext: 'Localidade', ceplist: ceplist.localidade),
              ReturnInfoText(infotext: 'UF', ceplist: ceplist.uf),
              ReturnInfoText(infotext: 'IBGE', ceplist: ceplist.ibge),
              ReturnInfoText(infotext: 'GIA', ceplist: ceplist.gia),
              ReturnInfoText(infotext: 'DDD', ceplist: ceplist.ddd),
              ReturnInfoText(infotext: 'SIAFI', ceplist: ceplist.siafi),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.greenAccent),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Fechar'))
            ],
          ),
        );
      });
}
