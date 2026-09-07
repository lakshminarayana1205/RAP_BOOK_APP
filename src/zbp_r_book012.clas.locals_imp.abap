CLASS lhc_zr_book013 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Book
        RESULT result,
      validateTitle FOR VALIDATE ON SAVE
        IMPORTING keys FOR Book~validateTitle,
      calculateYearsSincePublished FOR DETERMINE ON SAVE
        IMPORTING keys FOR Book~calculateYearsSincePublished,
      getRecommendations FOR MODIFY
           IMPORTING keys FOR ACTION Book~getRecommendations RESULT result,
      generateBookID FOR DETERMINE ON MODIFY
           IMPORTING keys FOR Book~generateBookID.
ENDCLASS.

CLASS lhc_zr_book013 IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD validateTitle.
    "Implement the validation validateTitle for the Book entity.On save, check whether the Title field is empty.If Title is empty, return an error message to the user:
    "Book title cannot be empty.The validation should be triggered for the Title field."

*    READ ENTITIES OF zr_book013 IN LOCAL MODE
*      ENTITY Book
*        FIELDS ( Title )
*        WITH CORRESPONDING #( keys )
*      RESULT DATA(books).
*
*    LOOP AT books ASSIGNING FIELD-SYMBOL(<book>).
*
*      IF <book>-Title IS INITIAL.
*
*        APPEND VALUE #(
*          %tky = <book>-%tky
*          %msg = new_message_with_text(
*            severity = if_abap_behv_message=>severity-error
*            text     = 'Book title cannot be empty.'
*          )
*          %element-Title = if_abap_behv=>mk-on
*        ) TO reported-book.
*
*        APPEND VALUE #( %tky = <book>-%tky )
*          TO failed-book.
*
*      ENDIF.
*
*    ENDLOOP.

    READ ENTITIES OF zr_book013 IN LOCAL MODE
        ENTITY Book
          FIELDS ( Title )
          WITH CORRESPONDING #( keys )
          RESULT DATA(books).

    LOOP AT books ASSIGNING FIELD-SYMBOL(<book>).

      IF <book>-Title IS INITIAL.

        APPEND VALUE #(
          %tky = <book>-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text = 'Book title cannot be empty.'
          )
          %element-Title = if_abap_behv=>mk-on
        ) TO reported-book.

        APPEND VALUE #( %tky = <book>-%tky )
          TO failed-book.

      ENDIF.

    ENDLOOP.




  ENDMETHOD.

  METHOD calculateYearsSincePublished.

    DATA(current_date) = cl_abap_context_info=>get_system_date( ).

  READ ENTITIES OF ZR_BOOK013 IN LOCAL MODE
    ENTITY Book
      FIELDS ( PublishedDate )
      WITH CORRESPONDING #( keys )
      RESULT DATA(books).

  LOOP AT books ASSIGNING FIELD-SYMBOL(<book>).

    IF <book>-PublishedDate IS INITIAL.
      CONTINUE.
    ENDIF.

    DATA(years) = CONV int4(
      current_date(4) - <book>-PublishedDate(4)
    ).

    IF current_date+4(4) < <book>-PublishedDate+4(4).
      years = years - 1.
    ENDIF.

    IF years < 0.
      years = 0.
    ENDIF.

    MODIFY ENTITIES OF ZR_BOOK013 IN LOCAL MODE
      ENTITY Book
        UPDATE FIELDS ( YearsSincePublished )
        WITH VALUE #(
          ( %tky = <book>-%tky
            YearsSincePublished = years ) ).

  ENDLOOP.


  ENDMETHOD.

  METHOD getRecommendations.

