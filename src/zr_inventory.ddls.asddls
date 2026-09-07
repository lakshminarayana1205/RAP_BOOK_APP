@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@EndUserText.label: 'Inventory View'
@ObjectModel.semanticKey: [ 'InventoryID' ]
define view entity ZR_INVENTORY
  as select from zinventory as Inventory
  association to parent ZR_BOOK013 as _Book on $projection.ParentUUID = _Book.UUID
{
  key uuid as UUID,
  parent_uuid as ParentUUID,
  inventory_id as InventoryID,
  warehouse as Warehouse,
  @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
  on_hand as OnHand,
  @Consumption.valueHelpDefinition: [ {
    entity.name: 'I_UnitOfMeasureStdVH', 
    entity.element: 'UnitOfMeasure', 
    useForValidation: true
  } ]
  quantity_unit as QuantityUnit,
  _Book
}
