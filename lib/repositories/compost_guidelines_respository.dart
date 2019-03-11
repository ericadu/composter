import 'package:composter/models/compost_guidelines.dart';

class CompostGuidelinesRepository {
  CompostGuidelines getNYCDefaultGuidelines() {
    List<String> accepted = [
      'Fruit and vegetable scraps',
      'Non-greasy food scraps (ie. rice, pasta, bread, cereal, etc.',
      'Coffee grounds and filters',
      'Tea bags',
      'Egg and nut shells',
      'Pits',
      'Cut or dried flowers',
      'Houseplants',
      'Potting soil',
      'Soiled brown paper products'
    ];

    List<String> notAccepted = [
      'Coconuts',
      'Meat, chicken, fish',
      'Greasy food scraps',
      'Fat, oil',
      'Dairy',
      'Animal waste, litter, or bedding',
      'Coal or charcoal',
      'Diseased and/or insect-infested houseplants/soil',
      'Biodegradeable or compostable plastics',
      'Receipts'
    ];
    return CompostGuidelines(accepted, notAccepted);
  }
}