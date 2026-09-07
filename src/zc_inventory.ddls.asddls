@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Semantickey: [ 'InventoryID' ]
}
@AccessControl.authorizationCheck: #MANDATORY
define view entity ZC_INVENTORY
  as projection on ZR_INVENTORY
  association [1..1] to ZR_INVENTORY as _BaseEntity on $projection.UUID = _BaseEntity.UUID
{
  key UUID,
  ParentUUID,
  InventoryID,
  Warehouse,
  @Semantics: {
    Quantity.Unitofmeasure: 'QuantityUnit'
  }
  OnHand,
  @Consumption: {
    Valuehelpdefinition: [ {
      Entity.Element: 'UnitOfMeasure', 
      Entity.Name: 'I_UnitOfMeasureStdVH', 
      Useforvalidation: true
    } ]
  }
  QuantityUnit,
  _Book : redirected to parent ZC_BOOK013,
  _BaseEntity
}
