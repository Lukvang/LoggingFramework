/**
 * @description       : Deletes logs based on time specified 
 * @test class        : LogTest
 * @test coverage     : 100%
 * @author            : lukevang@lvsolutions.co
 * @group             : 
 * @last modified on  : 02-10-2021
 * @last modified by  : lukevang@lvsolutions.co
 * Modifications Log 
 * Ver   Date         Author               Modification
 * 1.0   02-10-2021   lukevang@lvsolutions.co   Initial Version
**/
global with sharing class LogDeleteJob implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        Integer daysToDelete = 30;
        if(Log_Setting__c.getOrgDefaults() != null && Log_Setting__c.getOrgDefaults().Delete_Days__c != null){
           daysToDelete = Integer.valueOf(Log_Setting__c.getOrgDefaults().Delete_Days__c);
        }
        daysToDelete = (daysToDelete * -1);
        Date dateToCheckAgainst = System.today().addDays(daysToDelete);
        String query = 'SELECT Id, CreatedDate FROM Log__c WHERE DAY_ONLY(convertTimezone(CreatedDate)) <=: dateToCheckAgainst';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope){
        Database.delete(scope);
    }

    global void finish(Database.BatchableContext BC){
        //do nothing
    }


}