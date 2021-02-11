/**
 * @description       : Test class
 * @test class        : 
 * @test coverage     : 
 * @author            : lukevang@lvsolutions.co
 * @group             : 
 * @last modified on  : 02-10-2021
 * @last modified by  : lukevang@lvsolutions.co
 * Modifications Log 
 * Ver   Date         Author               Modification
 * 1.0   02-10-2021   lukevang@lvsolutions.co   Initial Version
**/
@isTest
public with sharing class LogTest {

    @testSetup
    static void testSetup()
    {
        Log_Setting__c settings = new Log_Setting__c();
        settings.Delete_Days__c = 0;
        settings.Enable_Logs__c = true;
        insert settings;
    }   

    static testMethod void testCreateDebugLog1()
    {
        Test.startTest();
        Log.createDebugLog('This is a test');
        Log.insertLogs();
        Test.stopTest();
        System.assertEquals(1, [SELECT COUNT() FROM Log__c]);
    }
    
    static testMethod void testCreateDebugLog2()
    {
        Test.startTest();
        Log.createDebugLog('This is a test', 'test', 'test');
        Log.insertLogs();
        Test.stopTest();
        System.assertEquals(1, [SELECT COUNT() FROM Log__c]);
    }

    static testMethod void testCreateFutureLog()
    {
        Test.startTest();
        Log.createDebugLog('This is a test');
        Log.insertLogsFuture();
        Test.stopTest();
        System.assertEquals(1, [SELECT COUNT() FROM Log__c]);
    }

    static testMethod void testCreateExceptionLog1()
    {
        Test.startTest();
        try{
            Account a = new Account();
            insert a;
        }catch(Exception ex){
            Log.createExceptionLog(ex);
        }finally{
            Log.insertLogs();
        }
        Test.stopTest();
        System.assertEquals(1, [SELECT COUNT() FROM Log__c]);
    }
    
        static testMethod void testCreateExceptionLog2()
    {
        Test.startTest();
        try{
            Account a = new Account();
            insert a;
        }catch(Exception ex){
            Log.createExceptionLog(ex, 'test', 'test');
        }finally{
            Log.insertLogs();
        }
        Test.stopTest();
        System.assertEquals(1, [SELECT COUNT() FROM Log__c]);
    }


    static testMethod void testCreateOutboundAPILog1()
    {
        Test.startTest();
        HttpRequest request  = new HttpRequest();
        HttpResponse response = new HttpResponse();
        Log.createOutboundAPILog(request, response);
        Log.insertLogs();
        Test.stopTest();
        System.assertEquals(1, [SELECT COUNT() FROM Log__c]);
    }
    
    static testMethod void testCreateOutboundAPILog2()
    {
        Test.startTest();
        HttpRequest request  = new HttpRequest();
        HttpResponse response = new HttpResponse();
        Log.createOutboundAPILog(request, response, 'test', 'test');
        Log.insertLogs();
        Test.stopTest();
        System.assertEquals(1, [SELECT COUNT() FROM Log__c]);
    }


    static testMethod void testCreateInboundAPILog1()
    {
        Test.startTest();
        RestRequest request = new RestRequest();
        Log.createInboundAPILog(request);
        Log.insertLogs();
        Test.stopTest();
        System.assertEquals(1, [SELECT COUNT() FROM Log__c]);
    }
    
    
    static testMethod void testCreateInboundAPILog2()
    {
        Test.startTest();
        RestRequest request = new RestRequest();
        Log.createInboundAPILog(request,'test', 'test');
        Log.insertLogs();
        Test.stopTest();
        System.assertEquals(1, [SELECT COUNT() FROM Log__c]);
    }

    static testMethod void testDeleteJob()
    {   
        Log.createDebugLog('This is a test');
        Log.insertLogs();
        System.assertEquals(1, [SELECT COUNT() FROM Log__c]);
        Test.startTest();
        LogDeleteJobScheduable job = new LogDeleteJobScheduable();
        job.execute(null);
        Test.stopTest();
        System.assertEquals(0, [SELECT COUNT() FROM Log__c]);
    }

}