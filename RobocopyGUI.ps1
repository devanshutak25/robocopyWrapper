Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Windows.Forms

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Robocopy GUI" Width="720" Height="700" MinWidth="600" MinHeight="600"
        WindowStartupLocation="CenterScreen" Background="#1e1e2e" ResizeMode="CanResizeWithGrip">
    <Window.Resources>
        <Style TargetType="TextBlock">
            <Setter Property="Foreground" Value="#cdd6f4"/>
            <Setter Property="FontFamily" Value="Segoe UI"/>
        </Style>
        <Style TargetType="Label">
            <Setter Property="Foreground" Value="#cdd6f4"/>
            <Setter Property="FontFamily" Value="Segoe UI"/>
            <Setter Property="FontSize" Value="13"/>
        </Style>
        <Style x:Key="PathBox" TargetType="TextBox">
            <Setter Property="Background" Value="#313244"/>
            <Setter Property="Foreground" Value="#cdd6f4"/>
            <Setter Property="BorderBrush" Value="#45475a"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Padding" Value="6,4"/>
            <Setter Property="FontFamily" Value="Cascadia Code, Consolas"/>
            <Setter Property="FontSize" Value="12.5"/>
            <Setter Property="VerticalContentAlignment" Value="Center"/>
        </Style>
        <Style x:Key="BrowseBtn" TargetType="Button">
            <Setter Property="Background" Value="#45475a"/>
            <Setter Property="Foreground" Value="#cdd6f4"/>
            <Setter Property="BorderBrush" Value="#585b70"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Padding" Value="12,4"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="FontFamily" Value="Segoe UI"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" BorderBrush="{TemplateBinding BorderBrush}"
                                BorderThickness="{TemplateBinding BorderThickness}" CornerRadius="3" Padding="{TemplateBinding Padding}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="#585b70"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
        <Style x:Key="ActionBtn" TargetType="Button">
            <Setter Property="Foreground" Value="#1e1e2e"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Padding" Value="20,8"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="FontFamily" Value="Segoe UI"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="border" Background="{TemplateBinding Background}" CornerRadius="5" Padding="{TemplateBinding Padding}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="border" Property="Opacity" Value="0.85"/>
                            </Trigger>
                            <Trigger Property="IsEnabled" Value="False">
                                <Setter TargetName="border" Property="Opacity" Value="0.4"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
        <Style x:Key="OptCheck" TargetType="CheckBox">
            <Setter Property="Foreground" Value="#bac2de"/>
            <Setter Property="FontFamily" Value="Segoe UI"/>
            <Setter Property="FontSize" Value="12.5"/>
            <Setter Property="Margin" Value="0,3"/>
            <Setter Property="VerticalContentAlignment" Value="Center"/>
        </Style>
        <Style x:Key="SectionBorder" TargetType="Border">
            <Setter Property="Background" Value="#181825"/>
            <Setter Property="BorderBrush" Value="#313244"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="CornerRadius" Value="6"/>
            <Setter Property="Padding" Value="14,10"/>
            <Setter Property="Margin" Value="0,4"/>
        </Style>
    </Window.Resources>

    <Grid Margin="16,12">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <!-- Header -->
        <TextBlock Grid.Row="0" FontSize="20" FontWeight="Bold" Foreground="#89b4fa" Margin="0,0,0,10">
            Robocopy GUI
        </TextBlock>

        <!-- Source / Destination -->
        <Border Grid.Row="1" Style="{StaticResource SectionBorder}">
            <Grid>
                <Grid.RowDefinitions>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="8"/>
                    <RowDefinition Height="Auto"/>
                </Grid.RowDefinitions>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="80"/>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="Auto"/>
                    <ColumnDefinition Width="6"/>
                    <ColumnDefinition Width="Auto"/>
                </Grid.ColumnDefinitions>

                <Label Grid.Row="0" Grid.Column="0" Content="Source"/>
                <TextBox x:Name="txtSource" Grid.Row="0" Grid.Column="1" Style="{StaticResource PathBox}" AllowDrop="True"/>
                <Button x:Name="btnBrowseSrc" Grid.Row="0" Grid.Column="2" Content="Browse" Style="{StaticResource BrowseBtn}"/>
                <Button x:Name="btnSwap" Grid.Row="0" Grid.Column="4" Content="&#x21C5;" Style="{StaticResource BrowseBtn}" FontSize="16" ToolTip="Swap source and destination"/>

                <Label Grid.Row="2" Grid.Column="0" Content="Destination"/>
                <TextBox x:Name="txtDest" Grid.Row="2" Grid.Column="1" Style="{StaticResource PathBox}" AllowDrop="True"/>
                <Button x:Name="btnBrowseDest" Grid.Row="2" Grid.Column="2" Content="Browse" Style="{StaticResource BrowseBtn}"/>
            </Grid>
        </Border>

        <!-- Preset + Mode -->
        <Border Grid.Row="2" Style="{StaticResource SectionBorder}">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="80"/>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="20"/>
                    <ColumnDefinition Width="80"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>
                <Label Grid.Column="0" Content="Preset"/>
                <ComboBox x:Name="cmbPreset" Grid.Column="1" Background="#313244" FontFamily="Segoe UI" FontSize="12.5" VerticalContentAlignment="Center" Height="28">
                    <ComboBoxItem Content="Copy (default)" IsSelected="True"/>
                    <ComboBoxItem Content="Mirror"/>
                    <ComboBoxItem Content="Move"/>
                    <ComboBoxItem Content="Sync (no delete)"/>
                    <ComboBoxItem Content="Custom"/>
                </ComboBox>
                <Label Grid.Column="3" Content="Threads"/>
                <ComboBox x:Name="cmbThreads" Grid.Column="4" Background="#313244" FontFamily="Segoe UI" FontSize="12.5" VerticalContentAlignment="Center" Height="28">
                    <ComboBoxItem Content="1"/>
                    <ComboBoxItem Content="4"/>
                    <ComboBoxItem Content="8"/>
                    <ComboBoxItem Content="16" IsSelected="True"/>
                    <ComboBoxItem Content="32"/>
                    <ComboBoxItem Content="64"/>
                    <ComboBoxItem Content="128"/>
                </ComboBox>
            </Grid>
        </Border>

        <!-- Options -->
        <Border Grid.Row="3" Style="{StaticResource SectionBorder}">
            <StackPanel>
                <TextBlock FontSize="13" FontWeight="SemiBold" Foreground="#a6adc8" Margin="0,0,0,6">Options</TextBlock>
                <Grid>
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="*"/>
                    </Grid.ColumnDefinitions>
                    <StackPanel Grid.Column="0">
                        <CheckBox x:Name="chkSubdirs" Content="/E  Copy subdirectories (incl. empty)" Style="{StaticResource OptCheck}" IsChecked="True"/>
                        <CheckBox x:Name="chkPurge" Content="/PURGE  Delete dest files not in source" Style="{StaticResource OptCheck}"/>
                        <CheckBox x:Name="chkMov" Content="/MOV  Move files (delete from source)" Style="{StaticResource OptCheck}"/>
                        <CheckBox x:Name="chkMoveAll" Content="/MOVE  Move files+dirs" Style="{StaticResource OptCheck}"/>
                    </StackPanel>
                    <StackPanel Grid.Column="1">
                        <CheckBox x:Name="chkRestartable" Content="/Z  Restartable mode" Style="{StaticResource OptCheck}"/>
                        <CheckBox x:Name="chkCompress" Content="/COMPRESS  Network compression" Style="{StaticResource OptCheck}"/>
                        <CheckBox x:Name="chkETA" Content="/ETA  Show estimated time" Style="{StaticResource OptCheck}" IsChecked="True"/>
                        <CheckBox x:Name="chkNP" Content="/NP  No progress percentage" Style="{StaticResource OptCheck}"/>
                    </StackPanel>
                    <StackPanel Grid.Column="2">
                        <CheckBox x:Name="chkCopyAll" Content="/COPYALL  Copy all file attributes" Style="{StaticResource OptCheck}"/>
                        <CheckBox x:Name="chkSEC" Content="/SEC  Copy with security" Style="{StaticResource OptCheck}"/>
                        <CheckBox x:Name="chkDCopy" Content="/DCOPY:DAT  Copy dir timestamps" Style="{StaticResource OptCheck}"/>
                        <CheckBox x:Name="chkCreate" Content="/CREATE  Create dir tree only" Style="{StaticResource OptCheck}"/>
                    </StackPanel>
                </Grid>

                <!-- Retries / Wait -->
                <Grid Margin="0,8,0,0">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="80"/>
                        <ColumnDefinition Width="60"/>
                        <ColumnDefinition Width="30"/>
                        <ColumnDefinition Width="80"/>
                        <ColumnDefinition Width="60"/>
                        <ColumnDefinition Width="*"/>
                    </Grid.ColumnDefinitions>
                    <Label Grid.Column="0" Content="Retries /R:" FontSize="12"/>
                    <TextBox x:Name="txtRetries" Grid.Column="1" Style="{StaticResource PathBox}" Text="3" FontSize="12"/>
                    <Label Grid.Column="3" Content="Wait /W:" FontSize="12"/>
                    <TextBox x:Name="txtWait" Grid.Column="4" Style="{StaticResource PathBox}" Text="5" FontSize="12"/>
                </Grid>

                <!-- File filter -->
                <Grid Margin="0,8,0,0">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="80"/>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="20"/>
                        <ColumnDefinition Width="80"/>
                        <ColumnDefinition Width="*"/>
                    </Grid.ColumnDefinitions>
                    <Label Grid.Column="0" Content="Include:" FontSize="12"/>
                    <TextBox x:Name="txtInclude" Grid.Column="1" Style="{StaticResource PathBox}" FontSize="12" ToolTip="e.g. *.jpg *.png"/>
                    <Label Grid.Column="3" Content="Exclude:" FontSize="12"/>
                    <TextBox x:Name="txtExclude" Grid.Column="4" Style="{StaticResource PathBox}" FontSize="12" ToolTip="e.g. *.tmp *.log  or folder names"/>
                </Grid>

                <!-- Extra args -->
                <Grid Margin="0,8,0,0">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="80"/>
                        <ColumnDefinition Width="*"/>
                    </Grid.ColumnDefinitions>
                    <Label Grid.Column="0" Content="Extra args:" FontSize="12"/>
                    <TextBox x:Name="txtExtra" Grid.Column="1" Style="{StaticResource PathBox}" FontSize="12" ToolTip="Additional robocopy arguments"/>
                </Grid>
            </StackPanel>
        </Border>

        <!-- Command preview -->
        <Border Grid.Row="4" Style="{StaticResource SectionBorder}" Margin="0,4,0,0">
            <StackPanel>
                <TextBlock FontSize="12" Foreground="#a6adc8" Margin="0,0,0,4">Command Preview</TextBlock>
                <TextBox x:Name="txtCommand" Style="{StaticResource PathBox}" IsReadOnly="True" FontSize="11.5"
                         TextWrapping="Wrap" MinHeight="36" Background="#11111b"/>
            </StackPanel>
        </Border>

        <!-- Output log -->
        <Border Grid.Row="5" Style="{StaticResource SectionBorder}" Margin="0,4,0,0">
            <Grid>
                <Grid.RowDefinitions>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="*"/>
                </Grid.RowDefinitions>
                <Grid Grid.Row="0" Margin="0,0,0,4">
                    <TextBlock FontSize="12" Foreground="#a6adc8">Output</TextBlock>
                    <TextBlock x:Name="lblStatus" FontSize="12" Foreground="#a6e3a1" HorizontalAlignment="Right"/>
                </Grid>
                <TextBox x:Name="txtOutput" Grid.Row="1" Style="{StaticResource PathBox}" IsReadOnly="True"
                         TextWrapping="Wrap" VerticalScrollBarVisibility="Auto" AcceptsReturn="True"
                         FontSize="11" Background="#11111b" MinHeight="80"/>
            </Grid>
        </Border>

        <!-- Action buttons -->
        <Grid Grid.Row="6" Margin="0,8,0,0">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="Auto"/>
                <ColumnDefinition Width="10"/>
                <ColumnDefinition Width="Auto"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="Auto"/>
                <ColumnDefinition Width="10"/>
                <ColumnDefinition Width="Auto"/>
            </Grid.ColumnDefinitions>
            <Button x:Name="btnRun" Grid.Column="0" Content="Run Robocopy" Style="{StaticResource ActionBtn}" Background="#a6e3a1"/>
            <Button x:Name="btnDryRun" Grid.Column="2" Content="Dry Run (/L)" Style="{StaticResource ActionBtn}" Background="#89b4fa"/>
            <Button x:Name="btnStop" Grid.Column="4" Content="Stop" Style="{StaticResource ActionBtn}" Background="#f38ba8" IsEnabled="False"/>
            <Button x:Name="btnClear" Grid.Column="6" Content="Clear Log" Style="{StaticResource ActionBtn}" Background="#45475a" Foreground="#cdd6f4"/>
        </Grid>
    </Grid>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

