@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Semantickey: [ 'AuthorID' ]
}
@AccessControl.authorizationCheck: #MANDATORY
define view entity ZC_AUTHOR
  as projection on ZR_AUTHOR
  association [1..1] to ZR_AUTHOR as _BaseEntity on $projection.UUID = _BaseEntity.UUID
{
  key UUID,
  ParentUUID,
  AuthorID,
  Name,
  Bio,
  _Book : redirected to parent ZC_BOOK013,
  _BaseEntity
}