*
*  READ ENTITIES OF ZR_BOOK013 IN LOCAL MODE
*    ENTITY Book
*      FIELDS ( Genre )
*      WITH CORRESPONDING #( keys )
*      RESULT DATA(books).
*
*  LOOP AT books ASSIGNING FIELD-SYMBOL(<book>).
*
*    MODIFY ENTITIES OF ZR_BOOK013 IN LOCAL MODE
*      ENTITY Book
*        UPDATE FIELDS ( BookRecommendations )
*        WITH VALUE #(
*          ( %tky = <book>-%tky
*            BookRecommendations =
*              |Recommendations for genre: { <book>-Genre }| ) ).
*
*  ENDLOOP.
*
*  READ ENTITIES OF ZR_BOOK013 IN LOCAL MODE
*    ENTITY Book
*      ALL FIELDS
*      WITH CORRESPONDING #( keys )
*      RESULT DATA(updated_books).
*
*  result = VALUE #(
*    FOR book IN updated_books
*    ( %tky = book-%tky
*      %param = book ) ).
*
 READ ENTITIES OF ZR_BOOK013 IN LOCAL MODE
    ENTITY Book
      FIELDS ( Genre )
      WITH CORRESPONDING #( keys )
      RESULT DATA(books).

  DATA(ai_helper) = NEW zcl_book_ai_helper( ).

  LOOP AT books ASSIGNING FIELD-SYMBOL(<book>).

    IF <book>-Genre IS INITIAL.
      CONTINUE.
    ENDIF.

    DATA(recommendations) =
      ai_helper->get_book_recommendations(
        iv_genre = CONV string( <book>-Genre )
      ).

    MODIFY ENTITIES OF ZR_BOOK013 IN LOCAL MODE
      ENTITY Book
        UPDATE FIELDS ( BookRecommendations )
        WITH VALUE #(
          ( %tky = <book>-%tky
            BookRecommendations = recommendations ) ).

  ENDLOOP.

  READ ENTITIES OF ZR_BOOK013 IN LOCAL MODE
    ENTITY Book
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(updated_books).

  result = VALUE #(
    FOR book IN updated_books
    ( %tky = book-%tky
      %param = book ) ).



  ENDMETHOD.

  METHOD generateBookID.
  READ ENTITIES OF ZR_BOOK013 IN LOCAL MODE
    ENTITY Book
      FIELDS ( BookID )
      WITH CORRESPONDING #( keys )
      RESULT DATA(books).

  DATA(lv_max_number) = 0.

  "Check active records
  SELECT book_id
    FROM zbook013
    INTO TABLE @DATA(lt_active).

  LOOP AT lt_active INTO DATA(lv_active_id).

    IF lv_active_id CP 'BOOK*'.

      DATA(lv_active_number) = lv_active_id+4(4).

      IF lv_active_number IS NOT INITIAL.
        DATA(lv_active_num) = CONV i( lv_active_number ).

        IF lv_active_num > lv_max_number.
          lv_max_number = lv_active_num.
        ENDIF.
      ENDIF.

    ENDIF.

  ENDLOOP.


  "Check draft records
  SELECT bookid
    FROM zbook012_d
    INTO TABLE @DATA(lt_draft).

  LOOP AT lt_draft INTO DATA(lv_draft_id).

    IF lv_draft_id CP 'BOOK*'.

      DATA(lv_draft_number) = lv_draft_id+4(4).

      IF lv_draft_number IS NOT INITIAL.
        DATA(lv_draft_num) = CONV i( lv_draft_number ).

        IF lv_draft_num > lv_max_number.
          lv_max_number = lv_draft_num.
        ENDIF.
      ENDIF.

    ENDIF.

  ENDLOOP.


  "Generate next ID
  LOOP AT books ASSIGNING FIELD-SYMBOL(<book>).

    IF <book>-BookID IS NOT INITIAL.
      CONTINUE.
    ENDIF.

    lv_max_number = lv_max_number + 1.

    DATA(lv_new_book_id) =
      |BOOK{ lv_max_number WIDTH = 4 ALIGN = RIGHT PAD = '0' }|.

    MODIFY ENTITIES OF ZR_BOOK013 IN LOCAL MODE
      ENTITY Book
        UPDATE FIELDS ( BookID )
        WITH VALUE #(
          ( %tky = <book>-%tky
            BookID = lv_new_book_id )
        ).

  ENDLOOP.
  ENDMETHOD.

ENDCLASS.
