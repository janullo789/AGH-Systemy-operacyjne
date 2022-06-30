<#
    Before starting the exercise add this file to your repository without any changes.
    Then update the constants to make the test pass and add a second commit.
    After completing this step, report to the lecturer that the tests are working and that you have added the commit.
    Later when solving TODO-s add a commit and push changes after every single step.
    Solutions with multiple TODO-s solved in a single commit will not be accepted!
    Each solution should be in a single line.
#>

# TODO: Update the value if needed.
$Script:PowerShellExePath = 'C:\SO\PowerShell\pwsh.exe'

Describe "PowerShell" {
    It "should run in PowerShell 7.2" {
        $Version = $PSVersionTable.PSVersion
        $Version | Should -BeLike "7.2.*"
    }
    It "should have binary in proper location" {
        Test-Path $PowerShellExePath | Should -Be $true
    }
}

# TODO: Update the value if needed.
$Script:VSCodeExePath = 'C:\SO\VSCode\code.exe'

Describe "VSCode" {
    It "should have binary in proper location" {
        Test-Path $VSCodeExePath | Should -Be $true
    }
}

# TODO: Update the values if needed.
$Script:RemoteComputerName = 'maszynasysopers.internal.cloudapp.net'
$Script:RemoteUser = 'StudentServer'
$Script:RemoteHostName = "MaszynaSysOperS"

Describe "Remoting" {
    BeforeAll {
        $credential = Get-Credential -UserName $RemoteUser
        $Script:RemoteSession = New-PSSession -ComputerName $RemoteComputerName -Credential $credential
    }
    It "should have correct computer name" {
        Invoke-Command -Session $RemoteSession { hostname } | Should -Be $RemoteHostName
    }
    It "Exercise Two - Remote Average" {

        $data = ".\Data"

        # TODO: Remove the 'Data' directory if it exists

        Remove-Item $data -ErrorAction SilentlyContinue
        
        # TODO: Create a directory named 'Data' (quietly)

        New-Item -Path $data -ItemType Directory | Out-Null
        
        # TODO: Push location into the 'Data' directory

        Push-Location $data
        
        # TODO: Get the number of files to create from the user (with a prompt "Enter number of files: ")
         
        $ilosc = Read-Host "Enter number of files: "

        # TODO: Check that number of files is gretater than or equal to 500

        $ilosc.count | Should -BeGreaterOrEqual 500
        
        # TODO: Create files named numer_0.txt, numer_1.txt, ..., number_[N-1].txt and write a random number from range [0, 100] inside
        
        foreach($i in $ilosc) { New-Item -Path "numer_$i.txt" -ItemType File  }

        # TODO: Pop location

        Pop-Location
        
        # TODO: Compress that 'Data' directory into the 'Data.zip' archive

        $archive = "Data.zip"

        Compress-Archive -Path ./Data -Destination $archive
        
        # TODO: Remove the 'Data' directory

        Remove-Item $data
        
        # TODO: Enter the home directory on the remote machine
        
        # TODO: Remove a directory named 'Playground' on the remote machine if it exists (in the home directory)
        
        $playground = ".\Playground"

        Remove-Item $playground -ErrorAction SilentlyContinue

        # TODO: Create a directory named 'Playground' on the remote machine (in the home directory)

        New-Item -Path $playground -ItemType Directory
        
        # TODO: Enter the 'Playground' directory on the remote machine
        
        # TODO: Get the absolute path of the created directory on the remote machine
        
        # TODO: Copy the archive into that remote directory (using the obtained absolute path)
        
        # TODO: Remove the 'Data.zip' file

        Remove-Item "Data.zip"
        
        # TODO: Unzip the file on the remote machine ('Data' folder in the same directory as 'Data.zip')

        Expand-Archive -Path "Data.zip" -DestinationPath "Data"
        
        # TODO: Get the avarage of all the values in the files (calculate that on the remote machine!)
        
        # TODO: Check that the obtained average is near the value 50 (+/- 1)
        
        # TODO: Enter the home directory on the remote machine
        
        # TODO: Remove a directory named 'Playground' on the remote machine (in the home directory)
        
    }
    AfterAll {
        Remove-PSSession $RemoteSession
    }
}
