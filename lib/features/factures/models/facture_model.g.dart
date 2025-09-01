// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facture_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FactureModelAdapter extends TypeAdapter<FactureModel> {
  @override
  final int typeId = 3;

  @override
  FactureModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FactureModel(
      id: fields[0] as String,
      numeroFacture: fields[1] as String,
      nomClient: fields[2] as String,
      auteurId: fields[3] as String,
      service: fields[4] as ServiceModel?,
      laveurId: fields[5] as String,
      montant: fields[6] as double,
      montantTotal: fields[7] as double,
      commissionLaveur: fields[8] as double,
      partEntreprise: fields[9] as double,
      statut: fields[10] as StatutFacture,
      modePaiement: fields[11] as ModePaiement,
      dateHeure: fields[12] as DateTime,
      commentaire: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FactureModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.numeroFacture)
      ..writeByte(2)
      ..write(obj.nomClient)
      ..writeByte(3)
      ..write(obj.auteurId)
      ..writeByte(4)
      ..write(obj.service)
      ..writeByte(5)
      ..write(obj.laveurId)
      ..writeByte(6)
      ..write(obj.montant)
      ..writeByte(7)
      ..write(obj.montantTotal)
      ..writeByte(8)
      ..write(obj.commissionLaveur)
      ..writeByte(9)
      ..write(obj.partEntreprise)
      ..writeByte(10)
      ..write(obj.statut)
      ..writeByte(11)
      ..write(obj.modePaiement)
      ..writeByte(12)
      ..write(obj.dateHeure)
      ..writeByte(13)
      ..write(obj.commentaire);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FactureModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StatutFactureAdapter extends TypeAdapter<StatutFacture> {
  @override
  final int typeId = 1;

  @override
  StatutFacture read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return StatutFacture.paye;
      case 1:
        return StatutFacture.nonPaye;
      case 2:
        return StatutFacture.enCours;
      default:
        return StatutFacture.paye;
    }
  }

  @override
  void write(BinaryWriter writer, StatutFacture obj) {
    switch (obj) {
      case StatutFacture.paye:
        writer.writeByte(0);
        break;
      case StatutFacture.nonPaye:
        writer.writeByte(1);
        break;
      case StatutFacture.enCours:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatutFactureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ModePaiementAdapter extends TypeAdapter<ModePaiement> {
  @override
  final int typeId = 2;

  @override
  ModePaiement read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ModePaiement.espece;
      case 1:
        return ModePaiement.mobile;
      case 2:
        return ModePaiement.carte;
      default:
        return ModePaiement.espece;
    }
  }

  @override
  void write(BinaryWriter writer, ModePaiement obj) {
    switch (obj) {
      case ModePaiement.espece:
        writer.writeByte(0);
        break;
      case ModePaiement.mobile:
        writer.writeByte(1);
        break;
      case ModePaiement.carte:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModePaiementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
