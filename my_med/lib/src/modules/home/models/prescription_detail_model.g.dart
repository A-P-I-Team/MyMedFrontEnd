// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_detail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrescriptionModelAdapter extends TypeAdapter<PrescriptionModel> {
  @override
  final int typeId = 0;

  @override
  PrescriptionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrescriptionModel(
      id: fields[0] as String,
      name: fields[1] as String,
      dosage: fields[2] as double,
      doctor: fields[3] as Doctor,
      consumptionAmount: fields[4] as String,
      consumptionStart: fields[5] as DateTime?,
      consumptionTimes: fields[6] as int,
      consumptionDuration: fields[7] as String,
      consumptionMethod: fields[12] as String,
      description: fields[8] as String,
      changeRequests: (fields[9] as List).cast<dynamic>(),
      isActive: fields[10] as bool,
      isGreen: fields[11] as bool,
      isReminderOn: fields[13] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, PrescriptionModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.dosage)
      ..writeByte(3)
      ..write(obj.doctor)
      ..writeByte(4)
      ..write(obj.consumptionAmount)
      ..writeByte(5)
      ..write(obj.consumptionStart)
      ..writeByte(6)
      ..write(obj.consumptionTimes)
      ..writeByte(7)
      ..write(obj.consumptionDuration)
      ..writeByte(8)
      ..write(obj.description)
      ..writeByte(9)
      ..write(obj.changeRequests)
      ..writeByte(10)
      ..write(obj.isActive)
      ..writeByte(11)
      ..write(obj.isGreen)
      ..writeByte(12)
      ..write(obj.consumptionMethod)
      ..writeByte(13)
      ..write(obj.isReminderOn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrescriptionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DoctorAdapter extends TypeAdapter<Doctor> {
  @override
  final int typeId = 1;

  @override
  Doctor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Doctor(
      id: fields[0] as String,
      name: fields[1] as String,
      profession: fields[2] as String,
      avatar: fields[3] as Avatar,
    );
  }

  @override
  void write(BinaryWriter writer, Doctor obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.profession)
      ..writeByte(3)
      ..write(obj.avatar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AvatarAdapter extends TypeAdapter<Avatar> {
  @override
  final int typeId = 2;

  @override
  Avatar read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Avatar(
      file: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Avatar obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.file);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AvatarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
