import 'package:rxdart/rxdart.dart';
import 'package:composter/models/dropoff_location.dart';
import 'package:composter/models/dropoff_location_response.dart';
import 'package:composter/repositories/dropoff_location_respository.dart';

class DropoffLocationsBloc {
  final BehaviorSubject<List<DropoffLocation>> _locationsController = 
    BehaviorSubject<List<DropoffLocation>>.seeded(<DropoffLocation>[]);
  
  final PublishSubject<DropoffLocation> _focusController = PublishSubject<DropoffLocation>();

  final DropoffLocationRepository _repository = DropoffLocationRepository();

  void getLocations() async {
    DropoffLocationResponse response = await _repository.getDropoffLocations();
    _locationsController.sink.add(response.results);
  }

  void update(DropoffLocation loc) {
    _focusController.sink.add(loc);
  }

  void dispose(){
    _locationsController.close();
    _focusController.close();
  }

  BehaviorSubject<List<DropoffLocation>> get locationsController => _locationsController;
  PublishSubject<DropoffLocation> get focusController => _focusController;
}

final bloc = DropoffLocationsBloc();