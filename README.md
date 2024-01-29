# PowerShell Script for Device Management in Microsoft Intune
Device rename script for devices undergoing autopilot provisioning 
# Key Features 
Automated Authentication: Implements a function (Get-GraphApiToken) to handle authentication with Microsoft Graph API, improving code organization and reusability.
CSV File Processing: Efficiently processes a CSV file containing device information, reducing file system interactions.
Optimized API Interaction: Utilizes Invoke-RestMethod for API calls to Microsoft Graph, with improved header management for authorization.
Streamlined JSON Handling: Simplifies JSON payload creation for API requests, reducing conversion steps and potential errors.
Enhanced Error Reporting: Provides detailed error information in case of issues during the device renaming process.
# Usage
Set Up Authentication: Input your Microsoft Application ID, Tenant Domain Name, and Access Secret when prompted.
CSV File Preparation: Ensure your CSV file contains device information with columns for serialNumber and tag.
Running the Script: Execute the script. It will read each device entry from the CSV file, authenticate with Microsoft Graph, and update device names accordingly.
# Prerequisites
PowerShell 5.1 or higher.
Access to Microsoft Graph API with the necessary permissions for device management.
# Note 
This script is intended for managing devices in Microsoft Intune and should be used in a controlled environment. Ensure to test thoroughly before deploying in a production environment.
