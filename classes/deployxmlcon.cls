//ChamingaD
public with sharing class deployxmlcon {

   public List<ApexClass> classes {get; set;}
   public List<ApexPage> pages {get; set;}
   public List<ApexTrigger> triggers {get; set;}
   public List<StaticResource> resources {get; set;}
   public List<ApexComponent> components {get; set;}
   public List<String> filesList {get; set;}
   public Map<String, String> filesMap {get; set;}
   public List<String> fileStamps  {get; set;}
   public Map<String, String> todayFiles {get; set;}

   public deployxmlcon(){
       User u = [select Id, username from User where Id = :UserInfo.getUserId()];
       String filter = ApexPages.currentPage().getParameters().get('filter');
       filesList = new List<String>();
       filesMap = new Map<String, String>();
       todayFiles = new Map<String, String>();

       if (filter=='modified'){
           classes = [SELECT Name, LastModifiedDate FROM ApexClass WHERE LastModifiedById =:u.Id order by Lastmodifieddate desc LIMIT 50000];
           pages = [SELECT Name, LastModifiedDate FROM ApexPage WHERE LastModifiedById =:u.Id order by Lastmodifieddate desc LIMIT 50000];
           triggers = [SELECT Name, LastModifiedDate FROM ApexTrigger WHERE LastModifiedById =:u.Id order by Lastmodifieddate desc LIMIT 50000];
           resources = [SELECT Name, LastModifiedDate FROM StaticResource WHERE LastModifiedById  =:u.Id order by Lastmodifieddate desc LIMIT 50000];
           components = [SELECT Name, LastModifiedDate FROM ApexComponent WHERE LastModifiedById  =:u.Id order by Lastmodifieddate desc LIMIT 50000];
       } else if (filter=='created'){
           classes = [SELECT Name, LastModifiedDate FROM ApexClass WHERE CreatedById =:u.Id order by Lastmodifieddate desc LIMIT 50000];
           pages = [SELECT Name, LastModifiedDate FROM ApexPage WHERE CreatedById =:u.Id order by Lastmodifieddate desc LIMIT 50000];
           triggers = [SELECT Name, LastModifiedDate FROM ApexTrigger WHERE CreatedById =:u.Id order by Lastmodifieddate desc LIMIT 50000];
           resources= [SELECT Name, LastModifiedDate FROM StaticResource WHERE CreatedById  =:u.Id order by Lastmodifieddate desc LIMIT 50000];
           components = [SELECT Name, LastModifiedDate FROM ApexComponent WHERE CreatedById  =:u.Id order by Lastmodifieddate desc LIMIT 50000];
       }
       else{
           classes = [SELECT Name, LastModifiedDate FROM ApexClass order by Lastmodifieddate desc LIMIT 50000];
           pages = [SELECT Name, LastModifiedDate FROM ApexPage order by Lastmodifieddate desc LIMIT 50000];
           triggers = [SELECT Name, LastModifiedDate FROM ApexTrigger order by Lastmodifieddate desc LIMIT 50000];
           resources= [SELECT Name, LastModifiedDate FROM StaticResource order by Lastmodifieddate desc LIMIT 50000];
           components = [SELECT Name, LastModifiedDate FROM ApexComponent order by Lastmodifieddate desc LIMIT 50000];
       }
       
       String lastMod;
       for (ApexClass clas : classes){
           filesList.add(clas.Name+'.cls');
           
           lastMod = String.valueOf(clas.Lastmodifieddate);
           lastMod = lastMod.replaceAll( ':', '');
           lastMod = lastMod.replaceAll( '-', '');
           lastMod = lastMod.replaceAll( '\\s+', '');
           
           if(Date.today().day() == clas.Lastmodifieddate.day() && Date.today().month() == clas.Lastmodifieddate.month() && Date.today().year() == clas.Lastmodifieddate.year()){
               todayFiles.put(lastMod, 'today');
           }else{
               todayFiles.put(lastMod, 'not-today');
           }
           
           filesMap.put(lastMod,clas.Name+'.cls');
       }
       for (ApexPage page: pages){
           filesList.add(page.Name+'.page');
           
           lastMod = String.valueOf(page.Lastmodifieddate);
           lastMod = lastMod.replaceAll( ':', '');
           lastMod = lastMod.replaceAll( '-', '');
           lastMod = lastMod.replaceAll( '\\s+', '');
           
           if(Date.today().day() == page.Lastmodifieddate.day() && Date.today().month() == page.Lastmodifieddate.month() && Date.today().year() == page.Lastmodifieddate.year()){
               todayFiles.put(lastMod, 'today');
           }else{
               todayFiles.put(lastMod, 'not-today');
           }
           
           filesMap.put(lastMod,page.Name+'.page');
       }
       for (ApexTrigger triger: triggers){
           filesList.add(triger.Name+'.trigger');
           
           lastMod = String.valueOf(triger.Lastmodifieddate);
           lastMod = lastMod.replaceAll( ':', '');
           lastMod = lastMod.replaceAll( '-', '');
           lastMod = lastMod.replaceAll( '\\s+', '');
           
           if(Date.today().day() == triger.Lastmodifieddate.day() && Date.today().month() == triger.Lastmodifieddate.month() && Date.today().year() == triger.Lastmodifieddate.year()){
               todayFiles.put(lastMod, 'today');
           }else{
               todayFiles.put(lastMod, 'not-today');
           }
           
           filesMap.put(lastMod,triger.Name+'.trigger');
       }
       for (StaticResource resource: resources){
           filesList.add(resource.Name+'.resource');
           
           lastMod = String.valueOf(resource.Lastmodifieddate);
           lastMod = lastMod.replaceAll( ':', '');
           lastMod = lastMod.replaceAll( '-', '');
           lastMod = lastMod.replaceAll( '\\s+', '');
           
           if(Date.today().day() == resource.Lastmodifieddate.day() && Date.today().month() == resource.Lastmodifieddate.month() && Date.today().year() == resource.Lastmodifieddate.year()){
               todayFiles.put(lastMod, 'today');
           }else{
               todayFiles.put(lastMod, 'not-today');
           }
           
           filesMap.put(lastMod,resource.Name+'.resource');
       }
       for (ApexComponent component: components){
           filesList.add(component.Name+'.component');
           
           lastMod = String.valueOf(component.Lastmodifieddate);
           lastMod = lastMod.replaceAll( ':', '');
           lastMod = lastMod.replaceAll( '-', '');
           lastMod = lastMod.replaceAll( '\\s+', '');
           
           if(Date.today().day() == component.Lastmodifieddate.day() && Date.today().month() == component.Lastmodifieddate.month() && Date.today().year() == component.Lastmodifieddate.year()){
               todayFiles.put(lastMod, 'today');
           }else{
               todayFiles.put(lastMod, 'not-today');
           }
           
           filesMap.put(lastMod,component.Name+'.component');
       }

       fileStamps = new List<String>(filesMap.keySet());
       fileStamps.sort();
       
       List<String> finalList = new List<String>();
        for(Integer i = fileStamps.size()-1; i>=0;i--)
        {
            finalList.add(fileStamps.get(i));
        }
        
       fileStamps = finalList;
        
   }

}