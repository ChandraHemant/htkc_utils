import 'package:htkc_utils/emergent_utils/shape/emergent_rrect_path_provider.dart';
import 'package:htkc_utils/htkc_utils.dart';

class StadiumPathProvider extends RRectPathProvider {
  const StadiumPathProvider({Listenable? reclip})
      : super(
            const BorderRadius.all(
              Radius.circular(1000),
            ),
            reclip: reclip);
}
