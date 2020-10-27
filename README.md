Remove Az Empty Resource Group
==============================

            

Very simple powershell function which is meant to remove all empty resource groups which are found.


Function is accepting one of the paramters from two possible parameter sets.


In case you specify All, it will check against all available resource groups, if they are empty and remove the empty ones.


If you specify the specific resource group, it will check if its empty, in case it is - it will remove it.

 

        
    
TechNet gallery is retiring! This script was migrated from TechNet script center to GitHub by Microsoft Azure Automation product group. All the Script Center fields like Rating, RatingCount and DownloadCount have been carried over to Github as-is for the migrated scripts only. Note : The Script Center fields will not be applicable for the new repositories created in Github & hence those fields will not show up for new Github repositories.
