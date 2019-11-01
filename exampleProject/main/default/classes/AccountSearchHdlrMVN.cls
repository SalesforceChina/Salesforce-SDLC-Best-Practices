public with sharing class AccountSearchHdlrMVN implements MED_AccountSearchIntf {

    public AccountSearchHdlrMVN() {}

    public List<MED_AccountSearchRslt> search(MED_AccountSearchRqst searchRequest) {
        return new List<MED_AccountSearchRslt>();
    }

    public MED_AccountSearchRslt insertAccountDetails(MED_AccountSearchRslt asr) {
        //Result was from Salesforce so no need to insert or do anything.
        return asr;
    }

    public List<MED_AccountSearchRslt> getAccountsWithDetails(MED_AccountSearchRqst searchRequest) {
        List<MED_AccountSearchRslt> results = new List<MED_AccountSearchRslt>();

        if (searchRequest.accountExternalIds == null || searchRequest.accountExternalIds.isEmpty()) {
            return results;
        }

        for (Account acct : [SELECT Id, MED_External_Id_Formula__c, MED_Country__c
                                FROM Account
                                WHERE MED_External_Id__c IN :searchRequest.accountExternalIds
                                    OR Id IN :searchRequest.accountExternalIds]) {
            results.add(new MED_AccountSearchRslt(acct, 'AccountSearchHdlrMVN', searchRequest));
        }

        return results;
    }
}