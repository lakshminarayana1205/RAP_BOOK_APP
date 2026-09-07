@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZGE362159_BOOK'
@EndUserText.label: 'Books Details '
@ObjectModel.semanticKey: [ 'BookID' ]
define root view entity ZR_BOOK013
  as select from zbook013 as Book
  composition [1..*] of ZR_AUTHOR    as _Author
  composition [0..*] of ZR_INVENTORY as _Inventory
{
  key uuid                                                                 as UUID,
      book_id                                                              as BookID,
      title                                                                as Title,
      author                                                               as Author,
      description                                                          as Description,
      @Consumption.valueHelpDefinition: [ {
      entity: {
      name: 'ZC_GENRE_VH',
      element: 'Genre'
      }
      } ]
      genre                                                                as Genre,
      //genre                                                                as Genre,
      @Consumption.valueHelpDefinition: [ {
        entity.name: 'I_CurrencyStdVH',
        entity.element: 'Currency',
        useForValidation: true
      } ]
      currency                                                             as Currency,
      @Semantics.amount.currencyCode: 'Currency'
      price                                                                as Price,
      //added discounted price
      @Semantics.amount.currencyCode: 'Currency'
      cast( cast( price as abap.dec(15,2) ) * 98 / 100 as abap.dec(15,2) ) as DiscountedPrice,
      //added
      years_since_published                                                as YearsSincePublished,
      published_date                                                       as PublishedDate,
      @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
      stock_quantity                                                       as StockQuantity,
      @Consumption.valueHelpDefinition: [ {
        entity.name: 'I_UnitOfMeasureStdVH',
        entity.element: 'UnitOfMeasure',
        useForValidation: true
      } ]
      quantity_unit                                                        as QuantityUnit,
      rating                                                               as Rating,
      //added rating status
      cast(
        case
          when rating >= 4.5 then 'Excellent'
          when rating >= 3.5 then 'Good'
          when rating >= 2.5 then 'Average'
          else 'Poor'
        end
        as abap.char(10)
      )                                                                    as RatingCategory,

      status                                                               as Status,
      book_recommendations                                                 as BookRecommendations,
      @Semantics.user.createdBy: true
      local_created_by                                                     as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at                                                     as LocalCreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by                                                as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at                                                as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at                                                      as LastChangedAt,
      _Author,
      _Inventory
}
