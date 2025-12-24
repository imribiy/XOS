<# :
@echo off & setlocal
fltmc >nul 2>&1 || (powershell start -verb runas '%~0' & exit /b)
powershell -noprofile -ep bypass -command "iex (${%~f0} | out-string)"
goto :eof
#>

Add-Type -AssemblyName System.Windows.Forms, System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

# --- Configuration ---
$Apps = @(
    @{ N="Google Chrome"; C="googlechrome" }; @{ N="Mozilla Firefox"; C="firefox" }
    @{ N="Brave"; C="brave" }; @{ N="Opera"; C="opera" }; @{ N="Opera GX"; C="opera-gx" }
    @{ N="Chromium"; C="chromium" }; @{ N="Zen Browser"; C="zen-browser" }
    @{ N="Librewolf"; C="librewolf" }; @{ N="Microsoft Edge"; C="microsoft-edge" }
    @{ N="Steam"; C="steam" }; @{ N="Epic Games"; C="epicgameslauncher" }
    @{ N="EA App"; C="ea-app" }; @{ N="Ubisoft Connect"; C="ubisoft-connect" }
    @{ N="OBS Studio"; C="obs-studio.install" }; @{ N="qBittorrent"; C="qbittorrent" }
    @{ N="RustDesk"; C="rustdesk" }; @{ N="AnyDesk"; C="anydesk.portable" }
    @{ N="TeamViewer"; C="teamviewer" }; @{ N="Python"; C="python" }
    @{ N="DirectX"; C="directx" }; @{ N="Cloudflare WARP"; C="warp" }
    @{ N="VLC"; C="vlc" }; @{ N="Spotify"; C="spotify" }
    @{ N="HWiNFO"; C="hwinfo.portable" }; @{ N="CPU-Z"; C="cpu-z.portable" }
    @{ N="GPU-Z"; C="gpu-z" }; @{ N="OCCT"; C="occt" }
    @{ N="Notepad++"; C="notepadplusplus.install" }; @{ N="AMD Chipset"; C="amd-ryzen-chipset" }
    @{ N="AMD Ryzen Master"; C="amd-ryzen-master" }; @{ N="Bulk Crap Uninstaller"; C="bulk-crap-uninstaller" }
    @{ N="Malwarebytes"; C="malwarebytes" }; @{ N="ShareX"; C="sharex" }
)
$Global:SelectionState = [System.Collections.Generic.HashSet[string]]::new()

# --- Choco Check ---
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    $r = [System.Windows.Forms.MessageBox]::Show("Chocolatey missing. Install now?", "Setup", "YesNo", "Question")
    if ($r -ne 'Yes') { exit }
    [System.Net.ServicePointManager]::SecurityProtocol = 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

# --- GUI Setup ---
$Form = New-Object System.Windows.Forms.Form -Property @{
    Text = "XOS Installer"; Size = "340,360"; StartPosition = "CenterScreen"
    MaximizeBox = $false; FormBorderStyle = "FixedDialog"; Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($PSHOME + "\powershell.exe")
}

$TxtSearch = New-Object System.Windows.Forms.TextBox -Property @{
    Location = "12,12"; Size = "300,23"; Text = "Search..."; ForeColor = "Gray"
}

$List = New-Object System.Windows.Forms.CheckedListBox -Property @{
    Location = "12,45"; Size = "300,230"; CheckOnClick = $true
}

$BtnRun = New-Object System.Windows.Forms.Button -Property @{
    Location = "12,285"; Size = "300,30"; Text = "Install Selected"; BackColor = "White"
}

$Form.Controls.AddRange(@($TxtSearch, $List, $BtnRun))

# --- Logic ---
$List.Add_ItemCheck({
    param($s, $e)
    $name = $s.Items[$e.Index]
    if ($e.NewValue -eq 'Checked') { [void]$SelectionState.Add($name) } else { [void]$SelectionState.Remove($name) }
})

$UpdateList = {
    $filter = if ($TxtSearch.Text -eq "Search...") { "" } else { $TxtSearch.Text.ToLower() }
    $List.BeginUpdate()
    $List.Items.Clear()
    foreach ($app in $Apps) {
        if ($app.N.ToLower().Contains($filter)) {
            $idx = $List.Items.Add($app.N)
            if ($SelectionState.Contains($app.N)) { $List.SetItemChecked($idx, $true) }
        }
    }
    $List.EndUpdate()
}

$TxtSearch.Add_GotFocus({ if ($this.Text -eq "Search...") { $this.Text=""; $this.ForeColor="Black" } })
$TxtSearch.Add_LostFocus({ if ([string]::IsNullOrWhiteSpace($this.Text)) { $this.Text="Search..."; $this.ForeColor="Gray" } })
$TxtSearch.Add_TextChanged($UpdateList)

$BtnRun.Add_Click({
    if ($SelectionState.Count -eq 0) { return }
    $Form.Enabled = $false; $Form.Cursor = "WaitCursor"
    
    foreach ($name in $SelectionState) {
        $cmd = ($Apps | ?{$_.N -eq $name}).C
        $Form.Text = "Installing $name..."
        [System.Windows.Forms.Application]::DoEvents() # Keep UI alive
        
        Start-Process "choco" -ArgumentList "install $cmd -y --ignore-checksums" -NoNewWindow -Wait
    }
    
    $Form.Text = "XOS Installer"; $Form.Enabled = $true; $Form.Cursor = "Default"
    $Form.Refresh() # Force paint before blocking with MessageBox
    [System.Windows.Forms.MessageBox]::Show($Form, "Operations Complete.", "Done")
})

# --- Init ---
&$UpdateList
[void]$Form.ShowDialog()