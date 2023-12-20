import 'package:basura_fortuna_corp/core/constant.dart';
import 'package:basura_fortuna_corp/core/dialogs.dart';
import 'package:basura_fortuna_corp/infraestructure/infraestructure.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:basura_fortuna_corp/presentation/widgets/widgets.dart';
import 'package:logger/logger.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    super.initState();
    getPymeProfileData();
  }

  Color color1 = const Color(0xFF021024);
  Color color2 = const Color(0xFF052659);
  Color color3 = const Color(0xFF5483B3);
  Color color4 = const Color(0xFF7DA0CA);
  Color color5 = const Color(0xFFC1E8FF);

  final GlobalKey<FormState> _editProfileFormState = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dniController = TextEditingController();
  final TextEditingController pymeNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController recyclingTypeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool isLoading = true;
  PymesInfo? pymeProfile;

  String? name;
  String? email;
  String? prePhone;
  int? phone;
  String? address;

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

  static final Logger _logger = Logger();

  // Funcion para traer los datos de la pyme
  Future<void> getPymeProfileData() async {
    try {
      final profileResponse =
          await Dio().get('$pymeProfileUrl?email=$emailForApi');

      if (profileResponse.statusCode == 200) {
        pymeProfile = PymesInfo.fromJson(profileResponse.data);
      }
    } catch (e) {
      _logger.e(e.toString());
    }

    // get address

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
      setState(() {
        isLoading = false;
      });
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

  // funcion para actualizar perfil
  Future<void> updateProfile() async {
    email = pymeProfile?.email;
    int? communeId = selectedCommune == null
        ? pymeProfile?.pymeAddress.commune.id
        : selectedCommune!.id;

    Map<String, dynamic> updateData = {
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
      "commune_id": communeId
    };

    try {
      await Dio().post(editProfileUrl, data: updateData);
      // ignore: use_build_context_synchronously
      DialogExitoActualizarPerfil(context);
    } catch (error) {
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

    return Padding(
      padding: const EdgeInsets.all(20),
      child: isLoading
          ? const LoadingWidget()
          : SingleChildScrollView(
              child: Form(
                key: _editProfileFormState,
                child: Column(
                  children: [
                    // title
                    Text(
                      'Mi Perfil',
                      style: TextStyle(
                        color: color1,
                        fontSize: 32,
                        fontFamily: 'Assistant',
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 25),

                    // email
                    TextInput(
                      labelTitle: 'Email: ${pymeProfile?.email}',
                      obscureText: false,
                      status: false,
                      textColor: color2,
                      hintColor: color2,
                      labelColor: color1,
                      borderColor: color2,
                      iconColor: color1,
                      labelIcon: Icons.alternate_email_rounded,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 15),

                    // dni
                    TextInput(
                      labelTitle: 'Rut: ${pymeProfile?.dni}',
                      obscureText: false,
                      status: false,
                      textColor: color2,
                      hintColor: color2,
                      labelColor: color1,
                      borderColor: color2,
                      iconColor: color1,
                      labelIcon: Icons.confirmation_number_outlined,
                      controller: dniController,
                      keyboardType: TextInputType.text,
                    ),

                    const SizedBox(height: 15),

                    // pyme name
                    TextInput(
                      labelTitle: 'Nombre: ${pymeProfile?.name}',
                      hintText: 'Nombre',
                      obscureText: false,
                      textColor: color2,
                      hintColor: color2,
                      labelColor: color1,
                      borderColor: color2,
                      iconColor: color1,
                      labelIcon: Icons.account_circle_outlined,
                      controller: pymeNameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (pymeNameController.text.isEmpty) {
                          name = (pymeProfile?.name).toString();
                          return null;
                        } else {
                          name = pymeNameController.text;
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    // phone
                    TextInput(
                      labelTitle: 'Celular: ${pymeProfile?.phone}',
                      hintText: 'Celular',
                      obscureText: false,
                      textColor: color2,
                      hintColor: color2,
                      labelColor: color1,
                      borderColor: color2,
                      iconColor: color1,
                      labelIcon: Icons.phone_android_outlined,
                      controller: phoneController,
                      inputFormat: phoneMask,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (phoneController.text.isEmpty) {
                          phone = pymeProfile?.phone;
                          return null;
                        } else {
                          prePhone = phoneController.text;
                          phone = int.tryParse(prePhone!.replaceAll(' ', ''));
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    // address
                    TextInput(
                      labelTitle:
                          'Dirección: ${pymeProfile?.pymeAddress.additional}',
                      hintText: 'Dirección',
                      obscureText: false,
                      textColor: color2,
                      hintColor: color2,
                      labelColor: color1,
                      borderColor: color2,
                      iconColor: color1,
                      labelIcon: Icons.place_outlined,
                      controller: addressController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (addressController.text.isEmpty) {
                          address =
                              (pymeProfile?.pymeAddress.additional).toString();
                          return null;
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
                      hintText: pymeProfile
                          ?.pymeAddress.commune.province?.region.regionName,
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
                    ),

                    const SizedBox(height: 15),

                    //=== PROVINCIA
                    DropdownButtonWidget(
                      hintText: pymeProfile?.pymeAddress.commune.province?.name,
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
                    ),

                    const SizedBox(height: 15),

                    //=== COMUNA
                    DropdownButtonWidget(
                      hintText: pymeProfile?.pymeAddress.commune.name,
                      items: communes,
                      value: selectedCommune,
                      onChanged: (newValue) {
                        setState(() {
                          selectedCommune = newValue;
                        });
                      },
                      itemToString: (commune) => commune.name,
                    ),

                    const SizedBox(height: 30),

                    // button
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Button(
                          buttonText: 'Guardar',
                          onPress: () {
                            if (_editProfileFormState.currentState!.validate()) {
                              updateProfile();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
