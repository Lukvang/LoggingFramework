/**
 * @description       : Log entry class used to create logs to monitor activity in Salesforce
 * @test class        : LogTest
 * @test coverage     : 100%
 * @author            : lukevang@lvsolutions.co
 * @group             : 
 * @last modified on  : 02-10-2021
 * @last modified by  : lukevang@lvsolutions.coteq
 * Modifications Log 
 * Ver   Date         Author               Modification
 * 1.0   02-10-2021   lukevang@lvsolutions.co   Initial Version
 * 1.1   02-10-2021   lukevang@lvsolutions.co   Updating to include methods that allow manual enttry of classname and method
**/
global with sharing class Log {
    
    static List<Log__c> logsToInsert;
   // static List<LogEvent__e> platformEventLogs;

    /**
    * @description used to log general debug statements
    * @author lukevang@lvsolutions.co | 02-10-2021 
    * @param message 
    **/
    global static void createDebugLog(String message){
        Log__c log = new Log__c ();
        log.Message__c = message;
        log.Type__c = 'DEBUG';
        addLog(log);
    }

       /**
    * @description used to log general debug statements
    * @author lukevang@lvsolutions.co | 02-10-2021 
    * @param message 
    * @param className
    * @param methodName
    **/
    global static void createDebugLog(String message, String className, String methodName){
        Log__c log = new Log__c ();
        log.Message__c = message;
        log.Type__c = 'DEBUG';
        log.Class_Name__c = className;
        log.Method_Name__c = methodName;
        addLog(log);
    }
    
    /**
    * @description used to log exceptions
    * @author lukevang@lvsolutions.co | 02-10-2021 
    * @param ex 
    **/
    global static void createExceptionLog(Exception ex)
    {
        Log__c log = new Log__c ();
        log.Message__c = ex.getMessage();
        log.Stack_Trace__c = ex.getStackTraceString();
        log.Type__c = 'EXCEPTION';
        log.Line_Number__c = ex.getLineNumber();
        log.Type_Name__c = ex.getTypeName();
        addLog(log);
    }

   /**
    * @description used to log exceptions
    * @author lukevang@lvsolutions.co | 02-10-2021 
    * @param ex 
    * @param className
    * @param methodName
    **/
    global static void createExceptionLog(Exception ex, String className, String methodName)
    {
        Log__c log = new Log__c ();
        log.Message__c = ex.getMessage();
        log.Stack_Trace__c = ex.getStackTraceString();
        log.Type__c = 'EXCEPTION';
        log.Line_Number__c = ex.getLineNumber();
        log.Type_Name__c = ex.getTypeName();
        log.Class_Name__c = className;
        log.Method_Name__c = methodName;
        addLog(log);
    }

    /**
    * @description used to log outbound API calls
    * @author lukevang@lvsolutions.co | 02-10-2021 
    * @param request 
    * @param response 
    **/
    global static void createOutboundAPILog(HttpRequest request, HttpResponse response)
    {
        Log__c log = new Log__c ();
        log.Request_Body__c = request.getBody() != null ? request.getBody() : null;
        log.Method__c = request.getMethod() != null ? request.getMethod() : null;
        log.Endpoint__c =request.getEndpoint() != null ? request.getEndpoint() : null;
        log.Response_Body__c = response.getBody() != null ? response.getBody() : null;
        log.Status__c = response.getStatus() != null ? response.getStatus() : null;
        log.Status_Code__c = response.getStatusCode() != null ? response.getStatusCode() : null;
        log.Type__c = 'API OUTBOUND';
        addLog(log);
    }

   /**
    * @description used to log outbound API calls
    * @author lukevang@lvsolutions.co | 02-10-2021 
    * @param request 
    * @param response 
    * @param className
    * @param methodName
    **/
    global static void createOutboundAPILog(HttpRequest request, HttpResponse response,  String className, String methodName)
    {
        Log__c log = new Log__c ();
        log.Request_Body__c = request.getBody() != null ? request.getBody() : null;
        log.Method__c = request.getMethod() != null ? request.getMethod() : null;
        log.Endpoint__c =request.getEndpoint() != null ? request.getEndpoint() : null;
        log.Response_Body__c = response.getBody() != null ? response.getBody() : null;
        log.Status__c = response.getStatus() != null ? response.getStatus() : null;
        log.Status_Code__c = response.getStatusCode() != null ? response.getStatusCode() : null;
        log.Type__c = 'API OUTBOUND';
        log.Class_Name__c = className;
        log.Method_Name__c = methodName;
        addLog(log);
    }

    /**
    * @description used to log inbound api requets
    * @author lukevang@lvsolutions.co | 02-10-2021 
    * @param request 
    **/
    global static void createInboundAPILog(RestRequest request)
    {
        Log__c log = new Log__c ();
        log.Request_Body__c = request.requestBody != null ? request.requestBody.toString() : null;
        log.Method__c = request.httpMethod != null ? request.httpMethod : null;
        log.Endpoint__c = request.resourcePath != null ? request.resourcePath : null;
        log.Type__c = 'API INBOUND';
        addLog(log);
    }

   /**
    * @description used to log inbound api requets
    * @author lukevang@lvsolutions.co | 02-10-2021 
    * @param request 
    * @param className
    * @param methodName
    **/
    global static void createInboundAPILog(RestRequest request,   String className, String methodName)
    {
        Log__c log = new Log__c ();
        log.Request_Body__c = request.requestBody != null ? request.requestBody.toString() : null;
        log.Method__c = request.httpMethod != null ? request.httpMethod : null;
        log.Endpoint__c = request.resourcePath != null ? request.resourcePath : null;
        log.Type__c = 'API INBOUND';
        log.Class_Name__c = className;
        log.Method_Name__c = methodName;
        addLog(log);
    }
    

    /**
    * @description used to create log through platform event, only used in cases where you want to log and exception but also throw an exception
    * @author lukevang@lvsolutions.co | 02-10-2021 
    * @param ex 
    **/
    // private static void createExceptionLogPE(Exception ex)
    // {
    //     LogEvent__e log = new LogEvent__e ();
    //     log.Message__c = ex.getMessage();
    //     log.Stack_Trace__c = ex.getStackTraceString();
    //     log.Type__c = 'EXCEPTION';
    //     log.Line_Number__c = ex.getLineNumber();
    //     log.Type_Name__c = ex.getTypeName();
    //     addPlatformEventLog(log);
    // }

    /**
    * @description creates platform event log
    * @author lukevang@lvsolutions.co | 02-10-2021 
    * @param log 
    **/
    // static void addPlatformEventLog(LogEvent__e log)
    // {
    //     Request reqInfo = Request.getCurrent();
    //     if(platformEventLogs == null)
    //     {
    //         platformEventLogs = new List<LogEvent__e>();
    //     }
    //     log.Transaction_Id__c = reqInfo.getRequestId();
    //     log.Quiddity__c = String.valueOf(reqInfo.getQuiddity());
    //     log.CPU_Time__c = Limits.getCpuTime();
    //     log.Aggregate_Queries__c = Limits.getAggregateQueries();
    //     log.DML_Rows__c = Limits.getDmlRows();
    //     log.DML_Statements__c = Limits.getDmlStatements();
    //     log.Email_Invocations__c = Limits.getEmailInvocations();
    //     log.Heap_Size__c = Limits.getHeapSize();
    //     log.Queries__c = Limits.getQueries();
    //     log.Running_User__c = UserInfo.getUserId();
    //     populateClassAndMethod(log);
    //     platformEventLogs.add(log);
    // }

    
    static void addLog(Log__c log)
    {
        Request reqInfo = Request.getCurrent();
        if(logsToInsert == null)
        {
            logsToInsert = new List<Log__c>();
        }
        log.Transaction_Id__c = reqInfo.getRequestId();
        log.Quiddity__c = String.valueOf(reqInfo.getQuiddity());
        log.CPU_Time__c = Limits.getCpuTime();
        log.Aggregate_Queries__c = Limits.getAggregateQueries();
        log.DML_Rows__c = Limits.getDmlRows();
        log.DML_Statements__c = Limits.getDmlStatements();
        log.Email_Invocations__c = Limits.getEmailInvocations();
        log.Heap_Size__c = Limits.getHeapSize();
        log.Queries__c = Limits.getQueries();
        log.Running_User__c = UserInfo.getUserId();
        if(log.Class_Name__c == null && log.Method_Name__c == null)
        {
            populateClassAndMethod(log);
        }
        logsToInsert.add(log);
    }

    /**
    * @description gets the executing high method and class name
    * @authorluke.vang@lvsolutions.co | 02-10-2021 
    * @param stackTrace 
    * @param log 
    **/
    private static void populateLocation(String stackTrace, Log__c log)
    {
        String stack = stackTrace.substringAfter('\n').substringAfter('\n').substringAfter('\n').substringBefore('\n');
        log.Method_Name__c = stack.substringBefore(':').subStringAfterLast('.');
        log.Class_Name__c = stack.substringBetween('Class.', '.' + log.Method_Name__c);
    }

       /**
    * @description gets the executing high method and class name
    * @authorluke.vang@lvsolutions.co | 02-10-2021 
    * @param stackTrace 
    * @param log 
    **/
    // private static void populateLocation(String stackTrace, LogEvent__e log)
    // {
    //     String stack = stackTrace.substringAfter('\n').substringAfter('\n').substringAfter('\n').substringBefore('\n');
    //     log.Method_Name__c = stack.substringBefore(':').subStringAfterLast('.');
    //     log.Class_Name__c = stack.substringBetween('Class.', '.' + log.Method_Name__c);
    // }

    /**
    * @description populates the apex class and method for each log
    * @authorluke.vang@lvsolutions.co | 02-10-2021 
    * @param log 
    **/
    static void populateClassAndMethod(Log__c log)
    {
        try{
            throw new DMLException('ex');
        }catch(Exception ex){
            populateLocation(ex.getStackTraceString(), log);
        }
    }

        /**
    * @description populates the apex class and method for each log
    * @authorluke.vang@lvsolutions.co | 02-10-2021 
    * @param log 
    **/
    // static void populateClassAndMethod(LogEvent__e log)
    // {
    //     try{
    //         throw new DMLException('ex');
    //     }catch(Exception ex){
    //         populateLocation(ex.getStackTraceString(), log);
    //     }
    // }

       /**
    * @description general function to create logs
    * @author lukevang@lvsolutions.co | 02-09-2021 
    **/
    global static void insertLogs()
    {
        if(logsToInsert != null && !logsToInsert.isEmpty() && enabled())
        {
            insert logsToInsert;
            logsToInsert.clear();
        }
    }

      /**
    * @description general function to create logs in future method
    * @author lukevang@lvsolutions.co | 02-09-2021 
    **/
    global static void insertLogsFuture()
    {
        if(logsToInsert != null && !logsToInsert.isEmpty() && enabled())
        {
            callFuture(JSON.serialize(logsToInsert));
            logsToInsert.clear();
        }
    }

    /**
    * @description 
    * @authorluke.vang@lvsolutions.co | 02-09-2021 
    * @param logs 
    **/
    @future
    global static void callFuture(String logs)
    {
        logsToInsert = (List<Log__c>) JSON.deserialize(logs, List<Log__c>.class);
        insert logsToInsert;
    }

    /**
    * @description general function to platform event logs
    * @author lukevang@lvsolutions.co | 02-09-2021 
    **/
    // private static void insertLogsPE()
    // {
    //     if(!platformEventLogs.isEmpty() && enabled())
    //     {
    //         List<Database.SaveResult> results = EventBus.publish(platformEventLogs);
    //         // Inspect publishing result for each event
    //         for (Database.SaveResult sr : results) {
    //             if (!sr.isSuccess()){
    //                 for(Database.Error err : sr.getErrors()) {
    //                     System.debug('Error returned: ' + err.getStatusCode() + ' - ' + err.getMessage());
    //                 }
    //             }       
    //         }
    //     }
    // }

    static Boolean enabled()
    {
        return Log_Setting__c.getOrgDefaults() == null ? false : Log_Setting__c.getOrgDefaults().Enable_Logs__c;
    }

}