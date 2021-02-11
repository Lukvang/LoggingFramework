/**
 * @description       : scheduable job to delete log files
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
global class LogDeleteJobScheduable implements Schedulable {
    global void execute(SchedulableContext SC){
        Database.executeBatch(new LogDeleteJob(), 200);
    }
}