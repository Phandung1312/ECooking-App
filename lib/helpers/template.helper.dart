

import 'package:uq_system_app/assets.gen.dart';
import 'package:uq_system_app/domain/entities/template/ingredient.template.dart';

class TemplateHelper{
  static List<IngredientTemplate> getIngredientTemplates(){
    return [
      IngredientTemplate(
        name: 'Cá hồi',
        imagePath: Assets.images.imgCaHoi.path
      ),
      IngredientTemplate(
          name: 'Đậu hũ',
          imagePath: Assets.images.imgDauhu.path
      ),
      IngredientTemplate(
        name: 'Chả cá',
        imagePath: Assets.images.imgChaCa.path
      ),
      IngredientTemplate(
        name: 'Sườn',
        imagePath: Assets.images.imgSuon.path
      ),
      IngredientTemplate(
        name: 'Cần tây',
        imagePath: Assets.images.imgCanTay.path
      ),
      IngredientTemplate(
        name: 'Trứng',
        imagePath: Assets.images.imgTrung.path
      ),
      IngredientTemplate(
        name: 'Mực',
        imagePath: Assets.images.imgMuc.path
      ),
      IngredientTemplate(
        name: 'Lươn',
        imagePath: Assets.images.imgLuon.path
      ),
      IngredientTemplate(
        name: 'Bạch tuộc',
        imagePath: Assets.images.imgBachTuoc.path
      ),
      IngredientTemplate(
        name: 'Nấm',
        imagePath: Assets.images.imgNam.path
      ),
      IngredientTemplate(
        name: 'Cần tây',
        imagePath: Assets.images.imgCanTay.path
      ),
      IngredientTemplate(
        name: 'Cải',
        imagePath: Assets.images.imgCai.path
      ),
    ];
  }
}