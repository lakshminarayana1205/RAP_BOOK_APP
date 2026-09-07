CLASS zcl_book_ai_helper DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS get_book_recommendations
      IMPORTING
        iv_genre                  TYPE string
      RETURNING
        VALUE(rv_recommendations) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_book_ai_helper IMPLEMENTATION.
  METHOD get_book_recommendations.

*    DATA(system_prompt) =
*     |You are a helpful book recommendation assistant. | &&
*     |Recommend 5 books related to the given genre. | &&
*     |For each book provide the title and a short reason. | &&
*     |Keep the response concise and below 100 characters.|.
*
*    DATA(user_prompt) =
*      |The selected book genre is: { iv_genre }. | &&
*      |Recommend 5 relevant books for this genre.|.
*
*    TRY.
*
*        FINAL(api) =
*          cl_aic_islm_compl_api_factory=>get( )->create_instance(
*            islm_scenario = 'ZINTS_RAP120'
*          ).
*
*      CATCH cx_aic_api_factory INTO DATA(lx_api).
*
*        rv_recommendations = lx_api->get_text( ).
*        RETURN.
*
*    ENDTRY.
*
*    TRY.
*
*        FINAL(message_container) = api->create_message_container( ).
*
*        message_container->set_system_role( system_prompt ).
*
*        message_container->add_user_message( user_prompt ).
*
*        rv_recommendations =
*          api->execute_for_messages( message_container )->get_completion( ).
*
*      CATCH cx_aic_completion_api INTO DATA(lx_completion).
*
*        rv_recommendations = ''.
*
*    ENDTRY.
*    CASE iv_genre.
*
*      WHEN 'Technology'.
*
*        rv_recommendations =
*          |1. Clean ABAP - Modern ABAP development practices.| &&
*          cl_abap_char_utilities=>newline &&
*          |2. ABAP to the Future - Advanced ABAP programming concepts.| &&
*          cl_abap_char_utilities=>newline &&
*          |3. SAP Fiori Elements - Building modern SAP applications.| &&
*          cl_abap_char_utilities=>newline &&
*          |4. SAP BTP Development - Cloud application development.| &&
*          cl_abap_char_utilities=>newline &&
*          |5. Developing with RAP - Modern SAP application development.|.
*
*      WHEN 'Fiction'.
*
*        rv_recommendations =
*          |1. The Great Gatsby - A classic story of ambition and society.| &&
*          cl_abap_char_utilities=>newline &&
*          |2. 1984 - A dystopian story about power and control.| &&
*          cl_abap_char_utilities=>newline &&
*          |3. To Kill a Mockingbird - A powerful story about justice.| &&
*          cl_abap_char_utilities=>newline &&
*          |4. The Alchemist - A journey of dreams and discovery.| &&
*          cl_abap_char_utilities=>newline &&
*          |5. The Kite Runner - A story of friendship and redemption.|.
*
*      WHEN 'Fantasy'.
*
*        rv_recommendations =
*          |1. The Hobbit - An adventure through Middle-earth.| &&
*          cl_abap_char_utilities=>newline &&
*          |2. Harry Potter - A magical journey of friendship and courage.| &&
*          cl_abap_char_utilities=>newline &&
*          |3. The Name of the Wind - An epic fantasy adventure.| &&
*          cl_abap_char_utilities=>newline &&
*          |4. Mistborn - A unique world of magic and rebellion.| &&
*          cl_abap_char_utilities=>newline &&
*          |5. The Way of Kings - An epic story of heroes and kingdoms.|.
*
*      WHEN 'Business'.
*
*        rv_recommendations =
*          |1. The Lean Startup - Building businesses through experimentation.| &&
*          cl_abap_char_utilities=>newline &&
*          |2. Good to Great - Understanding how companies become exceptional.| &&
*          cl_abap_char_utilities=>newline &&
*          |3. Zero to One - Building innovative businesses.| &&
*          cl_abap_char_utilities=>newline &&
*          |4. The Innovator's Dilemma - Understanding disruptive innovation.| &&
*          cl_abap_char_utilities=>newline &&
*          |5. Atomic Habits - Building effective personal and professional systems.|.
*
*      WHEN 'Science Fiction'.
*
*        rv_recommendations =
*          |1. Dune - An epic story of politics and survival.| &&
*          cl_abap_char_utilities=>newline &&
*          |2. Foundation - A classic vision of the future.| &&
*          cl_abap_char_utilities=>newline &&
*          |3. Neuromancer - A pioneering cyberpunk novel.| &&
*          cl_abap_char_utilities=>newline &&
*          |4. The Martian - Science and survival on Mars.| &&
*          cl_abap_char_utilities=>newline &&
*          |5. Project Hail Mary - A science-driven space adventure.|.
*
*      WHEN 'Mystery'.
*
*        rv_recommendations =
*          |1. The Silent Patient - A psychological mystery.| &&
*          cl_abap_char_utilities=>newline &&
*          |2. Gone Girl - A suspenseful mystery about a missing woman.| &&
*          cl_abap_char_utilities=>newline &&
*          |3. The Girl with the Dragon Tattoo - A complex investigative mystery.| &&
*          cl_abap_char_utilities=>newline &&
*          |4. And Then There Were None - A classic mystery thriller.| &&
*          cl_abap_char_utilities=>newline &&
*          |5. The Hound of the Baskervilles - A Sherlock Holmes classic.|.
*
*      WHEN 'Thriller'.
*
*        rv_recommendations =
*          |1. The Da Vinci Code - A fast-paced historical thriller.| &&
*          cl_abap_char_utilities=>newline &&
*          |2. The Bourne Identity - An action-packed spy thriller.| &&
*          cl_abap_char_utilities=>newline &&
*          |3. The Woman in the Window - A psychological thriller.| &&
*          cl_abap_char_utilities=>newline &&
*          |4. The Reversal - A compelling legal thriller.| &&
*          cl_abap_char_utilities=>newline &&
*          |5. Before I Go to Sleep - A psychological suspense story.|.
*
*      WHEN 'Romance'.
*
*        rv_recommendations =
*          |1. Pride and Prejudice - A classic story of love and society.| &&
*          cl_abap_char_utilities=>newline &&
*          |2. Me Before You - An emotional modern romance.| &&
*          cl_abap_char_utilities=>newline &&
*          |3. The Notebook - A story of lasting love.| &&
*          cl_abap_char_utilities=>newline &&
*          |4. The Fault in Our Stars - A touching young adult romance.| &&
*          cl_abap_char_utilities=>newline &&
*          |5. Outlander - Romance combined with historical adventure.|.
*
*      WHEN 'Biography'.
*
*        rv_recommendations =
*          |1. Steve Jobs - The life of the Apple co-founder.| &&
*          cl_abap_char_utilities=>newline &&
*          |2. Long Walk to Freedom - Nelson Mandela's autobiography.| &&
*          cl_abap_char_utilities=>newline &&
*          |3. Becoming - Michelle Obama's life story.| &&
*          cl_abap_char_utilities=>newline &&
*          |4. Wings of Fire - A.P.J. Abdul Kalam's autobiography.| &&
*          cl_abap_char_utilities=>newline &&
*          |5. The Diary of a Young Girl - Anne Frank's famous diary.|.
*
*      WHEN 'History'.
*
*        rv_recommendations =
*          |1. Sapiens - A history of humankind.| &&
*          cl_abap_char_utilities=>newline &&
*          |2. Guns, Germs, and Steel - The development of human societies.| &&
*          cl_abap_char_utilities=>newline &&
*          |3. A Brief History of Time - Exploring the history of the universe.| &&
*          cl_abap_char_utilities=>newline &&
*          |4. The Silk Roads - A history of global connections.| &&
*          cl_abap_char_utilities=>newline &&
*          |5. India After Gandhi - Modern Indian history.|.
*
*      WHEN 'Education'.
*
*        rv_recommendations =
*          |1. Make It Stick - Effective learning techniques.| &&
*          cl_abap_char_utilities=>newline &&
*          |2. Mindset - Understanding the power of learning and growth.| &&
*          cl_abap_char_utilities=>newline &&
*          |3. How Children Succeed - Factors behind successful learning.| &&
*          cl_abap_char_utilities=>newline &&
*          |4. The Learning Brain - Understanding how people learn.| &&
*          cl_abap_char_utilities=>newline &&
*          |5. The Element - Discovering your strengths and potential.|.
*
*      WHEN OTHERS.
*
*        rv_recommendations =
*          |1. Explore popular books in { iv_genre }.| &&
*          cl_abap_char_utilities=>newline &&
*          |2. Discover highly rated { iv_genre } titles.| &&
*          cl_abap_char_utilities=>newline &&
*          |3. Explore classic { iv_genre } books.| &&
*          cl_abap_char_utilities=>newline &&
*          |4. Find modern { iv_genre } recommendations.| &&
*          cl_abap_char_utilities=>newline &&
*          |5. Discover new authors in { iv_genre }.|.
*
*    ENDCASE.

    CASE iv_genre.

      WHEN 'Technology'.

        rv_recommendations =
          |1. Clean ABAP| &&
          cl_abap_char_utilities=>newline &&
          |   Author: Clean ABAP Community| &&
          cl_abap_char_utilities=>newline &&
          |   Published: 2022| &&
          cl_abap_char_utilities=>newline &&
          |   Price: 45.00| &&
          cl_abap_char_utilities=>newline &&
          |   Why: Modern and clean development practices for ABAP.| &&
          cl_abap_char_utilities=>newline &&
          cl_abap_char_utilities=>newline &&

          |2. ABAP to the Future| &&
          cl_abap_char_utilities=>newline &&
          |   Author: Paul Hardy| &&
          cl_abap_char_utilities=>newline &&
          |   Published: 2023| &&
          cl_abap_char_utilities=>newline &&
          |   Price: 55.00| &&
          cl_abap_char_utilities=>newline &&
          |   Why: Advanced techniques for modern ABAP development.| &&
          cl_abap_char_utilities=>newline &&
          cl_abap_char_utilities=>newline &&

          |3. SAP Fiori Elements| &&
          cl_abap_char_utilities=>newline &&
          |   Author: SAP Press| &&
          cl_abap_char_utilities=>newline &&
          |   Published: 2023| &&
          cl_abap_char_utilities=>newline &&
          |   Price: 49.99| &&
          cl_abap_char_utilities=>newline &&
          |   Why: Helps developers build modern SAP user interfaces.| &&
          cl_abap_char_utilities=>newline &&
          cl_abap_char_utilities=>newline &&

          |4. SAP BTP Development| &&
          cl_abap_char_utilities=>newline &&
          |   Author: SAP Press| &&
          cl_abap_char_utilities=>newline &&
          |   Published: 2024| &&
          cl_abap_char_utilities=>newline &&
          |   Price: 59.99| &&
          cl_abap_char_utilities=>newline &&
          |   Why: Covers cloud application development on SAP BTP.| &&
          cl_abap_char_utilities=>newline &&
          cl_abap_char_utilities=>newline &&

          |5. Developing with RAP| &&
          cl_abap_char_utilities=>newline &&
          |   Author: SAP Community| &&
          cl_abap_char_utilities=>newline &&
          |   Published: 2024| &&
          cl_abap_char_utilities=>newline &&
          |   Price: 39.99| &&
          cl_abap_char_utilities=>newline &&
          |   Why: Useful for learning modern RESTful ABAP development.|.


      WHEN 'Business'.

        rv_recommendations =
          |1. The Lean Startup| &&
          cl_abap_char_utilities=>newline &&
          |   Author: Eric Ries| &&
          cl_abap_char_utilities=>newline &&
          |   Published: 2011| &&
          cl_abap_char_utilities=>newline &&
          |   Price: 18.99| &&
          cl_abap_char_utilities=>newline &&
          |   Why: Practical approach to building and testing businesses.| &&
          cl_abap_char_utilities=>newline &&
          cl_abap_char_utilities=>newline &&

          |2. Good to Great| &&
          cl_abap_char_utilities=>newline &&
          |   Author: Jim Collins| &&
          cl_abap_char_utilities=>newline &&
          |   Published: 2001| &&
          cl_abap_char_utilities=>newline &&
          |   Price: 16.50| &&
          cl_abap_char_utilities=>newline &&
          |   Why: Explains how companies achieve sustained excellence.| &&
          cl_abap_char_utilities=>newline &&
          cl_abap_char_utilities=>newline &&

          |3. Zero to One| &&
          cl_abap_char_utilities=>newline &&
          |   Author: Peter Thiel| &&
          cl_abap_char_utilities=>newline &&
          |   Published: 2014| &&
          |   Price: 17.99| &&
          cl_abap_char_utilities=>newline &&
          |   Why: Focuses on innovation and creating new businesses.| &&
          cl_abap_char_utilities=>newline &&
          cl_abap_char_utilities=>newline &&

          |4. The Innovator's Dilemma| &&
          cl_abap_char_utilities=>newline &&
          |   Author: Clayton Christensen| &&
          cl_abap_char_utilities=>newline &&
          |   Published: 1997| &&
          cl_abap_char_utilities=>newline &&
          |   Price: 20.00| &&
          cl_abap_char_utilities=>newline &&
          |   Why: Explains disruptive innovation and business strategy.| &&
          cl_abap_char_utilities=>newline &&
          cl_abap_char_utilities=>newline &&

          |5. Atomic Habits| &&
          cl_abap_char_utilities=>newline &&
          |   Author: James Clear| &&
          cl_abap_char_utilities=>newline &&
          |   Published: 2018| &&
          cl_abap_char_utilities=>newline &&
          |   Price: 18.99| &&
          cl_abap_char_utilities=>newline &&
          |   Why: Practical methods for improving habits and productivity.|.


      WHEN 'Fiction'.

        rv_recommendations =
          |1. The Great Gatsby| &&
          cl_abap_char_utilities=>newline &&
          |   Author: F. Scott Fitzgerald| &&
          cl_abap_char_utilities=>newline &&
          |   Published: 1925| &&
          cl_abap_char_utilities=>newline &&
          |   Price: 12.99| &&
          cl_abap_char_utilities=>newline &&
          |   Why: A classic story of ambition, wealth and society.| &&
          cl_abap_char_utilities=>newline &&
          cl_abap_char_utilities=>newline &&

          |2. 1984| &&
          cl_abap_char_utilities=>newline &&
          |   Author: George Orwell| &&
          cl_abap_char_utilities=>newline &&
          |   Published: 1949| &&
          cl_abap_char_utilities=>newline &&
          |   Price: 14.99| &&
          cl_abap_char_utilities=>newline &&
          |   Why: A powerful dystopian story about control and freedom.| &&
          cl_abap_char_utilities=>newline &&
          cl_abap_char_utilities=>newline &&

          |3. The Alchemist| &&
          cl_abap_char_utilities=>newline &&
          |   Author: Paulo Coelho| &&
          cl_abap_char_utilities=>newline &&
          |   Published: 1988| &&
          cl_abap_char_utilities=>newline &&
          |   Price: 15.99| &&
          cl_abap_char_utilities=>newline &&
          |   Why: A motivational story about dreams and self-discovery.| &&
          cl_abap_char_utilities=>newline &&
          cl_abap_char_utilities=>newline &&

          |4. The Kite Runner| &&
          cl_abap_char_utilities=>newline &&
          |   Author: Khaled Hosseini| &&
          cl_abap_char_utilities=>newline &&
          |   Published: 2003| &&
          cl_abap_char_utilities=>newline &&
          |   Price: 17.99| &&
          cl_abap_char_utilities=>newline &&
          |   Why: A powerful story about friendship, guilt and redemption.| &&
          cl_abap_char_utilities=>newline &&
          cl_abap_char_utilities=>newline &&

          |5. To Kill a Mockingbird| &&
          cl_abap_char_utilities=>newline &&
          |   Author: Harper Lee| &&
          cl_abap_char_utilities=>newline &&
          |   Published: 1960| &&
          cl_abap_char_utilities=>newline &&
          |   Price: 13.99| &&
          cl_abap_char_utilities=>newline &&
          |   Why: A classic story exploring justice and social inequality.|.


      WHEN 'Fantasy'.

        rv_recommendations =
          |1. The Hobbit| &&
          cl_abap_char_utilities=>newline &&
          |   Author: J.R.R. Tolkien| &&
          cl_abap_char_utilities=>newline &&
          |   Published: 1937| &&
          cl_abap_char_utilities=>newline &&
          |   Price: 15.99| &&
          cl_abap_char_utilities=>newline &&
          |   Why: An exciting fantasy adventure through Middle-earth.| &&
          cl_abap_char_utilities=>newline &&
          cl_abap_char_utilities=>newline &&

          |2. Harry Potter and the Philosopher's Stone| &&
          cl_abap_char_utilities=>newline &&
          |   Author: J.K. Rowling| &&
          cl_abap_char_utilities=>newline &&
          |   Published: 1997| &&
          cl_abap_char_utilities=>newline &&
          |   Price: 18.99| &&
          cl_abap_char_utilities=>newline &&
          |   Why: A magical story about friendship, courage and adventure.| &&
          cl_abap_char_utilities=>newline &&
          cl_abap_char_utilities=>newline &&

          |3. Mistborn| &&
          cl_abap_char_utilities=>newline &&
          |   Author: Brandon Sanderson| &&
          cl_abap_char_utilities=>newline &&
          |   Published: 2006| &&
          cl_abap_char_utilities=>newline &&
          |   Price: 19.99| &&
          cl_abap_char_utilities=>newline &&
          |   Why: A creative fantasy world built around a unique magic system.|.


      WHEN 'History'.

        rv_recommendations =
          |1. Sapiens| &&
          cl_abap_char_utilities=>newline &&
          |   Author: Yuval Noah Harari| &&
          cl_abap_char_utilities=>newline &&
          |   Published: 2011| &&
          cl_abap_char_utilities=>newline &&
          |   Price: 22.99| &&
          cl_abap_char_utilities=>newline &&
          |   Why: Explores the history and development of humankind.| &&
          cl_abap_char_utilities=>newline &&
          cl_abap_char_utilities=>newline &&

          |2. India After Gandhi| &&
          cl_abap_char_utilities=>newline &&
          |   Author: Ramachandra Guha| &&
          cl_abap_char_utilities=>newline &&
          |   Published: 2007| &&
          cl_abap_char_utilities=>newline &&
          |   Price: 25.00| &&
          cl_abap_char_utilities=>newline &&
          |   Why: Detailed account of India's history after independence.| &&
          cl_abap_char_utilities=>newline &&
          cl_abap_char_utilities=>newline &&

          |3. The Silk Roads| &&
          cl_abap_char_utilities=>newline &&
          |   Author: Peter Frankopan| &&
          cl_abap_char_utilities=>newline &&
          |   Published: 2015| &&
          cl_abap_char_utilities=>newline &&
          |   Price: 21.99| &&
          cl_abap_char_utilities=>newline &&
          |   Why: Presents history through global trade and cultural connections.|.


      WHEN OTHERS.

        rv_recommendations =
          |1. Explore popular { iv_genre } books.| &&
          cl_abap_char_utilities=>newline &&
          |   Author: Various Authors| &&
          cl_abap_char_utilities=>newline &&
          |   Published: Various Years| &&
          cl_abap_char_utilities=>newline &&
          |   Price: Various Prices| &&
          cl_abap_char_utilities=>newline &&
          |   Why: A selection of popular books from this genre.|.

    ENDCASE.



  ENDMETHOD.

ENDCLASS.
