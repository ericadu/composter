import 'package:composter/blocs/bloc_provider.dart';
import 'package:composter/models/dropoff_location.dart';
import 'package:composter/models/dropoff_location_response.dart';
import 'package:composter/repositories/dropoff_location_respository.dart';
import 'package:rxdart/rxdart.dart';

class DropoffLocationsBloc implements BlocBase {
  final BehaviorSubject<List<DropoffLocation>> _locationsController = BehaviorSubject<List<DropoffLocation>>();
  final DropoffLocationRepository _repository = DropoffLocationRepository();

  void getLocations() async {
    DropoffLocationResponse response = await _repository.getDropoffLocations();
    _locationsController.sink.add(response.results);
  }

  void dispose(){
    _locationsController.close();
  }

  BehaviorSubject<List<DropoffLocation>> get locationsController => _locationsController;
}

final bloc = DropoffLocationsBloc();