# Get controls
$txtSource   = $window.FindName("txtSource")
$txtDest     = $window.FindName("txtDest")
$btnBrowseSrc  = $window.FindName("btnBrowseSrc")
$btnBrowseDest = $window.FindName("btnBrowseDest")
$btnSwap     = $window.FindName("btnSwap")
$cmbPreset   = $window.FindName("cmbPreset")
$cmbThreads  = $window.FindName("cmbThreads")
$chkSubdirs  = $window.FindName("chkSubdirs")
$chkPurge    = $window.FindName("chkPurge")
$chkMov      = $window.FindName("chkMov")
$chkMoveAll  = $window.FindName("chkMoveAll")
$chkRestartable = $window.FindName("chkRestartable")
$chkCompress = $window.FindName("chkCompress")
$chkETA      = $window.FindName("chkETA")
$chkNP       = $window.FindName("chkNP")
$chkCopyAll  = $window.FindName("chkCopyAll")
$chkSEC      = $window.FindName("chkSEC")
$chkDCopy    = $window.FindName("chkDCopy")
$chkCreate   = $window.FindName("chkCreate")
$txtRetries  = $window.FindName("txtRetries")
$txtWait     = $window.FindName("txtWait")
$txtInclude  = $window.FindName("txtInclude")
$txtExclude  = $window.FindName("txtExclude")
$txtExtra    = $window.FindName("txtExtra")
$txtCommand  = $window.FindName("txtCommand")
$txtOutput   = $window.FindName("txtOutput")
$lblStatus   = $window.FindName("lblStatus")
$btnRun      = $window.FindName("btnRun")
$btnDryRun   = $window.FindName("btnDryRun")
$btnStop     = $window.FindName("btnStop")
$btnClear    = $window.FindName("btnClear")

