part of 'write_bloc.dart';

sealed class WriteEvent extends Equatable {
  const WriteEvent();

  @override
  List<Object> get props => [];
}

class WriteStarted extends WriteEvent {}

class WriteSendPostEvent extends WriteEvent {
  final String user;
  final String text;
  final  image;

 const WriteSendPostEvent({required this.user ,required this.text ,required this.image});
 
}