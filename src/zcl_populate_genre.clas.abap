CLASS zcl_populate_genre DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_populate_genre IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

   DATA genres TYPE TABLE OF zgenre.

  genres = VALUE #(
    ( genre = 'Fiction' )
    ( genre = 'Science Fiction' )
    ( genre = 'Fantasy' )
    ( genre = 'Mystery' )
    ( genre = 'Thriller' )
    ( genre = 'Romance' )
    ( genre = 'Biography' )
    ( genre = 'History' )
    ( genre = 'Technology' )
    ( genre = 'Business' )
    ( genre = 'Education' )
  ).

  DELETE FROM zgenre.

  INSERT zgenre FROM TABLE @genres.

  COMMIT WORK.

  out->write( 'Genres inserted successfully.' ).
  ENDMETHOD.
ENDCLASS.
