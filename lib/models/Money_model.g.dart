// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Money_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoneymodelAdapter extends TypeAdapter<Money_model> {
  @override
  final int typeId = 0;

  @override
  Money_model read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Money_model(
      id: fields[0] as int,
      title: fields[1] as String,
      discription: fields[2] as String,
      price: fields[3] as String,
      date: fields[4] as String,
      isReceived: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Money_model obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.discription)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.isReceived);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoneymodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
