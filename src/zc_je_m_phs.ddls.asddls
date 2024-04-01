@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view for Journal Entries'
@Metadata.allowExtensions: true

define root view entity ZC_JE_M_PHS 
provider contract transactional_query
as projection on ZI_JE_M_PHS
{
    @Search.defaultSearchElement: true
    key CompanyCode,
    @Search.defaultSearchElement: true
    key FiscalYear,
    @Search.defaultSearchElement: true
    key AccountingDocument,
    @Semantics.imageUrl: true
    icons as PDF,
    WebsiteUrl,
    CountPreview,
    LastTimePreview,
    @Search.defaultSearchElement: true
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