# State
$script:process = $null

# Browse folder dialog
function Browse-Folder {
    $dlg = New-Object System.Windows.Forms.FolderBrowserDialog
    $dlg.ShowNewFolderButton = $true
    if ($dlg.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        return $dlg.SelectedPath
    }
    return $null
}

$btnBrowseSrc.Add_Click({
    $path = Browse-Folder
    if ($path) { $txtSource.Text = $path }
})

$btnBrowseDest.Add_Click({
    $path = Browse-Folder
    if ($path) { $txtDest.Text = $path }
})

$btnSwap.Add_Click({
    $tmp = $txtSource.Text
    $txtSource.Text = $txtDest.Text
    $txtDest.Text = $tmp
})

# Preset logic
$cmbPreset.Add_SelectionChanged({
    $sel = $cmbPreset.SelectedIndex
    switch ($sel) {
        0 { # Copy
            $chkSubdirs.IsChecked = $true; $chkPurge.IsChecked = $false
            $chkMov.IsChecked = $false; $chkMoveAll.IsChecked = $false
        }
        1 { # Mirror
            $chkSubdirs.IsChecked = $true; $chkPurge.IsChecked = $true
            $chkMov.IsChecked = $false; $chkMoveAll.IsChecked = $false
        }
        2 { # Move
            $chkSubdirs.IsChecked = $true; $chkPurge.IsChecked = $false
            $chkMov.IsChecked = $false; $chkMoveAll.IsChecked = $true
        }
        3 { # Sync (no delete)
            $chkSubdirs.IsChecked = $true; $chkPurge.IsChecked = $false
            $chkMov.IsChecked = $false; $chkMoveAll.IsChecked = $false
        }
    }
})

