import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';
import 'package:buddies_app/features/pets/domain/repository/pet_repository/pet_repository.dart';

class DeletePetUseCase {
  final PetRepository repository;

  DeletePetUseCase({required this.repository});

  Future<void> call(PetEntity pet) async {
    return await repository.deletePet(pet);
  }
}