part of 'update_ticket_bloc.dart';

sealed class UpdateTicketState extends Equatable {
  const UpdateTicketState();

  @override
  List<Object> get props => [];
}

final class UpdateTicketInitial extends UpdateTicketState {}

final class UpdateTicketInProgressSuccess extends UpdateTicketState {}

final class UpdateTicketSelesaiSuccess extends UpdateTicketState {}

final class UpdateTicketLoading extends UpdateTicketState {}

final class UpdateTicketError extends UpdateTicketState {}
