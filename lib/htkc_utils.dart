library hc_utils;

export 'package:flutter/material.dart'
    show
    TextTheme,
    ThemeMode,
    RouteFactory,
    GenerateAppTitle,
    InitialRouteListFactory;
export 'package:flutter/widgets.dart';

export 'package:htkc_utils/hc_utils/border/hc_dotted_border.dart';

export 'package:htkc_utils/hc_utils/chart/hc_circular_chart.dart';
export 'package:htkc_utils/hc_utils/chart/hc_animated_circular_chart.dart';
export 'package:htkc_utils/hc_utils/chart/hc_entry.dart';

export 'package:htkc_utils/hc_utils/dropdown/hc_auto_complete_search.dart';

export 'package:htkc_utils/hc_utils/multiselect/hc_multiselect_dropdown.dart';

export 'package:htkc_utils/emergent_utils/emergent_colors.dart';
export 'package:htkc_utils/emergent_utils/emergent_box_shape.dart';
export 'package:htkc_utils/emergent_utils/emergent_shape.dart';
export 'package:htkc_utils/emergent_utils/emergent_light_source.dart';
export 'package:htkc_utils/emergent_utils/shape/emergent_path_provider.dart';
export 'package:htkc_utils/emergent_utils/theme/emergent_app_bar.dart';
export 'package:htkc_utils/emergent_utils/theme/emergent_theme.dart';
export 'package:htkc_utils/emergent_utils/theme/emergent_decoration_theme.dart';
export 'package:htkc_utils/emergent_utils/widget/emergent_app.dart';
export 'package:htkc_utils/emergent_utils/widget/emergent_app_bar.dart';
export 'package:htkc_utils/emergent_utils/widget/emergent_back_button.dart';
export 'package:htkc_utils/emergent_utils/widget/emergent_background.dart';
export 'package:htkc_utils/emergent_utils/widget/emergent_button.dart';
export 'package:htkc_utils/emergent_utils/widget/emergent_checkbox.dart';
export 'package:htkc_utils/emergent_utils/widget/emergent_close_button.dart';
export 'package:htkc_utils/emergent_utils/widget/emergent_container.dart';
export 'package:htkc_utils/emergent_utils/widget/emergent_icon.dart';
export 'package:htkc_utils/emergent_utils/widget/emergent_indicator.dart';
export 'package:htkc_utils/emergent_utils/widget/emergent_progress.dart';
export 'package:htkc_utils/emergent_utils/widget/emergent_radio.dart';
export 'package:htkc_utils/emergent_utils/widget/emergent_range_slider.dart';
export 'package:htkc_utils/emergent_utils/widget/emergent_slider.dart';
export 'package:htkc_utils/emergent_utils/widget/emergent_switch.dart';
export 'package:htkc_utils/emergent_utils/widget/emergent_text.dart';
export 'package:htkc_utils/emergent_utils/widget/emergent_toggle.dart';
export 'package:htkc_utils/emergent_utils/widget/emergent_floating_action_button.dart';

export 'package:htkc_utils/hc_utils/hc_app_text_style.dart';
export 'package:htkc_utils/hc_utils/hc_image_res.dart';
export 'package:htkc_utils/hc_utils/hc_custom_functions.dart';
export 'package:htkc_utils/hc_utils/hc_alert_dialog.dart';
export 'package:htkc_utils/hc_utils/hc_app_bar.dart';
export 'package:htkc_utils/hc_utils/hc_app_button.dart';
export 'package:htkc_utils/hc_utils/hc_app_loader.dart';
export 'package:htkc_utils/hc_utils/hc_dotted_rect.dart';
export 'package:htkc_utils/hc_utils/hc_image_slider.dart';
export 'package:htkc_utils/hc_utils/hc_context_extensions.dart';

export 'package:htkc_utils/hc_utils/alert/hc_dialog_button.dart';
export 'package:htkc_utils/hc_utils/alert/hc_alert_style.dart';
export 'package:htkc_utils/hc_utils/alert/hc_alert.dart';

export 'package:htkc_utils/hc_utils/drag/hc_drag_drop.dart';
export 'package:htkc_utils/hc_utils/drag/hc_drag_drop_view.dart';
export 'package:htkc_utils/hc_utils/drag/hc_grid_orbit.dart';

export 'package:htkc_utils/hc_utils/age/hc_age.dart';

export 'package:htkc_utils/hc_utils/otp/hc_otp_field.dart';
export 'package:htkc_utils/hc_utils/otp/hc_otp_field_style.dart';

export 'package:htkc_utils/hc_utils/share/hc_share.dart';

export 'package:flutter/material.dart';

import 'package:htkc_utils/image_compression_utils/basic_utils/hc_compressor_stub.dart'
if (dart.library.io) 'image_compression_utils/basic_utils/hc_compressor_io.dart'
if (dart.library.html) 'image_compression_utils/basic_utils/hc_compressor_html.dart';
import 'package:htkc_utils/image_compression_utils/basic_utils/hc_interface.dart';

export 'package:cross_file/cross_file.dart' show XFile;
export 'package:image_compression/image_compression.dart' show ImageFile;

export 'package:htkc_utils/image_compression_utils/basic_utils/hc_configurations.dart';
export 'package:htkc_utils/image_compression_utils/basic_utils/hc_extension.dart'
    show HcXFileExtension;


/// Global singleton instance for image compressor
final HcImageCompressionInterface compressor = getCompressor();