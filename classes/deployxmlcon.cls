public with sharing class deployxmlcon {

   public List<ApexClass> classes {get; set;}
   public List<ApexPage> pages {get; set;}
   public List<ApexTrigger> triggers {get; set;}

   public deployxmlcon(){
       User u = [select Id, username from User where Id = :UserInfo.getUserId()];
       String filter = ApexPages.currentPage().getParameters().get('filter');
       
       if (filter=='modified'){
           classes = [SELECT Name, LastModifiedDate FROM ApexClass WHERE LastModifiedById =:u.Id order by Lastmodifieddate desc LIMIT 50000];
           pages = [SELECT Name, LastModifiedDate FROM ApexPage WHERE LastModifiedById =:u.Id order by Lastmodifieddate desc LIMIT 50000];
           triggers = [SELECT Name, LastModifiedDate FROM ApexTrigger WHERE LastModifiedById =:u.Id order by Lastmodifieddate desc LIMIT 50000];
       } else if (filter=='created'){
           classes = [SELECT Name, LastModifiedDate FROM ApexClass WHERE CreatedById =:u.Id order by Lastmodifieddate desc LIMIT 50000];
           pages = [SELECT Name, LastModifiedDate FROM ApexPage WHERE CreatedById =:u.Id order by Lastmodifieddate desc LIMIT 50000];
           triggers = [SELECT Name, LastModifiedDate FROM ApexTrigger WHERE CreatedById =:u.Id order by Lastmodifieddate desc LIMIT 50000];
       }
       else{
           classes = [SELECT Name, LastModifiedDate FROM ApexClass order by Lastmodifieddate desc LIMIT 50000];
           pages = [SELECT Name, LastModifiedDate FROM ApexPage order by Lastmodifieddate desc LIMIT 50000];
           triggers = [SELECT Name, LastModifiedDate FROM ApexTrigger order by Lastmodifieddate desc LIMIT 50000];
       }
   } 
}