CLASS lhc_journalentries DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS read FOR READ
      IMPORTING keys FOR READ JournalEntries_C RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK JournalEntries_C.

    METHODS preview_api FOR MODIFY
      IMPORTING keys FOR ACTION JournalEntries_C~preview_api.
    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE JournalEntries_C.

ENDCLASS.

CLASS lhc_journalentries IMPLEMENTATION.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD preview_api.

    try.
        READ ENTITIES OF zi_je_m_phs IN LOCAL MODE
        ENTITY JournalEntries_C
        FIELDS ( ACCOUNTINGDOCUMENT ) WITH CORRESPONDING #( keys )
        RESULT DATA(JE_result).
        DATA(pr_keys) = VALUE I_JournalEntry( AccountingDocument = KEYS[ 1 ]-AccountingDocument ).
        IF pr_keys-AccountingDocument IS NOT INITIAL.
            SELECT count( * ) from zjeurl WHERE journalentries_key = @pr_keys-AccountingDocument into @DATA(Rec_JE_count).
                IF Rec_JE_count = 0.
                    INSERT zjeurl  FROM TABLE @( VALUE #(
                        (
                        client = '100'
                        journalentries_key = pr_keys-AccountingDocument
                        company = pr_keys-CompanyCode
                        fiscalyear = pr_keys-FiscalYear
                        url = 'http://ep.atsolutions.com.vn:8010/IncomingPDF/GeneratePDF?JEID=''' && pr_keys-AccountingDocument && ''''
                        icons = 'Preview'
                        clickcount = 1
                        last_preview = cl_abap_context_info=>get_system_date( )
                       )
                    ) ).

*                    rec_je-url = 'http://ep.atsolutions.com.vn:8010/IncomingPDF/GeneratePDF?JEID=''' && JE_select-AccountingDocument && ''''.
                ELSE.
                    select * from zjeurl WHERE journalentries_key = @pr_keys-AccountingDocument into @DATA(Rec_JE).
                        TYPES ind_wa TYPE zjeurl WITH INDICATORS col_ind
                                     TYPE abap_bool.
                        DATA ind_tab TYPE TABLE OF ind_wa.

                        ind_tab = VALUE #(
                           ( journalentries_key = pr_keys-AccountingDocument
                             url = 'http://ep.atsolutions.com.vn:8010/IncomingPDF/GeneratePDF?JEID='''
                                   && pr_keys-AccountingDocument && ''''
                             icons = 'Preview'
                             company = pr_keys-CompanyCode
                             fiscalyear = pr_keys-FiscalYear
                             clickcount = Rec_JE-clickcount + 1
                             last_preview = cl_abap_context_info=>get_system_date( )
                             col_ind-url = abap_true
                             col_ind-icons = abap_true
                             col_ind-clickcount = abap_true
                             col_ind-last_preview = abap_true )
                           ).

                        UPDATE zjeurl FROM TABLE @ind_tab
                            INDICATORS SET STRUCTURE col_ind.
                     ENDSELECT.

*                    DELETE from zjeurl where journalentries_key = @pr_keys-AccountingDocument.
*                    MODIFY ENTITIES OF zi_je_m_phs IN LOCAL MODE
*                      ENTITY JournalEntries
*                        UPDATE FIELDS ( WebsiteUrl )
*                        WITH VALUE #( (
*                                         WebsiteUrl = |javascript:window.open(| & |'http://ep.atsolutions.com.vn:8010/IncomingPDF/GeneratePDF?JEID=''' && pr_keys-AccountingDocument && ''''| & |)|
*                                       ) ).
*                    rec_je-url = 'http://ep.atsolutions.com.vn:8010/IncomingPDF/GeneratePDF?JEID=''' && pr_keys-AccountingDocument && ''''.
                endif.
        ENDIF.

    CATCH cx_http_dest_provider_error cx_web_http_client_error cx_web_message_error.
    "error handling
    ENDTRY.
*    DATA:
*    lv_url   TYPE C, "   SPACE
*    lv_frontend_not_supported    TYPE C, "
*    lv_window_name   TYPE C, "   SPACE
*    lv_frontend_error    TYPE C, "
*    lv_new_window    TYPE SY-datar. "   SPACE
    "lv_prog_not_found    TYPE SY, "
    "lv_no_batch  TYPE SY, "
    "lv_browser_type  TYPE TOLE-APP, "
    "lv_contextstring     TYPE SDOK_IFACE-CONTEXTSTR, "
    "lv_unspecified_error     TYPE SDOK_IFACE. "

*      CALL FUNCTION 'CALL_BROWSER' "Call browsers with instance management
*        EXPORTING
*                URL = 'ep.atsolutions.com.vn:8010/IncomingPDF/GeneratePDF'
*                WINDOW_NAME = 'temp'
*                NEW_WINDOW  = lv_new_window
*
*        EXCEPTIONS
*                FRONTEND_NOT_SUPPORTED = 1
*                FRONTEND_ERROR = 2
*                PROG_NOT_FOUND = 3
*                NO_BATCH = 4
*                UNSPECIFIED_ERROR = 5
*    . " CALL_BROWSER



*    try.
*        data(lo_http_destination) =
*             cl_http_destination_provider=>create_by_url( 'http://ep.atsolutions.com.vn:8010/IncomingPDF/GeneratePDF' ).
*
*    "create HTTP client by destination
*    DATA(lo_web_http_client) = cl_web_http_client_manager=>create_by_http_destination( lo_http_destination ) .
*
*    "adding headers with API Key for API Sandbox
*    DATA(lo_web_http_request) = lo_web_http_client->get_http_request( ).
*    lo_web_http_request->set_header_fields( VALUE #(
*    (  name = 'Accept' value = 'application/json' )
*     ) ).
*
*    "set request method and execute request
*    DATA(lo_web_http_response) = lo_web_http_client->execute( if_web_http_client=>GET ).
*    DATA(lv_response_status) = lo_web_http_response->get_status( )."GET RESPONSE STATUS
*    DATA(TEMP) = ''.
*
*    CATCH cx_http_dest_provider_error cx_web_http_client_error cx_web_message_error.
*            "error handling
*    ENDTRY.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zi_je_m_phs DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zi_je_m_phs IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
