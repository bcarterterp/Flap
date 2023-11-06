// ignore_for_file: must_be_immutable
import 'package:flap_app/domain/entity/recipe.dart';
import 'package:json_annotation/json_annotation.dart';
part 'recipe_dto.g.dart';
@JsonSerializable()
class RecipeDto extends Recipe {
  int _id;
  String? _title;
  String? _image;
  RecipeDto(this._id, this._title, this._image) : super(id: _id);
  @override
  int get id => _id;
  @override
  String? get title => _title;
  @override
  String? get image => _image;
  factory RecipeDto.fromJson(Map<String, dynamic> json) =>
      _$RecipeDtoFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeDtoToJson(this);
}