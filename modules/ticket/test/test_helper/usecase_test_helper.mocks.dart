// Mocks generated by Mockito 5.4.4 from annotations
// in ticket/test/test_helper/usecase_test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:core/utils/failure.dart' as _i6;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:ticket/domain/entities/ticket.dart' as _i7;
import 'package:ticket/domain/repositories/ticket_repository.dart' as _i2;
import 'package:ticket/domain/usecases/get_active_ticket.dart' as _i4;
import 'package:ticket/domain/usecases/get_historic_ticket.dart' as _i8;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeTicketRepository_0 extends _i1.SmartFake
    implements _i2.TicketRepository {
  _FakeTicketRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetActiveTicket].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetActiveTicket extends _i1.Mock implements _i4.GetActiveTicket {
  MockGetActiveTicket() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TicketRepository get ticketRepository => (super.noSuchMethod(
        Invocation.getter(#ticketRepository),
        returnValue: _FakeTicketRepository_0(
          this,
          Invocation.getter(#ticketRepository),
        ),
      ) as _i2.TicketRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Ticket>>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, List<_i7.Ticket>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.Ticket>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.Ticket>>>);
}

/// A class which mocks [GetHistoricTicket].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetHistoricTicket extends _i1.Mock implements _i8.GetHistoricTicket {
  MockGetHistoricTicket() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TicketRepository get ticketRepository => (super.noSuchMethod(
        Invocation.getter(#ticketRepository),
        returnValue: _FakeTicketRepository_0(
          this,
          Invocation.getter(#ticketRepository),
        ),
      ) as _i2.TicketRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Ticket>>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, List<_i7.Ticket>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.Ticket>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.Ticket>>>);
}
