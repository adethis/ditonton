import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/watchlist/watchlist_movies_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:tv_series/presentation/bloc/watchlist/watchlist_tv_series_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_series_card.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistMoviesBloc>().add(FetchWatchlist());
      context.read<WatchlistTvSeriesBloc>().add(FetchWatchlistTvSeries());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMoviesBloc>().add(FetchWatchlist());
    context.read<WatchlistTvSeriesBloc>().add(FetchWatchlistTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist'),
          bottom: const TabBar(
            tabs: [
              Tab(child: Text('Movies')),
              Tab(child: Text('TV Series')),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24.0,
            horizontal: 8.0,
          ),
          child: TabBarView(
            children: [
              BlocBuilder<WatchlistMoviesBloc, WatchlistMoviesState>(
                builder: (context, state) {
                  if (state is WatchlistMoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is WatchlistMoviesHasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final movie = state.movie[index];
                        return MovieCard(movie);
                      },
                      itemCount: state.movie.length,
                    );
                  } else if (state is WatchlistMoviesEmpty) {
                    return const Center(
                      child: Text('Watchlist Movies Empty'),
                    );
                  } else if (state is WatchlistMoviesError) {
                    return Center(
                      key: const Key('error_message'),
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              BlocBuilder<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
                builder: (context, state) {
                  if (state is WatchlistTvSeriesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is WatchlistTvSeriesHasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final tvSeries = state.tvSeries[index];
                        return TvSeriesCard(tvSeries);
                      },
                      itemCount: state.tvSeries.length,
                    );
                  } else if (state is WatchlistTvSeriesEmpty) {
                    return const Center(
                      child: Text('Watchlist TV Series Empty'),
                    );
                  } else if (state is WatchlistTvSeriesError) {
                    return Center(
                      key: const Key('error_message'),
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
