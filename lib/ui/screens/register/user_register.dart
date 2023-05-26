// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:registrovot/controller/mainController.dart';
import 'package:registrovot/model/leader.dart';
import 'package:registrovot/model/puesto.dart';
import 'package:registrovot/model/votante.dart';
import 'package:registrovot/ui/common/staticsFields.dart';
import 'package:searchfield/searchfield.dart';

class UserRegister extends StatefulWidget {
  UserRegister({Key? key}) : super(key: key);

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  TextEditingController cedula = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController direccion = TextEditingController();
  TextEditingController edad = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController municipioTextEditingController =
      TextEditingController();
  TextEditingController barrioTextEditingController = TextEditingController();
  TextEditingController liderTextEditingController = TextEditingController();
  TextEditingController puestoTextEditingController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  List<Leader> aux = [];
  List<String> leadersname = [];
  List<String> puestoname = [];
  List<Puesto> filter = [];
  List<Leader> filterLeader = [];

  MainController mainController = Get.find();
  StaticFields staticfields = StaticFields();

  bool enable = false;
  bool update = false;
  String? valueIDleader;
  Leader? valueLeader2;
  TextEditingController valuemunicipio = TextEditingController();
  TextEditingController valuebarrio = TextEditingController();
  TextEditingController valueleader = TextEditingController();
  TextEditingController valuepuesto = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                      width: 500,
                      child: _textFormField(
                          'Cedula', TextInputType.number, cedula, true)),
                  const SizedBox(
                    width: 40,
                  ),
                  TextButton(
                    onPressed: () async {
                      if (cedula.text.isEmpty) {
                        AwesomeDialog(
                                width: 566,
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                headerAnimationLoop: false,
                                title: 'Campos vacios',
                                desc: 'Digite una cedula',
                                btnOkOnPress: () {},
                                btnOkIcon: Icons.cancel,
                                btnOkColor: const Color(0xffff004e))
                            .show();
                      } else {
                        final response =
                            await mainController.getoneVotante(cedula.text);
                        if (response != null) {
                          setState(() {
                            enable = true;
                            update = true;

                            nombre.text = response.name;
                            cedula.text = response.id;
                            valuemunicipio.text = response.municipio;

                            valueleader.text = filterLeader
                                .firstWhere((element) =>
                                    element.id == response.leaderID)
                                .name
                                .toString();
                            valuepuesto.text = filter
                                .firstWhere((element) =>
                                    element.nombre == response.puestoID)
                                .nombre
                                .toString();

                            telefono.text = response.phone;
                            direccion.text = response.direccion;
                            edad.text = response.edad;
                            if (response.municipio != 'Valledupar') {
                              valuebarrio.clear();
                            } else {
                              valuebarrio.text = response.barrio!;
                            }
                          });
                        } else {
                          setState(() {
                            enable = true;
                            AwesomeDialog(
                                    width: 566,
                                    context: context,
                                    dialogType: DialogType.info,
                                    animType: AnimType.rightSlide,
                                    headerAnimationLoop: false,
                                    title: 'No existe',
                                    desc: 'El votante no ha sido registrado',
                                    btnOkOnPress: () {},
                                    btnOkIcon: Icons.cancel,
                                    btnOkColor: const Color(0xffff004e))
                                .show();
                          });
                        }
                      }
                    },
                    style: TextButton.styleFrom(
                      fixedSize: const Size(120, 40),
                      backgroundColor: const Color(0xffff004e),
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                    ),
                    child: const Text(
                      'Buscar',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Visibility(
                visible: enable,
                child: Row(
                  children: [
                    const Text(
                      'Municipio',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      width: 500,
                      height: 50,
                      child: Form(
                          child: SearchField<Municipio>(
                        onSuggestionTap: (_) {
                          print("object");
                        },
                        suggestions: staticfields
                            .getMunicipios()
                            .map((e) =>
                                SearchFieldListItem<Municipio>(e.nombre!))
                            .toList(),
                        suggestionState: Suggestion.expand,
                        textInputAction: TextInputAction.next,
                        hint: 'Seleccione',
                        searchStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.8),
                        ),
                        controller: valuemunicipio,
                        searchInputDecoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        maxSuggestionsInViewPort: 6,
                        itemHeight: 50,
                      )),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              valuemunicipio.text == 'Valledupar'
                  ? Row(
                      children: [
                        const Text(
                          'Barrio',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 45,
                        ),
                        SizedBox(
                          width: 500,
                          height: 50,
                          child: Form(
                              child: SearchField<Barrio>(
                            onSuggestionTap: (_) {
                              print("object");
                            },
                            controller: valuebarrio,
                            suggestions: staticfields
                                .getBarrios()
                                .map((e) =>
                                    SearchFieldListItem<Barrio>(e.barrio!))
                                .toList(),
                            suggestionState: Suggestion.expand,
                            textInputAction: TextInputAction.next,
                            hint: 'Seleccione',
                            searchStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.8),
                            ),
                            // validator: (x) {
                            //   if (!_statesOfIndia.contains(x) || x!.isEmpty) {
                            //     return 'Please Enter a valid State';
                            //   }
                            //   return null;
                            // },
                            searchInputDecoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.8),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                            maxSuggestionsInViewPort: 6,
                            itemHeight: 50,
                          )),
                        )
                      ],
                    )
                  : const SizedBox(),
              SizedBox(
                width: 500,
                child: _textFormField(
                    'Nombres', TextInputType.text, nombre, enable),
              ),
              SizedBox(
                width: 500,
                child: _textFormField(
                    'Telefono', TextInputType.number, telefono, enable),
              ),
              SizedBox(
                width: 500,
                child: _textFormField(
                  'Edad',
                  TextInputType.number,
                  edad,
                  enable,
                ),
              ),
              Container(
                height: 40,
              ),
              FutureBuilder<List<Leader>>(
                  future: mainController.getLeaders(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    // if (valueleader == null) {
                    // }
                    filterLeader.clear();
                    for (var i = 0; i < snapshot.data!.length; i++) {
                      filterLeader.add(snapshot.data![i]);
                    }
                    return Visibility(
                      visible: enable,
                      child: Row(
                        children: [
                          const Text(
                            'Lider',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          SizedBox(
                            width: 500,
                            height: 50,
                            child: InkWell(
                              onTap: () {
                                print("object");
                              },
                              child: SearchField<Leader>(
                                onSuggestionTap: (lidel) {
                                  valueleader.text = lidel.item?.name ?? "yu";
                                  print(lidel.item);
                                },
                                controller: valueleader,
                                suggestions: filterLeader
                                    .map((e) =>
                                        SearchFieldListItem<Leader>(e.name!))
                                    .toList(),
                                suggestionState: Suggestion.expand,
                                textInputAction: TextInputAction.next,
                                hint: 'Seleccione',
                                searchStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.8),
                                ),
                                searchInputDecoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                ),
                                maxSuggestionsInViewPort: 6,
                                itemHeight: 50,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
              Container(
                height: 40,
              ),
              FutureBuilder<List<Puesto>>(
                  future: mainController.getPuestos(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    // for (var i = 0; i < snapshot.data!.length; i++) {
                    //   if (snapshot.data![i].municipio!.toLowerCase() ==
                    //       valuemunicipio.text.toLowerCase()) {
                    //     filter.add(snapshot.data![i]);
                    //   }
                    // }
                    for (var i = 0; i < snapshot.data!.length; i++) {
                      filter.add(snapshot.data![i]);
                    }
                    return Visibility(
                      visible: enable,
                      child: Row(
                        children: [
                          const Text(
                            'Puesto',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          SizedBox(
                            width: 500,
                            height: 50,
                            child: Form(
                                child: SearchField<Puesto>(
                              onSuggestionTap: (_) {
                                print("object");
                              },
                              controller: valuepuesto,
                              suggestions: filter
                                  .map((e) =>
                                      SearchFieldListItem<Puesto>(e.nombre!))
                                  .toList(),
                              suggestionState: Suggestion.expand,
                              textInputAction: TextInputAction.next,
                              hint: 'Seleccione',
                              searchStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.8),
                              ),
                              searchInputDecoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                              maxSuggestionsInViewPort: 6,
                              itemHeight: 50,
                            )),
                          )
                        ],
                      ),
                    );
                  }),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 516,
                  ),
                  TextButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        enable = false;
                        Votante votante = Votante(
                            name: nombre.text,
                            id: cedula.text,
                            leaderID: valueLeader2!.id!,
                            phone: telefono.text,
                            puestoID: valuepuesto.text,
                            direccion: direccion.text,
                            municipio: valuemunicipio.text,
                            barrio: valuebarrio.text,
                            edad: edad.text);
                        if (update) {
                          if (valuemunicipio.text != 'Valledupar') {
                            votante.barrio = null;
                          }
                          final response =
                              await mainController.updateVotante(votante);
                          AwesomeDialog(
                                  width: 566,
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.rightSlide,
                                  headerAnimationLoop: false,
                                  title: response,
                                  desc:
                                      'El votante fue actualizado correctamente',
                                  btnOkOnPress: () {},
                                  btnOkIcon: Icons.cancel,
                                  btnOkColor: const Color(0xff01b9ff))
                              .show();
                          nombre.clear();
                          cedula.clear();
                          telefono.clear();
                          direccion.clear();
                          edad.clear();
                          valuebarrio.clear();
                          valueleader.clear();
                          valuemunicipio.clear();
                          valuepuesto.clear();
                          setState(() {});
                        } else {
                          final response =
                              await mainController.addVotante(votante);
                          if (response == 'Ya Existe') {
                            AwesomeDialog(
                                    width: 566,
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    headerAnimationLoop: false,
                                    title: response,
                                    desc: 'El votante ya se encuentra creado',
                                    btnOkOnPress: () {},
                                    btnOkIcon: Icons.cancel,
                                    btnOkColor: const Color(0xffff004e))
                                .show();
                          } else {
                            AwesomeDialog(
                                    width: 566,
                                    context: context,
                                    dialogType: DialogType.success,
                                    animType: AnimType.rightSlide,
                                    headerAnimationLoop: false,
                                    title: response,
                                    desc:
                                        'El votante fue registrado correctamente',
                                    btnOkOnPress: () {},
                                    btnOkIcon: Icons.cancel,
                                    btnOkColor: const Color(0xff01b9ff))
                                .show();
                            nombre.clear();
                            cedula.clear();
                            telefono.clear();
                            direccion.clear();
                            edad.clear();
                            valuebarrio.clear();
                            valueleader.clear();
                            valuemunicipio.clear();
                            valuepuesto.clear();
                            setState(() {});
                          }
                        }
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xffff004e),
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                    ),
                    child: const Text(
                      'Registrar usuario',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          )),
        ),
      ),
    );
  }

  Widget _textFormField(String labelText, TextInputType input,
      TextEditingController controller, bool enable) {
    return TextFormField(
      enabled: enable,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      keyboardType: input,
      controller: controller,
      validator: (_) {
        if (_ == null || _.isEmpty) {
          return "Debe llenar este campo";
        }
        if (labelText == 'Edad') {
          if (int.parse(_) > 110 || int.parse(_) < 18) {
            return "número no válido";
          }
        }

        if (input == TextInputType.number && labelText != 'Edad') {
          if (_.length > 10) {
            return "número no válido";
          }
          if (_.length < 7) {
            return "número no válido";
          }
        }
      },
      onChanged: (_) {},
    );
  }
}
