BEBUI0000_Cookbook_YouTrack
===========================

The YouTrack Cookbook


To restore a database from a backup, proceed as follows:

Download a backup tar.gz file via web UI from the Administration > Database Backup page or locate a needed backup file directly in the specified backup folder on the YouTrack server machine.
Stop YouTrack server instance.
Clean all content of the database location directory. By default, the database is located in the teamsysdata folder in the home directory of a user account, which starts YouTrack. You can change default database location, for more details please refer to the Changing Database Location page.
Extract the downloaded backup file to your database location.
Start YouTrack.


You can untar the YouTrack buckups using:
tar -zxvf data.tar.gz