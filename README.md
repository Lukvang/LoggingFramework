# Error Logger

This is a simple logging framework to log exceptions, general logs, and API requests for Salesforce.

## Install link

https://login.salesforce.com/packaging/installPackage.apexp?p0=04t4x000000MpCS

## Available Methods

| Method  |  Description |
| ------------- | ------------- |
| Log.createDebugLogs(String message)  | Creates a log record of type DEBUG  | 
| Log.createExceptionLog(Exception ex)  | Creates a log record of type EXCEPTION  | 
| Log.createOutboundAPILog(HttpRequest request, HttpResponse response)  | Creates a log record of type OUTBOUND API  |
| Log.createInboundAPILog(RestRequest request)  | Creates a log record of type INBOUND API  | 
| Log.insertLogs()  | Performs a DML opertion to insert logs  | 
| Log.insertLogsFuture()  | Performs future call to perform DML operation to insert logs  | 


## Example Usage

Enable logging through custom setting first or else logging will now work. 

### Log.createDebugLogs(String message)
```
Log.createDebugLogs('testing log here');
Log.insertLogs() 
```

### Log.createExceptionLog(Exception ex)
```
try{
  //do something
}catch(Exception ex){
   Log.createExceptionLog(Exception ex)
}finally{
  Log.insertLogs() 
}
```

### Log.createOutboundAPILog(HttpRequest request, HttpResponse response)
```
Http http = new Http();

HttpRequest request = new HttpRequest();
//do a call out
HttpResponse reponse = new HttpResponse();
response = http.send(request);
//capture a response

Log.createOutboundAPILog(request, response);
Log.insertLogs() 
```

### Log.createInboundAPILog(RestRequest request)
```
@HttpPost
global static String exampleClass(){
  RestRequest req = RestContext.request;
  RestResponse res = Restcontext.response;
  
  Log.createInboundAPILog(req);
  try{
          Account a = new Account(name = 'test');
   }catch(Exception ex){
        //do something with exception
   }finally{
     Log.insertLogs() 
   }
   insert a;
   return a.Id;
 }
```

## Record Detail View

![alt text](https://drive.google.com/uc?export=view&id=15UzY-KQRvNoO1fuNVsQVe9gCv-6vd1CT)
