import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/blocs/homepage_bloc/homepage_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ticket/presentation/blocs/historic_ticket_bloc/historic_ticket_bloc.dart';
import 'package:ticket/presentation/pages/historic_ticket_page.dart';
import 'package:ticket/presentation/widgets/ticket_card.dart';

import '../../dummy_data/dummy_objects.dart';

class MockHistoricTicketBloc
    extends MockBloc<HistoricTicketEvent, HistoricTicketState>
    implements HistoricTicketBloc {}

class MockHomepageBloc extends MockBloc<HomepageEvent, HomepageState>
    implements HomepageBloc {}

void main() {
  late MockHistoricTicketBloc mockBloc;
  late MockHomepageBloc mockHomepageBloc;
  setUp(() {
    mockBloc = MockHistoricTicketBloc();
    mockHomepageBloc = MockHomepageBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HistoricTicketBloc>(create: (_) => mockBloc),
        BlocProvider<HomepageBloc>(create: (_) => mockHomepageBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockHomepageBloc.state)
        .thenReturn(const HomepageState(index: 1));
    when(() => mockBloc.state).thenReturn(HistoricTicketLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const HistoricTicketPage()));

    expect(centerFinder, findsAtLeastNWidgets(1));
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display listview and ticketCard when loaded and has data in it',
      (WidgetTester tester) async {
    when(() => mockHomepageBloc.state)
        .thenReturn(const HomepageState(index: 1));
    when(() => mockBloc.state)
        .thenReturn(HistoricTicketLoaded(result: [tTicket, tTicket, tTicket]));

    final listViewFinder = find.byType(ListView);
    final tickteCardFinder = find.byType(TicketCard);

    await tester.pumpWidget(makeTestableWidget(const HistoricTicketPage()));

    expect(tickteCardFinder, findsExactly(3));
    expect(listViewFinder, findsOneWidget);
  });
}
