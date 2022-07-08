// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_prescription_detail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivePrescriptionDetailModelAdapter
    extends TypeAdapter<ActivePrescriptionDetailModel> {
  @override
  final int typeId = 0;

  @override
  ActivePrescriptionDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActivePrescriptionDetailModel(
      id: fields[0] as String,
      medicine: fields[1] as String,
      dosage: fields[2] as int,
      fraction: fields[3] as String,
      days: fields[4] as int,
      elapsed: fields[5] as int,
      remaining: fields[6] as int,
      progress: fields[7] as double,
      description: fields[8] as String,
      doctor: fields[9] as Doctor,
      start: fields[10] as DateTime,
      period: fields[11] as int,
      count: fields[12] as int,
      takenno: fields[13] as int,
      nottakenno: fields[14] as int,
      notify: fields[15] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ActivePrescriptionDetailModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.medicine)
      ..writeByte(2)
      ..write(obj.dosage)
      ..writeByte(3)
      ..write(obj.fraction)
      ..writeByte(4)
      ..write(obj.days)
      ..writeByte(5)
      ..write(obj.elapsed)
      ..writeByte(6)
      ..write(obj.remaining)
      ..writeByte(7)
      ..write(obj.progress)
      ..writeByte(8)
      ..write(obj.description)
      ..writeByte(9)
      ..write(obj.doctor)
      ..writeByte(10)
      ..write(obj.start)
      ..writeByte(11)
      ..write(obj.period)
      ..writeByte(12)
      ..write(obj.count)
      ..writeByte(13)
      ..write(obj.takenno)
      ..writeByte(14)
      ..write(obj.nottakenno)
      ..writeByte(15)
      ..write(obj.notify);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivePrescriptionDetailModelAdapter &&
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
      id: fields[0] as int,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      profilePic: fields[3] as String?,
      degree: fields[4] as String,
      field: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Doctor obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.profilePic)
      ..writeByte(4)
      ..write(obj.degree)
      ..writeByte(5)
      ..write(obj.field);
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
