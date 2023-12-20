import 'package:basura_fortuna_corp/core/constant.dart';
import 'package:basura_fortuna_corp/core/dialogs.dart';
import 'package:basura_fortuna_corp/core/validations/email_validation.dart';
import 'package:basura_fortuna_corp/infraestructure/infraestructure.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:basura_fortuna_corp/presentation/widgets/widgets.dart';
import 'package:logger/logger.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:validate_rut/validate_rut.dart';

enum RecyclingType {
  PLASTICO,
  PAPEL_CARTON,
  VIDRIO,
  RESIDUOS_ELECTRONICOS_ELECTRICOS,
  RESIDUOS_PELIGROSOS,
  MATERIA_ORGANICA,
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
    getRPC();
  }

  // Color color1 = const Color(0xFF021024);
  // Color color2 = const Color(0xFF052659);
  // Color color3 = const Color(0xFF5483B3);
  // Color color4 = const Color(0xFF7DA0CA);
  Color color5 = const Color(0xFFC1E8FF);
  String required = '* Campo requerido';

  // forms controllers
  final GlobalKey<FormState> _createAccountFormState = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dniController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController typeRecyclingController = TextEditingController();
  static final Logger _logger = Logger();

  String? name;
  String? preDni;
  int? dni;
  String? email;
  String? prePhone;
  int? phone;
  String? password;
  String? address;
  // bool? status;
  int? typeRecycling;
  int? selectedRecyclingType;

  List<Region> regions = [];
  List<Region> regionsResp = [];
  List<Province> provinces = [];
  List<Province> provincesResp = [];
  List<Commune> communes = [];
  List<Commune> communesResp = [];

  Region? selectedRegion;
  Province? selectedProvince;
  Commune? selectedCommune;

  List<DropdownMenuItem<Province>> provincesDropdownItems = [];

  // obteniendo region, provincia, comuna para dropdown
  Future<void> getRPC() async {
    try {
      final regionRequest = await Dio().get(regionUrl);
      final provinceRequest = await Dio().get(provinceUrl);
      final communeRequest = await Dio().get(communeUrl);

      List<dynamic> regionsDataList = regionRequest.data;
      List<dynamic> provincesDataList = provinceRequest.data;
      List<dynamic> communesDataList = communeRequest.data;

      for (var regionData in regionsDataList) {
        Region region = Region.fromJson(regionData);
        regions.add(region);
        regionsResp.add(region);
      }

      // Segun el Id de la region, tengo que cargar las provincias
      for (var provinceData in provincesDataList) {
        Province province = Province.fromJson(provinceData);
        provincesResp.add(province);
      }

      // Segun el Id de la provincia, tengo que cargar las comunas
      for (var communeData in communesDataList) {
        Commune commune = Commune.fromJson(communeData);
        communesResp.add(commune);
      }

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  List<Province> getProvinces(String id) {
    int idIn = int.parse(id);
    return provincesResp.where((p) => idIn == p.region.id).toList();
  }

  List<Commune> getCommunes(String id) {
    int idIn = int.parse(id);
    return communesResp.where((c) => idIn == c.province?.id).toList();
  }

  // funcion para crear un nuevo usuario
  Future<void> createUser() async {
    int? communeId = selectedCommune!.id;

    Map<String, dynamic> createData = {
      "name": name,
      "dni": dni,
      "email": email,
      "password": password,
      "phone": phone,
      "address": address,
      "commune_id": communeId,
      "status": true,
      "type_recycling": selectedRecyclingType
    };

    print('createData: $createData');

    try {
      await Dio().post(pymeRegistrationUrl, data: createData);
      // ignore: use_build_context_synchronously
      DialogExitoCrearCuenta(context);
    } catch (error) {
      _logger.e(error);
      // ignore: use_build_context_synchronously
      DialogError(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    //==== formato número de telefono
    var phoneMask = MaskTextInputFormatter(
      mask: '9 #### ####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );

    //==== formato RUT
    var rutMask = RutInputFormatter();

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarLogin(title: 'Nuevo Registro'),
      ),
      body: BackgroundColor(
        widget: Padding(
          padding: const EdgeInsets.all(40),
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _createAccountFormState,
                child: Column(
                  children: [
                    Icon(
                      Icons.account_circle_rounded,
                      color: color5,
                      size: 140,
                    ),
                    const SizedBox(height: 30),

                    // name
                    TextInput(
                      labelTitle: 'Nombre',
                      hintText: 'Nombre',
                      obscureText: false,
                      labelIcon: Icons.account_circle_outlined,
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (nameController.text.isEmpty) {
                          return required;
                        } else {
                          name = nameController.text;
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    // dni
                    TextInput(
                      labelTitle: 'Rut',
                      hintText: 'Rut',
                      obscureText: false,
                      labelIcon: Icons.confirmation_number_outlined,
                      controller: dniController,
                      inputFormat: rutMask,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (dniController.text.isEmpty) {
                          return required;
                        } else {
                          preDni = (dniController.text)
                              .replaceAll(RegExp(r'[k.-]'), '');
                          print('preDni: $preDni');
                          print('preDni: ${preDni.runtimeType}');
                          dni = int.tryParse(preDni!);
                          print('dni: $dni');
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    // email
                    TextInput(
                      labelTitle: 'Email',
                      hintText: 'Email',
                      obscureText: false,
                      labelIcon: Icons.alternate_email_rounded,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (emailController.text.isEmpty) {
                          return required;
                        } else if (!esFormatoEmailValido(value!)) {
                          return 'Formato de email no válido';
                        } else {
                          email = emailController.text;
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    // phone
                    TextInput(
                      labelTitle: 'Celular',
                      hintText: 'Celular',
                      obscureText: false,
                      labelIcon: Icons.phone_android_outlined,
                      controller: phoneController,
                      inputFormat: phoneMask,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (phoneController.text.isEmpty) {
                          return required;
                        } else {
                          prePhone = phoneController.text;
                          phone = int.tryParse(prePhone!.replaceAll(' ', ''));
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    // password
                    TextInput(
                      labelTitle: 'Contraseña',
                      hintText: 'Contraseña minimo 6 caracteres',
                      obscureText: true,
                      labelIcon: Icons.lock_outline_rounded,
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (passwordController.text.isEmpty) {
                          return required;
                        } else if (passwordController.text.length < 6) {
                          return 'Minimo 6 caracteres';
                        } else {
                          password = passwordController.text;
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    // ! recycling type
                    DropdownButtonFormField<int>(
                      dropdownColor: const Color(0xFF021024),
                      decoration: InputDecoration(
                        labelText: 'Tipo de Reciclaje',
                        labelStyle: const TextStyle(
                          color: Color(0xFFC1E8FF),
                          fontSize: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xFF79747E)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xFF79747E)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      value: selectedRecyclingType,
                      onChanged: (int? value) {
                        setState(() {
                          selectedRecyclingType = value;
                        });
                      },
                      items: RecyclingType.values.map((RecyclingType type) {
                        return DropdownMenuItem<int>(
                          value: type.index,
                          child: Text(
                            type.toString().split('.')[1],
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color(0xFF7DA0CA),
                            ),
                          ),
                        );
                      }).toList(),
                      validator: (value) {
                        if (selectedRecyclingType == null) {
                          return '* Campo requerido';
                        } else {
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    // address
                    TextInput(
                      labelTitle: 'Dirección',
                      hintText: 'Dirección',
                      obscureText: false,
                      labelIcon: Icons.place_outlined,
                      controller: addressController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (addressController.text.isEmpty) {
                          return required;
                        } else {
                          address = addressController.text;
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    // REGION - PROVINCIA - COMUNA
                    //=== REGION
                    DropdownButtonWidget(
                      hintText: 'Seleccione región',
                      items: regions,
                      value: selectedRegion,
                      onChanged: (newValue) {
                        setState(
                          () {
                            selectedRegion = newValue;
                            provinces = [];
                            communes = [];
                            provinces = getProvinces(newValue!.id.toString());
                            // Carga los elementos del DropdownButtonFormField de provincias
                            provincesDropdownItems =
                                provinces.map((Province province) {
                              return DropdownMenuItem<Province>(
                                value: province,
                                child: Text(
                                  province.name,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList();
                            // Resetea la provincia seleccionada
                            selectedProvince = null;
                            selectedCommune = null;
                          },
                        );
                      },
                      itemToString: (region) => region.regionName,
                      validator: (value) {
                        if (selectedRegion == null) {
                          return '* Campo requerido';
                        } else {
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    //=== PROVINCIA
                    DropdownButtonWidget(
                      hintText: 'Seleccione provincia',
                      items: provinces,
                      value: selectedProvince,
                      onChanged: (newValue) {
                        setState(() {
                          selectedProvince = newValue;
                          communes = getCommunes(newValue!.id.toString());
                          selectedCommune = null;
                        });
                      },
                      itemToString: (province) => province.name,
                      validator: (value) {
                        if (selectedProvince == null) {
                          return '* Campo requerido';
                        } else {
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    //=== COMUNA
                    DropdownButtonWidget(
                      hintText: 'Seleccione comuna',
                      items: communes,
                      value: selectedCommune,
                      onChanged: (newValue) {
                        setState(() {
                          selectedCommune = newValue;
                        });
                      },
                      itemToString: (commune) => commune.name,
                      validator: (value) {
                        if (selectedCommune == null) {
                          return '* Campo requerido';
                        } else {
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Button(
                          buttonText: 'Registrar',
                          onPress: () {
                            if (_createAccountFormState.currentState!
                                .validate()) {
                              createUser();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
