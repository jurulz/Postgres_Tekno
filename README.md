PostgreSQL Installation and Validation Script for Teknoparrot


This PowerShell script automates the process of installing PostgreSQL 8.3, setting up necessary dependencies, and validating the installation for Teknoparrot by unspoiledpuma. It provides a guided installation experience with clear visual cues and status updates.

Features
Folder Selection: Prompts the user to select a base folder for PostgreSQL installation.
Download and Extraction: Automatically downloads and extracts the PostgreSQL installer.
Service Management: Ensures the Secondary Logon service is running, which is required for the installation.
Prerequisites Installation: Installs the Microsoft VC++ 2005 runtime libraries.
PostgreSQL Installation: Installs PostgreSQL and provides prompts for user interaction.
Installation Verification: Validates the PostgreSQL service (pgsql-8.3) is running and provides detailed status information.
Reboot Prompt: Prompts the user to reboot the system to complete the installation process.
How to Use
Download the Script: Clone the repository or download the script file Install_Postgress_Teknoparrotv1-0.ps1.

Run the Script: Execute the script in a PowerShell session with administrative privileges.

powershell
Copy code
.\Install_Postgress_Teknoparrotv1-0.ps1
Follow Prompts: The script will guide you through selecting the installation folder and other necessary steps.

Summary of Actions
At the end of the installation process, the script provides a summary of the following actions:

Installation Folder Selection: Confirms the folder where PostgreSQL will be installed.
Download and Extraction: Status of the PostgreSQL installer download and extraction.
Secondary Logon Service: Checks if the service is started or already running.
VC++ 2005 Runtime Installation: Status of the Microsoft VC++ runtime installation.
PostgreSQL Installation: Confirms whether PostgreSQL was installed successfully.
Verification: Validates the PostgreSQL service is running, providing detailed service status information.
Example Output
plaintext
Copy code
#######################################
PostgreSQL Installation and Validation
#######################################
Step 1: Select Installation Folder
...
Step 6: Verifying PostgreSQL Installation...
PostgreSQL service 'pgsql-8.3' is running.
Service Status Details:
    SERVICE_NAME: pgsql-8.3
    DISPLAY_NAME: PostgreSQL Database Server 8.3
    STATE: 4 RUNNING
    START_TYPE: 2 AUTO_START
    SERVICE_TYPE: 0x10 WIN32_OWN_PROCESS
#######################################
            Summary of Actions
#######################################
Select Installation Folder: Completed
Download PostgreSQL Installer: Completed
Unzip PostgreSQL Installer: Completed
Ensure Secondary Logon Service: Already Running
Install VC++ 2005 Runtime: Completed
Install PostgreSQL: Completed
Verify PostgreSQL Installation: Success
#######################################
Thank you for using the installation script!
Please ensure that you reboot your computer if not done yet.
#######################################
Reboot
The script prompts for a reboot at the end of the installation process. It is recommended to reboot your system to complete the setup.

License
This project is licensed under the MIT License.

Contributing
Feel free to fork this project, submit issues, or contribute to improve the script.
