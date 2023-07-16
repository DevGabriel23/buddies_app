import 'package:buddies_app/const.dart';
import 'package:buddies_app/features/pets/presentation/pet/pet_bloc.dart';
import 'package:buddies_app/widgets/button_form_widget.dart';
import 'package:buddies_app/widgets/input_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/breed_picker_widget.dart';
import '../../../widgets/date_picker_widget.dart';
import '../../../widgets/dropdown_picker_widget.dart';
import '../domain/entities/pet/pet_entity.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({Key? key}) : super(key: key);

  @override
  _AddPetPageState createState() => _AddPetPageState();
}
class _AddPetPageState extends State<AddPetPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _birthController.dispose();
    _typeController.dispose();
    _breedController.dispose();
    _genderController.dispose();
    _descriptionController.dispose();
    _sizeController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: true,
        title: const Text(
          'Nueva mascota',
          style: Font.pageTitleStyle,
        ),
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: SizedBox(
              width: 40.0,
              height: 30.0,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: black,
                  size: 30.0,
                ),
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<PetBloc, PetState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  InputFormWidget(
                    title: 'Nombre',
                    controller: _nameController,
                  ),
                  DatePickerWidget(
                    controller: _birthController,
                  ),
                  DropdownPickerWidget(
                    title: 'Tipo',
                    value: _typeController.text,
                    options: ['Perro', 'Gato'],
                    onChanged: (newValue) {
                      setState(() {
                        _typeController.text = newValue;
                      });
                    },
                  ),
                  InputFormWidget(
                    title: 'Tamaño',
                    controller: _sizeController,
                  ),
                  BreedPickerWidget(
                    petType: _typeController.text.toLowerCase(),
                    selectedBreed: _breedController.text,

                    onChanged: (breed) {
                      setState(() {
                        print(_breedController.text);

                        _breedController.text = breed;
                      });
                    },
                  ),

                  DropdownPickerWidget(
                    title: 'Sexo',
                    value: _genderController.text,
                    options: ['Macho', 'Hembra'],
                    onChanged: (newValue) {
                      setState(() {
                        _genderController.text = newValue;
                      });
                    },
                  ),
                  InputFormWidget(
                    title: 'Describe a tu mascota',
                    controller: _descriptionController,
                    height: 100.0,
                  ),
                  ButtonFormWidget(
                    onPressed: ()  {
                      final pet = PetEntity(
                        name: _nameController.text,
                        birthday: _birthController.text,
                        type: _typeController.text,
                        breed: _breedController.text,
                        gender: _genderController.text,
                        size: _sizeController.text,
                        description: _descriptionController.text,
                        owner_id: 1,
                      );
                      print(pet.size);
                      context.read<PetBloc>().add(CreatePetEvent(pet: pet));
                      Navigator.pop(context); // Regresar a la página anterior (PetsPage)
                      context.read<PetBloc>().add(GetPetsEvent());

                    },
                    text: 'Guardar',
                    height: 50.0,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }


}

