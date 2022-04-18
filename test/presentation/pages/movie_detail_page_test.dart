import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailNotifier])
void main() {
  late MockMovieDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockMovieDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MovieDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(('should show a progress indicator if the state is loading'),
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loading);
    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(('should show a progress indicator if the state is loading'),
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loading);
    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      ('should show an error message if movie request state neither loading or loaded'),
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Empty);
    when(mockNotifier.message).thenReturn('neither loading or loaded');
    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
    expect(find.text('neither loading or loaded'), findsWidgets);
  });

  testWidgets(
      'should show a circular progress indicator if recommendation state is loading',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loading);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);
    when(mockNotifier.movie).thenReturn(testMovieDetail);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(
        find.byType(
          CircularProgressIndicator,
        ),
        findsWidgets);
  });

  testWidgets('should show an errorm essage if recommendation state is error',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Error);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.message).thenReturn('expected');

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.text('expected'), findsWidgets);
  });

  testWidgets('should show an list view if recommendation state is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[testMovie]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.message).thenReturn('expected');

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byType(ListView), findsWidgets);
  });

  testWidgets('should show an container if recommendation state is empty',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Empty);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[testMovie]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.message).thenReturn('expected');

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byType(Container), findsWidgets);
  });

  testWidgets('should only minute text if movie is less than one hour',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Empty);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[testMovie]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);
    when(mockNotifier.movie).thenReturn(MovieDetail(
      adult: false,
      backdropPath: 'backdropPath',
      genres: [Genre(id: 1, name: 'Action')],
      id: 1,
      originalTitle: 'originalTitle',
      overview: 'overview',
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      runtime: 42,
      title: 'title',
      voteAverage: 1,
      voteCount: 1,
    ));

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.text('42m'), findsWidgets);
  });
}