# Build command string
function Build-Command {
    param([switch]$DryRun)

    $src  = $txtSource.Text.TrimEnd('\')
    $dest = $txtDest.Text.TrimEnd('\')
    $args = @()

    if ($chkSubdirs.IsChecked)    { $args += "/E" }
    if ($chkPurge.IsChecked)      { $args += "/PURGE" }
    if ($chkMov.IsChecked)        { $args += "/MOV" }
    if ($chkMoveAll.IsChecked)    { $args += "/MOVE" }
    if ($chkRestartable.IsChecked){ $args += "/Z" }
    if ($chkCompress.IsChecked)   { $args += "/COMPRESS" }
    if ($chkETA.IsChecked)        { $args += "/ETA" }
    if ($chkNP.IsChecked)         { $args += "/NP" }
    if ($chkCopyAll.IsChecked)    { $args += "/COPYALL" }
    if ($chkSEC.IsChecked)        { $args += "/SEC" }
    if ($chkDCopy.IsChecked)      { $args += "/DCOPY:DAT" }
    if ($chkCreate.IsChecked)     { $args += "/CREATE" }

    $threads = ($cmbThreads.SelectedItem.Content)
    if ($threads -and [int]$threads -gt 1) { $args += "/MT:$threads" }

    $retries = $txtRetries.Text.Trim()
    if ($retries) { $args += "/R:$retries" }
    $wait = $txtWait.Text.Trim()
    if ($wait) { $args += "/W:$wait" }

    $include = $txtInclude.Text.Trim()
    if ($include) {
        # File filter goes right after dest
        $fileFilter = $include
    } else {
        $fileFilter = ""
    }

    $exclude = $txtExclude.Text.Trim()
    if ($exclude) {
        # Split on spaces, check if they look like folders or files
        $exclude.Split(' ', [StringSplitOptions]::RemoveEmptyEntries) | ForEach-Object {
            if ($_ -match '\.\w+$') { $args += "/XF"; $args += $_ }
            else { $args += "/XD"; $args += $_ }
        }
    }

    $extra = $txtExtra.Text.Trim()
    if ($extra) { $args += $extra }

    if ($DryRun) { $args += "/L" }

    $cmd = "robocopy `"$src`" `"$dest`""
    if ($fileFilter) { $cmd += " $fileFilter" }
    $cmd += " " + ($args -join " ")
    return $cmd.Trim()
}

# Update command preview on any change
$updatePreview = {
    $txtCommand.Text = Build-Command
}

# Register change events for preview
@($txtSource, $txtDest, $txtRetries, $txtWait, $txtInclude, $txtExclude, $txtExtra) | ForEach-Object {
    $_.Add_TextChanged($updatePreview)
}
@($chkSubdirs, $chkPurge, $chkMov, $chkMoveAll, $chkRestartable, $chkCompress,
  $chkETA, $chkNP, $chkCopyAll, $chkSEC, $chkDCopy, $chkCreate) | ForEach-Object {
    $_.Add_Checked($updatePreview)
    $_.Add_Unchecked($updatePreview)
}
$cmbThreads.Add_SelectionChanged($updatePreview)
$cmbPreset.Add_SelectionChanged($updatePreview)

# Run robocopy
function Start-Robocopy {
    param([switch]$DryRun)

    if (-not $txtSource.Text -or -not $txtDest.Text) {
        [System.Windows.MessageBox]::Show("Please specify both source and destination.", "Missing Paths",
            [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Warning)
        return
    }

    if (-not (Test-Path $txtSource.Text)) {
        [System.Windows.MessageBox]::Show("Source path does not exist.", "Invalid Path",
            [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Error)
        return
    }

    $cmd = if ($DryRun) { Build-Command -DryRun } else { Build-Command }
    $txtCommand.Text = $cmd

    $txtOutput.Text = ""
    $lblStatus.Text = if ($DryRun) { "DRY RUN..." } else { "Running..." }
    $lblStatus.Foreground = [System.Windows.Media.Brushes]::Gold
    $btnRun.IsEnabled = $false
    $btnDryRun.IsEnabled = $false
    $btnStop.IsEnabled = $true

    # Extract args from the command (everything after 'robocopy')
    $argString = $cmd.Substring("robocopy ".Length)

    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = "robocopy"
    $psi.Arguments = $argString
    $psi.UseShellExecute = $false
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardError = $true
    $psi.CreateNoWindow = $true
    $psi.StandardOutputEncoding = [System.Text.Encoding]::GetEncoding(437)

    $script:process = New-Object System.Diagnostics.Process
    $script:process.StartInfo = $psi
    $script:process.EnableRaisingEvents = $true

    # Use a timer to poll output instead of async events (more reliable in WPF)
    $timer = New-Object System.Windows.Threading.DispatcherTimer
    $timer.Interval = [TimeSpan]::FromMilliseconds(200)

    $timer.Add_Tick({
        if ($null -eq $script:process) { return }

        try {
            # Read available output
            while (-not $script:process.StandardOutput.EndOfStream) {
                $line = $script:process.StandardOutput.ReadLine()
                if ($null -ne $line) {
                    $txtOutput.AppendText("$line`r`n")
                    $txtOutput.ScrollToEnd()
                }
                # Process UI events periodically
                [System.Windows.Threading.Dispatcher]::CurrentDispatcher.Invoke(
                    [System.Windows.Threading.DispatcherPriority]::Background,
                    [Action]{ }
                )
            }
        } catch {}

        if ($script:process.HasExited) {
            $timer.Stop()
            $exit = $script:process.ExitCode
            $script:process = $null

            $btnRun.IsEnabled = $true
            $btnDryRun.IsEnabled = $true
            $btnStop.IsEnabled = $false

            # Robocopy exit codes: 0-7 are success, 8+ are errors
            if ($exit -lt 8) {
                $lblStatus.Text = "Completed (exit code: $exit)"
                $lblStatus.Foreground = [System.Windows.Media.Brushes]::LightGreen
            } else {
                $lblStatus.Text = "Error (exit code: $exit)"
                $lblStatus.Foreground = [System.Windows.Media.Brushes]::Salmon
            }
        }
    }.GetNewClosure())

    try {
        $script:process.Start() | Out-Null
        $timer.Start()
    } catch {
        $txtOutput.Text = "Failed to start robocopy: $_"
        $lblStatus.Text = "Error"
        $lblStatus.Foreground = [System.Windows.Media.Brushes]::Salmon
        $btnRun.IsEnabled = $true
        $btnDryRun.IsEnabled = $true
        $btnStop.IsEnabled = $false
    }
}

$btnRun.Add_Click({ Start-Robocopy })
$btnDryRun.Add_Click({ Start-Robocopy -DryRun })

$btnStop.Add_Click({
    if ($script:process -and -not $script:process.HasExited) {
        $script:process.Kill()
        $lblStatus.Text = "Stopped"
        $lblStatus.Foreground = [System.Windows.Media.Brushes]::Salmon
    }
})

$btnClear.Add_Click({
    $txtOutput.Text = ""
    $lblStatus.Text = ""
})

# Drag & drop support
foreach ($tb in @($txtSource, $txtDest)) {
    $tb.Add_PreviewDragOver({
        param($s, $e)
        if ($e.Data.GetDataPresent([System.Windows.DataFormats]::FileDrop)) {
            $e.Effects = [System.Windows.DragDropEffects]::Copy
            $e.Handled = $true
        }
    })
    $tb.Add_Drop({
        param($s, $e)
        if ($e.Data.GetDataPresent([System.Windows.DataFormats]::FileDrop)) {
            $files = $e.Data.GetData([System.Windows.DataFormats]::FileDrop)
            if ($files.Count -gt 0) {
                $s.Text = $files[0]
            }
        }
    })
}

# Load any marked source from context menu tool
try {
    $regSrc = (Get-ItemProperty -Path "HKCU:\SOFTWARE\RobocopyTool" -Name SourcePath -ErrorAction SilentlyContinue).SourcePath
    if ($regSrc) { $txtSource.Text = $regSrc }
} catch {}

# Initial preview
& $updatePreview

$window.ShowDialog() | Out-Null
