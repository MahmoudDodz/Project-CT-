import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/incident_model.dart';
import '../../../data/models/unit_model.dart';
import 'officer_event.dart';
import 'officer_state.dart';

class OfficerBloc extends Bloc<OfficerEvent, OfficerState> {
  OfficerBloc() : super(const OfficerState()) {
    on<LoadOfficerDataEvent>(_onLoad);
    on<NavigateToTabEvent>(_onNavigate);
    on<RespondToIncidentEvent>(_onRespond);
    on<ShowAlertEvent>(_onShowAlert);
  }

  void _onLoad(LoadOfficerDataEvent event, Emitter<OfficerState> emit) {
    emit(state.copyWith(
      incidents: IncidentModel.mockList,
      notifications: const [],
      units: UnitModel.mockList,
      alertMessage: 'HIGH PRIORITY: RIOT',
      alertIncidentId: '72U34K',
    ));
  }

  void _onNavigate(NavigateToTabEvent event, Emitter<OfficerState> emit) {
    emit(state.copyWith(currentTab: event.index));
  }

  void _onRespond(RespondToIncidentEvent event, Emitter<OfficerState> emit) {
    emit(state.copyWith(isResponding: true, clearAlert: true));
  }

  void _onShowAlert(ShowAlertEvent event, Emitter<OfficerState> emit) {
    emit(state.copyWith(
      alertMessage: event.message,
      alertIncidentId: event.incidentId,
    ));
  }
}
