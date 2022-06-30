Describe "PowerShell" {
    It "should run in PowerShell 7.2" {
        $Version = $PSVersionTable.PSVersion
        $Version | Should -BeLike "7.2.*"
    }
}

Describe "Azure" {
    BeforeAll {
        # TODO: Check that user is not logged in

        Get-AzContext | Should -BeNullOrEmpty
        
        # TODO: Connect to Azure account and store result in $account

        $Script:account = Connect-AzAccount
        
    }
    Context "account" {
        It "is not null or empty" {
            # TODO: Check that account is not null or empty

            $account | Should -Not -BeNullOrEmpty
            
        }
        It "has proper type" {
            # TODO: Check that account's type is PSAzureProfile

            $account | Should -BeOfType [Microsoft.Azure.Commands.Profile.Models.Core.PSAzureProfile]
            
        }
        It "has proper user email" {
            # TODO: Check for your email address

            $account.Context.Account | Should -Be "skwarko@student.agh.edu.pl"
            
        }
        It "has proper subscription name" {
            # TODO: Check subscription name

            $account.Context.Subscription.Name | Should -Be "Azure for Students"
            
        }
        It "has enabled subscription" {
            # TODO: Check that your subscription is enabled

            $account.Context.Subscription.State | Should -Be "Enabled"
            
        }
    }
    Context "getting information about existing resources" {
        It "should have at least two running machines" {
            
            # TODO: Get all virtual machines (with status) and store them in $machines variable

            $machines = Get-AzVM -Status
            
            # TODO: Check that there are at least two machines

            $machines.Count | Should -BeGreaterOrEqual 2

            # TODO: Get the machine used during exercises and store it in $client variable

            $client = $machines | Where-Object { $_.Name -eq "MaszynaSysOper"}
            
            # TODO: Check that the client machine is running (power state)

            $client.PowerState | Should -Be "VM Running"
            
            # TODO: Check the client machine size

            $client.HardwareProfile.VmSize | Should -Be "Standard_D2as_v4"
            
            # TODO: Check the client machine admin user name

            $client.OSProfile.AdminUsername | Should -Be "janullo789"
            
            # TODO: Check the client machine is running Windows operating system

            $client.StorageProfile.OsDisk.OsType | Should -Be "Windows"
            
            # TODO: Check the client machine is running Windows 11 image

            $client.StorageProfile.ImageReference.Offer | Should -Be "windows-11"
            
            # TODO: Check the client machine Stock Keeping Unit (SKU)

            $client.StorageProfile.ImageReference.Sku | Should -Be "win11-21h2-pro"            
            
            # TODO: Get the windows server core machine and store it in $server variable

            $server = $machines | Where-Object { $_.Name -eq "MaszynaSysOperServer"}
            
            # TODO: Check that the server machine is running (power state)

            $server.PowerState | Should -Be "VM running"
            
            # TODO: Check the server machine size

            $server.HardwareProfile.VmSize | Should -Be "Standard_D2as_v4"
            
            # TODO: Check the server machine admin user name

            $server.OSProfile.AdminUsername | Should -Be "StudentServer"
            
            # TODO: Check the server machine is running Windows operating system

            $server.StorageProfile.OsDisk.OsType | Should -Be "Windows"
            
            # TODO: Check the server machine is running Windows Server image

            $server.StorageProfile.ImageReference.Offer | Should -Be "WindowsServer"
            
            # TODO: Check the server machine Stock Keeping Unit (SKU)
            
            $server.StorageProfile.ImageReference.Sku | Should -Be "2022-datacenter-azure-edition-core-smalldisk"

            # TODO: Check that both machines are in the same location
            
            $server.Location | Should -Be $client.Location
        }
    }
    Context "createing and deleteing resources" {
        It "should be able to manage resource groups" {

            # TODO: Get resource groups and store them in $resourceGroups variable

            $resourceGroups = Get-AzResourceGroup
            
            # TODO: Check that there is at least one resource group
            
            $resourceGroups.count | Should -BeGreaterOrEqual 1

            # TODO: Get the resource group where the virtual machines are created and store it in $resourceGroup variable
            
            #$resourceGroup = Get-AzResourceGroup | Where-Object { $_.ResourceGroupName -eq "Grupa3"}
            $resourceGroup = Get-AzResourceGroup -Name "Grupa3"

            # TODO: Check the location of the resource group
            
            $resourceGroup.Location | Should -Be "westeurope"

            # TODO: Create new resource group in the same geogaphic location as prvious one and save it in $newResourceGroup
            
            $newResourceGroup = New-AzResourceGroup -Name "Test" -Location $resourceGroup.Location

            # TODO: Check that now there is one more resource group than previously

            #(Get-AzResourceGroup).Count | Should -Be ($resourceGroups.Count + 1)
            
            # TODO: Check the location of new resource group
            
            $newResourceGroup.Location | Should -Be "westeurope"

            # TODO: Check the name of new resource group
            
            $newResourceGroup.ResourceGroupName | Should -Be "Test"

            # TODO: Remove new resource group

            Remove-AzResourceGroup -Name "Test" -Force | Should -BeTrue
            
            # TODO: Check the number of resource groups is exactly the same as in the begining
            
        }
    }
    AfterAll {
        # TODO: Disconnect from Azure account

        Disconnect-AzAccount
        
        # TODO: Check that user is not logged in
        
        Get-AzContext | Should -BeNullOrEmpty

    }
}