import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:http/http.dart';

import 'package:proyecto_final/models/person.dart';

import 'dart:convert';

class FormAddEmployed extends StatefulWidget {
  const FormAddEmployed({Key? key}) : super(key: key);

  @override
  _FormAddEmployedState createState() => _FormAddEmployedState();
}

class _FormAddEmployedState extends State<FormAddEmployed> {
  List<Person> listPersons = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registros'),
        backgroundColor: Colors.brown,
        actions: [
          GestureDetector(
            onTap: () => callServiceGetListPerson(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.update),
              //Para que los cambios sean visibles dele en ese icono
            ),
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: listPersons.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(
                  left: 10.0, right: 10.0, bottom: 10.0, top: 10.0),
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://estaticos.muyinteresante.es/media/cache/1140x_thumb/uploads/images/gallery/59c4f5655bafe82c692a7052/gato-marron_0.jpg'),
                      ),
                      title: Text(
                          '${listPersons[index].lastname} ${listPersons[index].name}'),
                      subtitle: Text('${listPersons[index].id!} ${listPersons[index].direccion!}'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          child: const Text('Editar'),
                          onPressed: () {
                            callServiceUpdatePerson(
                              listPersons[index].id!,
                            );
                          },
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          child: const Text('Borrar'),
                          onPressed: () {
                            deleteData(listPersons[index].id!);
                          },
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => callCreatePersonsPage(),
        child: Icon(Icons.add),
      ),
    );
  }

  callCreatePersonsPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FormAddEmployed(),
        ));
  }

  callServiceGetListPerson() async {
    var url = Uri.parse('https://619040abf6bf450017484bb3.mockapi.io/Persons/');

    Response response = await http.get(url);

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      listPersons = (json.decode(response.body) as List).map((personjson) {
        return Person.fromJson(personjson);
      }).toList();

      setState(() {});
    } else {
      print("ñe");
    }
  }

  deleteData(String id) async {
    try {
      Response response = await http.delete(Uri.parse(
          'https://619040abf6bf450017484bb3.mockapi.io/Persons/' + id));

      if (response.statusCode >= 200 && response.statusCode <= 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {}
  }

  Future callServiceUpdatePerson(
    String id,
  ) async {
    var person = Person(
        id: "53",
        name: "name1",
        lastname: "lastname1",
        direccion: "direccion1",
        fechaNacimiento: "fechaNacimiento1",
        salario: "salario1",
        fechaIngreso: "fechaIngreso1");

    var personBody = jsonEncode(person);

    var url =
        Uri.parse('https://619040abf6bf450017484bb3.mockapi.io/Persons/' + id);

    Response response = await http.post(
      url,
      body: personBody,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 200) {
      print(url);
    } else {
      print(url);
    }
  }

  // static Future<String> updateEmployed(
  //     String id,
  //     String name,
  //     String lastname,
  //     String direccion,
  //     String fechaNacimiento,
  //     String salario,
  //     String fechaIngreso) async {
  //   try {
  //     var map = Map<String, dynamic>();
  //     map['name'] = name;
  //     map['lastname'] = lastname;
  //     map['direccion'] = direccion;
  //     map['fechaIngreso'] = fechaIngreso;
  //     map['salario'] = salario;
  //     map['fechaIngreso'] = fechaIngreso;

  //     var mapBody = jsonEncode(map);

  //     var url = Uri.parse('https://619040abf6bf450017484bb3.mockapi.io/Persons/' + id);

  //     final response = await http.post(
  //       url,
  //       body: mapBody,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8'
  //       },
  //     );

  //     print('updateEmployee Response: ${response.body}');
  //     if (200 == response.statusCode) {
  //       return response.body;
  //     } else {
  //       return "error";
  //     }
  //   } catch (e) {
  //     return "error";
  //   }
  // }

  // Future putData(String id, String name, String lastname, String direccion,
  //     String fechaNacimiento, String salario, String fechaIngreso) async {
  //   try {
  //     Response response = await http.put(
  //         Uri.parse('https://619040abf6bf450017484bb3.mockapi.io/Persons/' +
  //             id.toString()),
  //         body: {
  //           'id': id,
  //           'name': name,
  //           'lastname': lastname,
  //           'direccion': direccion,
  //           'fechaNacimiento': fechaNacimiento,
  //           'salario': salario,
  //           'fechaIngreso': fechaIngreso,
  //         });

  //     if (response.statusCode >= 200 && response.statusCode <= 300) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {}
  // }
}
