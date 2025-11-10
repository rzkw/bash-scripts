  User Management Script: Create a bash script called /root/create_accounts.sh that:
•	Reads a file /root/userlist.txt containing usernames (one per line)
•	For each username in the file:
    ◦	Creates the user account if it doesn't already exist
    ◦	Sets the password to "TempPass123"
    ◦	Adds the user to the "developers" group
    ◦	Creates a file in the user's home directory called welcometxt with the content "Welcome to the system"
•	The script should skip any line that starts with # (comments)
•	Ensure the script is executable and runs without errors even if some users already exist
   
To make executable and run script:
```
chmod +x /root/create_accounts.sh
cd /root && ./create_accounts.sh
```