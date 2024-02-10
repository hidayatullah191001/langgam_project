import 'dart:html' as html;
// import 'dart:io';
import 'dart:typed_data';

import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:email_validator/email_validator.dart';
import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:langgam_project/configs/configs.dart';
import 'package:langgam_project/controllers/controller.dart';
import 'package:langgam_project/models/bidang_layanan_model.dart'
    as bidang_layanan_model;
import 'package:langgam_project/models/forms/sign_in_form_model.dart';
import 'package:langgam_project/models/forms/sign_up_form_model.dart';
import 'package:langgam_project/models/layanan_model.dart';
import 'package:langgam_project/models/list_permintaan_model.dart';
import 'package:langgam_project/models/list_permintaan_model_admin.dart'
    as listPermintaanModelAdmin;
import 'package:langgam_project/routes/route.dart';
import 'package:langgam_project/services/services.dart';
import 'package:langgam_project/widgets/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:sidebar_with_animation/animated_side_bar.dart';
import 'package:url_launcher/url_launcher.dart';

part 'index_page.dart';
part 'register_page.dart';
part 'product_layanan_page.dart';
part 'detail_product_layanan_page.dart';
part 'cart_page.dart';
part 'checkout_page.dart';
part 'checkout_finish_page.dart';
part 'berita_page.dart';
part 'detail_berita_page.dart';

part 'users/my_account_page.dart';
part 'users/dashboard_section.dart';
part 'users/pesanan_section.dart';
part 'users/message_section.dart';
part 'users/download_section.dart';
part 'users/address_section.dart';
part 'users/account_settings_section.dart';
part 'users/attachment_section.dart';

part 'admin/login_admin_page.dart';
part 'admin/app_admin_page.dart';
part 'admin/dashboard_admin_section.dart';
part 'admin/pelayanan_masuk_section.dart';
part 'admin/tahapan_pelayanan_section.dart';
part 'admin/detail_permintaan_section.dart';
