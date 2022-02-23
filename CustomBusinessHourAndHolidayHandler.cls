global class CustomBusinessHourAndHolidayHandler {

    @InvocableMethod(label = 'Check if given Date/Time is within Business Hours including Holiday')
    public static List<Results> execute(List<Requests> requestList) {
    
        List<Results> responseWrapper = new List<Results> ();
       
        BusinessHours objBusinessHours = [SELECT Id FROM BusinessHours WHERE IsDefault = true];
        
        if(objBusinessHours != null) {
            for (Requests request: requestList){
            
                Datetime targetDateTime = request.InputDateTimeField;
                Boolean isWithinBusinessHours = BusinessHours.isWithin(objBusinessHours.id, targetDateTime);
                
                Results response = new Results();   
                response.outputIsBusinessHour = isWithinBusinessHours;         
                responseWrapper.add(response);
            }
        }
        
        return responseWrapper;
    }

    public class Requests {
       @InvocableVariable(label = 'Date/Time Field' required = true)
       public Datetime InputDateTimeField;
    
    }

    public class Results {
       @InvocableVariable(label = 'outputIsBusinessHour' required = true)
       public Boolean outputIsBusinessHour;
    }

}