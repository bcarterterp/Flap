import 'package:flap_app/domain/entity/recipe.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe_dto.g.dart';

@JsonSerializable()
class RecipeDto extends Recipe {
  RecipeDto(this.id, this.title, this.image) : super(id: id);

  final int id;
  final String? title;
  final String? image;

  factory RecipeDto.fromJson(Map<String, dynamic> json) =>
      _$RecipeDtoFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeDtoToJson(this);
}
