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

Describe "Basics" {
    It "Exercise One - Domains" {

        # TODO: Crate a new temporary file

        $File = New-TemporaryFile
        
        # TODO: Add line to the file with text "# Enter domain names in separate lines"
        
        Add-Content -Path $file -Value "# Enter domain names in separate lines"

        # TODO: Open the file in notaped and three domains in separate lines

        Start-Process notepad -ArgumentList $File -Wait 
        
        # TODO: Read the data from file (without first line)

        $data = Get-Content -Path $File -Tail 3
        
        # TODO: Check that there are at lest two domains

        $data.Count | Should -BeGreaterOrEqual 2
        
        # TODO: Validate using regular expression that each line contaions proper domain name (e.g.: portal.azure.com)
        
        foreach($domain in $data) {
            $domain | Should -match "\w\.\w"
        }

        # [OPTIONAL] TODO: Store current setting for displaying progress bars
        
        # [OPTIONAL] TODO: Disable displaying progress bars
        
        # TODO: Check that each domain is reachable by testing whether a TCP connection can be established (ping succeds)
        
        foreach ($domain in $data) {
            (Test-NetConnection $domain).PingSucceeded | Should -be $true
        }

        # [OPTIONAL] TODO: Restore original setting displaying progress bars
        
        # TODO: Remove temporary file
        
        Remove-Item $File

    }
}
