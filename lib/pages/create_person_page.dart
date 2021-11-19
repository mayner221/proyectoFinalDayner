import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:http/http.dart' as http;
import 'package:proyecto_final/models/person.dart';

import 'form_add_employed.dart';

class CreatePersonPage extends StatefulWidget {
  const CreatePersonPage({Key? key}) : super(key: key);

  @override
  _CreatePersonPageState createState() => _CreatePersonPageState();
}

class _CreatePersonPageState extends State<CreatePersonPage> {
  Person person = Person();

  var textEditingControllerName = TextEditingController();
  var textEditingControllerLastName = TextEditingController();
  var textEditingControllerDireccion = TextEditingController();
  var textEditingControllerFechaNacimiento = TextEditingController();
  var textEditingControllerSalario = TextEditingController();
  var textEditingControllerFechaIngreso = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear pagina '),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              TextField(
                controller: textEditingControllerName,
                decoration: InputDecoration(hintText: 'Ingresa nombre:'),
              ),
              SizedBox(height: 30.0),
              TextField(
                controller: textEditingControllerLastName,
                decoration: InputDecoration(hintText: 'Ingresa apellido:'),
              ),
              SizedBox(height: 30.0),
              TextField(
                controller: textEditingControllerDireccion,
                decoration: InputDecoration(hintText: 'Ingresa la dirección:'),
              ),
              SizedBox(height: 30.0),
              TextField(
                controller: textEditingControllerFechaNacimiento,
                decoration: InputDecoration(
                    hintText: 'Ingresa la fecha de nacimiento:'),
              ),
              SizedBox(height: 30.0),
              TextField(
                controller: textEditingControllerSalario,
                decoration: InputDecoration(hintText: 'Ingresa salario:'),
              ),
              SizedBox(height: 30.0),
              TextField(
                controller: textEditingControllerFechaIngreso,
                decoration: InputDecoration(hintText: 'fecha ingreso:'),
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/screen2');

                    callServiceCreatePerson(
                        textEditingControllerName.text,
                        textEditingControllerLastName.text,
                        textEditingControllerDireccion.text,
                        textEditingControllerFechaNacimiento.text,
                        textEditingControllerSalario.text,
                        textEditingControllerFechaIngreso.text);
                  },
                  child: Text('Crear persona')),
                  //Crea el registro y todo pero me falta hacer que el cambio sea inmediato
            ],
          ),
        ),
      ),
    );
  }

  void callServiceCreatePerson(String name, String lastname, String direccion,
      String fechaNacimiento, String salario, String fechaIngreso) async {
    var person = Person(
        name: name,
        lastname: lastname,
        direccion: direccion,
        fechaNacimiento: fechaNacimiento,
        salario: salario,
        fechaIngreso: fechaIngreso);

    var url = Uri.parse('https://619040abf6bf450017484bb3.mockapi.io/Persons/');
    var personBody = jsonEncode(person);

    Response response = await http.post(
      url,
      body: personBody,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode >= 200 && response.statusCode <= 300) {
    } else {
      print("ñe");
    }
  }
}
