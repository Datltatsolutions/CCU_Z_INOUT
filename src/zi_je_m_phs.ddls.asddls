@AbapCatalog.sqlViewName: 'Z_INOUT'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Incoming Outgoing - Journal Entries View'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view ZI_JE_M_PHS as select from I_JournalEntry as JE_view
association [0..1] to zjeurl as url_je on $projection.AccountingDocument = url_je.journalentries_key
{
    key CompanyCode,
    key FiscalYear,
    key AccountingDocument,
    @UI.lineItem: [ { 
    position: 20,
    type: #WITH_URL,
    url: 'WebsiteUrl'   -- Reference to element
  } ]
    @Semantics.imageUrl: true
    url_je.icons,
    url_je.url as WebsiteUrl,
    url_je.clickcount as CountPreview,
    url_je.last_preview as LastTimePreview,
    AccountingDocumentType,
    DocumentDate,
    PostingDate,
    FiscalPeriod,
    AccountingDocumentCreationDate,
    AccountingDocCreatedByUser,
    DocumentReferenceID,
    ReverseDocument,
    ReverseDocumentFiscalYear,
    AccountingDocumentHeaderText,
    TransactionCurrency,
    AccountingDocumentCategory,
    ReferenceDocumentType,
    OriginalReferenceDocument,
    ReversalReason
}
