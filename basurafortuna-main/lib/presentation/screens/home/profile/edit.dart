import 'package:basura_fortuna/core/constant.dart';
import 'package:basura_fortuna/core/dialogs.dart';
import 'package:basura_fortuna/infraestructure/infraestructure.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:basura_fortuna/presentation/widgets/widgets.dart';
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
    getMyProfile();
  }

  Color color1 = const Color(0xFF021024);
  Color color2 = const Color(0xFF052659);
  Color color3 = const Color(0xFF5483B3);
  Color color4 = const Color(0xFF7DA0CA);
  Color color5 = const Color(0xFFC1E8FF);
  String required = '* Campo requerido';

  // forms controllers
  final GlobalKey<FormState> _editProfileFormState = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dniController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool isLoading = true;
  Profile? myProfile;

  String? name;
  String? lastname;
  String? username;
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

  // funcion para traer los datos del perfil
  Future<void> getMyProfile() async {
    try {
      final myProfileRequest =
          await Dio().get('$profileUrl?email=$emailForApi');

      if (myProfileRequest.data != null) {
        myProfile = Profile.fromJson(myProfileRequest.data);
      }
    } catch (error) {
      if (error is DioException) {
        DioException dioException = error;
        switch (dioException.type) {
          case DioExceptionType.badResponse:
            _logger.i(dioException.response?.statusCode);
            _logger.i(dioException.response?.statusMessage);
            break;
          default:
            _logger.e(error.toString());
            _logger.d(error.toString());
        }
      } else {
        _logger.e(error.toString());
        _logger.d(error.toString());
      }
    }

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
    email = myProfile?.email;
    int? communeId = selectedCommune == null
        ? myProfile?.userAddress.commune.id
        : selectedCommune!.id;

    Map<String, dynamic> updateData = {
      "name": name,
      "lastname": lastname,
      "username": username,
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
                      labelTitle: 'Email: ${myProfile?.email}',
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
                      labelTitle: 'Rut: ${myProfile?.dni}',
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

                    // name
                    TextInput(
                      labelTitle: 'Nombre: ${myProfile?.name}',
                      hintText: 'Nombre',
                      obscureText: false,
                      textColor: color2,
                      hintColor: color2,
                      labelColor: color1,
                      borderColor: color2,
                      iconColor: color1,
                      labelIcon: Icons.account_circle_outlined,
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (nameController.text.isEmpty) {
                          name = (myProfile?.name).toString();
                          return null;
                        } else {
                          name = nameController.text;
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    // lastname
                    TextInput(
                      labelTitle: 'Apellido: ${myProfile?.lastname}',
                      hintText: 'Apellido',
                      obscureText: false,
                      textColor: color2,
                      hintColor: color2,
                      labelColor: color1,
                      borderColor: color2,
                      iconColor: color1,
                      labelIcon: Icons.account_circle_outlined,
                      controller: lastnameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (lastnameController.text.isEmpty) {
                          lastname = (myProfile?.lastname).toString();
                          return null;
                        } else {
                          lastname = lastnameController.text;
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    // username
                    TextInput(
                      labelTitle: 'Nombre de usuario: ${myProfile?.username}',
                      hintText: 'Nombre de usuario',
                      obscureText: false,
                      textColor: color2,
                      hintColor: color2,
                      labelColor: color1,
                      borderColor: color2,
                      iconColor: color1,
                      labelIcon: Icons.account_circle,
                      controller: usernameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (usernameController.text.isEmpty) {
                          username = (myProfile?.username).toString();
                          return null;
                        } else {
                          username = usernameController.text;
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    // phone
                    TextInput(
                      labelTitle: 'Celular: ${myProfile?.phone}',
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
                          phone = myProfile?.phone;
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
                          'Dirección: ${myProfile?.userAddress.additional}',
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
                              (myProfile?.userAddress.additional).toString();
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
                      hintText: myProfile
                          ?.userAddress.commune.province?.region.regionName,
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
                      hintText: myProfile?.userAddress.commune.province?.name,
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
                      hintText: myProfile?.userAddress.commune.name,
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
                            if (_editProfileFormState.currentState!
                                .validate()) {
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
