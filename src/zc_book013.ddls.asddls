@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: 'Manage Books'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZGE362159_BOOK', 
  semanticKey: [ 'BookID' ]
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_BOOK013
  provider contract transactional_query
  as projection on ZR_BOOK013
  association [1..1] to ZR_BOOK013 as _BaseEntity on $projection.UUID = _BaseEntity.UUID
{
  key UUID,
  BookID,
  Title,
  Author,
  Description,
  @Consumption.valueHelpDefinition: [ {
    entity: {
        name: 'ZC_GENRE_VH',
        element: 'Genre'
    }
} ]
  Genre,
  @Consumption: {
    valueHelpDefinition: [ {
      entity.element: 'Currency', 
      entity.name: 'I_CurrencyStdVH', 
      useForValidation: true
    } ]
  }
  Currency,
  @Semantics: {
    amount.currencyCode: 'Currency'
  }
  Price,
  DiscountedPrice,

  PublishedDate,
  @Semantics: {
    quantity.unitOfMeasure: 'QuantityUnit'
  }
  StockQuantity,
  @Consumption: {
    valueHelpDefinition: [ {
      entity.element: 'UnitOfMeasure', 
      entity.name: 'I_UnitOfMeasureStdVH', 
      useForValidation: true
    } ]
  }
  QuantityUnit,
  Rating,
  RatingCategory,
  Status,
  BookRecommendations,
  @Semantics: {
    user.createdBy: true
  }
  LocalCreatedBy,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  LocalCreatedAt,
  @Semantics: {
    user.localInstanceLastChangedBy: true
  }
  LocalLastChangedBy,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  LocalLastChangedAt,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  LastChangedAt,
  _Author : redirected to composition child ZC_AUTHOR,
  _Inventory : redirected to composition child ZC_INVENTORY,
  _BaseEntity
}
