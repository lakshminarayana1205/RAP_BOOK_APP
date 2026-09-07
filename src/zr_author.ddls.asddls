@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@ObjectModel.semanticKey: [ 'AuthorID' ]
define view entity ZR_AUTHOR
  as select from ZAUTHOR as Author
  association to parent ZR_BOOK013 as _Book on $projection.ParentUuid = _Book.Uuid
{
  key uuid as UUID,
  parent_uuid as ParentUUID,
  author_id as AuthorID,
  name as Name,
  bio as Bio,
  _Book
}
