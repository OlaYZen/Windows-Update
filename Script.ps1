if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

Start-Sleep -Milliseconds 500

[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Reflection.Assembly]::LoadWithPartialName("PresentationFramework")

if (Get-Module -ListAvailable -Name PSWindowsUpdate) {
    Write-Host "PSWindowsUpdate exists"
    if (Get-Module -ListAvailable -Name PSWindowsUpdate) {
        Import-Module PSWindowsUpdate
    } 
} 
else {
    Write-Host "PSWindowsUpdate does not exist, Installing ..."
    Install-Module PSWindowsUpdate -force
    if (Get-Module -ListAvailable -Name PSWindowsUpdate) {
        Import-Module PSWindowsUpdate
    } 
}
function installwingetjson 
{
    (
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/OlaYZen/Windows-Update/main/winget-export.json -OutFile $PSScriptRoot"".\winget-export.json    
    )
    If (Test-Path -Path $PSScriptRoot"".\winget-export.json ) {
        $button7.Visible = $false
        $button2.Visible = $true
        $button4.Visible = $true
    }
    else
    {
        $button7.Visible = $true
        $button2.Visible = $false
        $button4.Visible = $false
    }
}
function CheckBoxFunc {
    if ($checkBox.Checked)
        {
            $button5.Visible = $false
            $button6.Visible = $true
        }
    else
        {
            $button5.Visible = $true
            $button6.Visible = $false  
        }
}

function CheckBoxFunc2 {
    if ($checkBox2.Checked)
        {
            $button8.Visible = $true
            $button1.Visible = $false
        }
    else
        {
            $button8.Visible = $false
            $button1.Visible = $true
        }
}

function GetWindowsUpdates {   
    (
        Get-WindowsUpdate -AcceptAll -WindowsUpdate -ForceDownload
    )
    $button1.Visible = $false
    $button8.Visible = $false
}

function GetWindowsUpdates2 {   
    (
        Get-WindowsUpdate -AcceptAll -MicrosoftUpdate -ForceDownload
    )
    $button1.Visible = $false
    $button8.Visible = $false
}

function UpdateWindowsUpdatesnoReboot {
    (
    Install-WindowsUpdate -Confirm -AcceptAll -ForceInstall
    )
    
}

function UpdateWindowsUpdateswithReboot {
    (
        Install-WindowsUpdate -Confirm -AcceptAll -AutoReboot -ForceInstall
    )
    
}


function InstallProgramsViajsonWinget {
    (
        winget import .\winget-export.json --accept-package-agreements --accept-source-agreements --ignore-versions --ignore-unavailable
    )
    
}
function WingetUpgrade {
    (
        winget upgrade --all --accept-source-agreements --silent --include-unknown
    )
    
}

function EditWinget {
    (
        notepad.exe $PSScriptRoot"".\winget-export.json
    )
    
}

[System.Windows.Forms.Application]::EnableVisualStyles()
$button1 = New-Object System.Windows.Forms.Button
$button1.Location = '12, 5'
$button1.Name = "Get Windows Updates"
$button1.Size = '95, 55'
$button1.TabIndex = 0
$button1.Text = "Get Windows Updates"
$button1.Add_Click({GetWindowsUpdates})

[System.Windows.Forms.Application]::EnableVisualStyles()
$button8 = New-Object System.Windows.Forms.Button
$button8.Location = '12, 5'
$button8.Name = "Get Windows Updates"
$button8.Size = '95, 55'
$button8.Visible = $false
$button8.TabIndex = 0
$button8.Text = "Get Windows Updates"
$button8.Add_Click({GetWindowsUpdates2})

[System.Windows.Forms.Application]::EnableVisualStyles()
$button5 = New-Object System.Windows.Forms.Button
$button5.Location = '12, 5'
$button5.Name = "Install Windows Updates"
$button5.Size = '95, 55'
$button5.TabIndex = 0
$button5.Text = "Install Windows Updates"
$button5.Add_Click({UpdateWindowsUpdatesnoReboot})

[System.Windows.Forms.Application]::EnableVisualStyles()
$button6 = New-Object System.Windows.Forms.Button
$button6.Location = '12, 5'
$button6.Name = "Install Windows Updates"
$button6.Size = '95, 55'
$button6.TabIndex = 0
$button6.Visible = $false
$button6.Text = "Install Windows Updates"
$button6.Add_Click({UpdateWindowsUpdateswithReboot})

