
# **PostgreSQL Installation and Validation Script for Teknoparrot**

This PowerShell script automates the process of installing PostgreSQL 8.3, setting up necessary dependencies, and validating the installation for Teknoparrot. It provides a guided installation experience with clear visual cues and status updates.

## **Features**

- **Folder Selection**: Prompts the user to select a base folder for PostgreSQL installation.
- **Download and Extraction**: Automatically downloads and extracts the PostgreSQL installer.
- **Service Management**: Ensures the Secondary Logon service is running, which is required for the installation.
- **Prerequisites Installation**: Installs the Microsoft VC++ 2005 runtime libraries.
- **PostgreSQL Installation**: Installs PostgreSQL and provides prompts for user interaction.
- **Installation Verification**: Validates the PostgreSQL service (`pgsql-8.3`) is running and provides detailed status information.
- **Reboot Prompt**: Prompts the user to reboot the system to complete the installation process.

## **How to Use**

If You have getting this error:  " The file
C:\Install_Postgress_Teknoparrotv1-0.ps1 is not digitally signed. You cannot run this script on the current system."

**Open a powershell in admin and run this command**: 

```Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass```

Of course the Script is not digitaly signed ;)

1. **Download the Script**: Clone the repository or download the script file `Install_Postgress_Teknoparrotv1-0.ps1`.
2. **Run the Script**: Execute the script in a PowerShell session with administrative privileges.

    ```powershell
    .\Install_Postgress_Teknoparrotv1-0.ps1
    ```

3. **Follow Prompts**: The script will guide you through selecting the installation folder and other necessary steps.

## **Youtube Link**:  https://youtu.be/jrTkxemapRg

The script prompts for a reboot at the end of the installation process. It is recommended to reboot your system to complete the setup.

## **Summary of Actions**

At the end of the installation process, the script provides a summary of the following actions:

1. **Installation Folder Selection**: Confirms the folder where PostgreSQL will be installed.
2. **Download and Extraction**: Status of the PostgreSQL installer download and extraction.
3. **Secondary Logon Service**: Checks if the service is started or already running.
4. **VC++ 2005 Runtime Installation**: Status of the Microsoft VC++ runtime installation.
5. **PostgreSQL Installation**: Confirms whether PostgreSQL was installed successfully.
6. **Verification**: Validates the PostgreSQL service is running.
## **Reboot**

The script prompts for a reboot at the end of the installation process. It is recommended to reboot your system to complete the setup.

## **License**

This project is licensed under the MIT License.

## **Contributing**

Feel free to fork this project, submit issues, or contribute to improve the script.
