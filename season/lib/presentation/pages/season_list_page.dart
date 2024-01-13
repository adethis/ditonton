import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:season/presentation/bloc/list/season_bloc.dart';
import 'package:season/presentation/widgets/season_card.dart';
import 'package:tv_series/presentation/bloc/detail/tv_series_detail_bloc.dart';

class SeasonListPage extends StatefulWidget {
  static const ROUTE_NAME = '/season-list';
  final int seriesId;

  const SeasonListPage({super.key, required this.seriesId});

  @override
  State<SeasonListPage> createState() => _SeasonListPageState();
}

class _SeasonListPageState extends State<SeasonListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SeasonBloc>().add(SeasonEvent(widget.seriesId));
      context
          .read<TvSeriesDetailBloc>()
          .add(TvSeriesDetailEvent(widget.seriesId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<TvSeriesDetailBloc, TvSeriesDetailState>(
          builder: (context, state) {
            if (state is TvSeriesDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvSeriesDetailHasData) {
              return Text(
                state.result.name,
                maxLines: 1,
              );
            } else {
              return const Text(
                'List Season',
                key: Key('default_title'),
              );
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SeasonBloc, SeasonState>(
          builder: (context, state) {
            if (state is SeasonLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SeasonHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final season = state.result[index];
                  return SeasonCard(
                    season: season,
                    seriesId: widget.seriesId,
                  );
                },
                itemCount: state.result.length,
              );
            } else if (state is SeasonError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container(
                key: const Key('unknown_state'),
              );
            }
          },
        ),
      ),
    );
  }
}
