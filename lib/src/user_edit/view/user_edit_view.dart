import 'package:commerce_flutter/app/components/app_bar_commerce.dart';
import 'package:commerce_flutter/app/components/background_commerce.dart';
import 'package:commerce_flutter/values/color.dart';
import 'package:flutter/material.dart';

class UserEditView extends StatelessWidget {
  const UserEditView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommerce(
        onBack: () {},
        title: 'Dados Pessoais',
      ),
      body: BackgroundCommerce(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width/2, child: OutlinedButton(onPressed: () {}, child: Text('EDITAR')))
                ],
              ),
              SizedBox(height: 15),
              Column(
                children: [
                  TextFormField(
                    initialValue: 'Maria da Silva',
                    enabled: false,
                    style: TextStyle(color: kCommerceGray50),
                    decoration: InputDecoration(
                      labelText: 'Nome Completo',
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    initialValue: '000.000.000-00',
                    enabled: false,
                    style: TextStyle(color: kCommerceGray50),
                    decoration: InputDecoration(
                      labelText: 'CPF',
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    initialValue: "00/00/00",
                    enabled: false,
                    style: TextStyle(color: kCommerceGray50),
                    decoration: InputDecoration(
                      labelText: 'Data de Nascimento',
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    initialValue: "Masculino",
                    enabled: false,
                    style: TextStyle(color: kCommerceGray50),
                    decoration: InputDecoration(
                      labelText: 'Gênero',
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    initialValue: "+55 (00) 00000-0000",
                    enabled: false,
                    style: TextStyle(color: kCommerceGray50),
                    decoration: InputDecoration(
                      labelText: 'Telefone',
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    initialValue: "mariadasilva@gmail.com",
                    enabled: false,
                    style: TextStyle(color: kCommerceGray50),
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    readOnly: true,
                    obscureText: true,
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: '87643276234672',
                      labelText: 'Senha',
                    ),
                  ),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