[System.Windows.Forms.Application]::EnableVisualStyles()
$button2 = New-Object System.Windows.Forms.Button
$button2.Location = '122, 5'
$button2.Name = "Install Programs via Winget"
$button2.Size = '95, 55'
$button2.TabIndex = 1
$button2.Text = "Install Programs via Winget"
$button2.Add_Click({InstallProgramsViajsonWinget})

[System.Windows.Forms.Application]::EnableVisualStyles()
$button3 = New-Object System.Windows.Forms.Button
$button3.Location = '232, 5'
$button3.Name = "Upgrade Winget software"
$button3.Size = '95, 55'
$button3.TabIndex = 2
$button3.Text = "Upgrade Winget software"
$button3.Add_Click({WingetUpgrade})

[System.Windows.Forms.Application]::EnableVisualStyles()
$button7 = New-Object System.Windows.Forms.Button
$button7.Location = '122, 5'
$button7.Name = "Install Winget Json"
$button7.Size = '95, 95'
$button7.TabIndex = 2
$button7.Text = "Install Winget Json"
$button7.Add_Click({installwingetjson})

[System.Windows.Forms.Application]::EnableVisualStyles()
$button4 = New-Object System.Windows.Forms.Button
$button4.Location = '122, 60'
$button4.Name = "Edit Winget Software"
$button4.Size = '95, 35'
$button4.TabIndex = 2
$button4.Text = "Edit Winget Software"
$button4.Add_Click({EditWinget})

$checkBox = new-object System.Windows.Forms.checkbox
$checkBox.Location = '12, 65'
$checkBox.Size = '85, 15'
$checkBox.Text = "AutoReboot"
$checkBox.Add_Click({CheckBoxFunc})

$checkBox2 = new-object System.Windows.Forms.checkbox
$checkBox2.Location = '12, 65'
$checkBox2.Size = '95, 55'
$checkBox2.Text = "Microsoft Update"
$checkBox2.Add_Click({CheckBoxFunc2})

$AutoReboot = New-Object System.Windows.Forms.TextBox
$AutoReboot.Location = '12, 175'
$AutoReboot.Multiline = $true
$AutoReboot.Name = "textBoxDisplay3"
$AutoReboot.Size = '460, 175' 
$AutoReboot.ReadOnly = $true 
$AutoReboot.Visible = $false
$AutoReboot.BackColor = "White"

$VersionLabel = New-Object System.Windows.Forms.Label

#Release Label
$VersionLabel.Location = '266, 90' 
#Release Label

#Preview Label
#$VersionLabel.Location = '216, 90' 
#Preview Label

$VersionLabel.Name = 'Versionlabel'
$VersionLabel.Text = "Version 1.2.4"
$VersionLabel.Size = '490, 500'

$Form = New-Object System.Windows.Forms.Form
$Form.StartPosition = "CenterScreen"
$Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
$Form.Name = "mainForm"
$Form.Text = "Windows and Winget Updates"
$Form.MaximizeBox = $False
$Form.ShowInTaskbar = $true
$Form.Controls.Add($button1)
$Form.Controls.Add($button8)
$Form.Controls.Add($button2)
$Form.Controls.Add($button3)
$Form.Controls.Add($button7)
$Form.Controls.Add($button4)
$Form.Controls.Add($button5)
$Form.Controls.Add($button6)
$Form.Controls.Add($checkBox)
$Form.Controls.Add($checkBox2)
$Form.Controls.Add($AutoReboot)
$Form.Controls.Add($VersionLabel)
$Form.Controls.Add($RichTextBoxDisplay)

$iconBase64      = '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'
$iconBytes       = [Convert]::FromBase64String($iconBase64)
$stream          = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)
$Form.Icon       = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream).GetHIcon()))

$Form.Add_Shown({$Form.Activate()})
$Form.Size = '352, 142'
$Form.Topmost = $false 

If (Test-Path -Path $PSScriptRoot"".\winget-export.json ) {
    $button7.Visible = $false
    $button2.Visible = $true
    $button4.Visible = $true
}
else
{
    $button7.Visible = $true
    $button2.Visible = $false
    $button4.Visible = $false
}


[void]$Form.ShowDialog()
[void]$stream.Dispose()
[void]$Form.Dispose()
