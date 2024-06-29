# Load Windows Forms assembly
Add-Type -AssemblyName System.Windows.Forms

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Form Input"
$form.Size = New-Object System.Drawing.Size(350, 500)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
$form.MaximizeBox = $false
$form.BackColor = [System.Drawing.Color]::White

# Create a panel for custom background
$panel = New-Object System.Windows.Forms.Panel
$panel.Size = New-Object System.Drawing.Size($form.ClientSize.Width, $form.ClientSize.Height)
$panel.Location = New-Object System.Drawing.Point(0, 0)
$form.Controls.Add($panel)

# Create a graphics object to draw custom background
$panel.Add_Paint({
    param (
        [System.Object] $sender,
        [System.Windows.Forms.PaintEventArgs] $e
    )
    $graphics = $e.Graphics

    # Draw custom shapes with colors
    $brush1 = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(142, 79, 39))
    $brush2 = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 144, 44))
    
    # Drawing overlapping circles to form the shapes
    #graphics.FillEllipse(colour, X, Y, Width, Height)
    #$graphics.FillEllipse($brush1, -150, -178, 300, 300)
    #$graphics.FillEllipse($brush1, -35, -208, 300, 300)
    #$graphics.FillEllipse($brush1, 100, -236, 300, 300)

    
    $graphics.FillEllipse($brush1, 30, -300, 400, 400)
    $graphics.FillEllipse($brush1, -100, -226, 300, 300)

    $graphics.FillEllipse($brush1, 30, 388, 400, 400)
    $graphics.FillEllipse($brush1, -100, 416, 300, 300)

    # Drawing a circle for the button background
    $graphics.FillEllipse($brush2, 138, 381, 57, 57)
})

# Create the title label
$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Text = "Welcome Back Master"
$titleLabel.Size = New-Object System.Drawing.Size(300, 50)
$titleLabel.Font = New-Object System.Drawing.Font("Arial", 20, [System.Drawing.FontStyle]::Bold)
$titleLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleLeft
$titleLabel.ForeColor = [System.Drawing.Color]::White
$titleLabel.BackColor = [System.Drawing.Color]::Transparent
$titleLabel.Location = New-Object System.Drawing.Point(25, 25)

$watermarkLabel = New-Object System.Windows.Forms.Label
$watermarkLabel.Text = "discord: @semestaalam"
$watermarkLabel.Size = New-Object System.Drawing.Size(300, 50)
$watermarkLabel.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
$watermarkLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleLeft
$watermarkLabel.ForeColor = [System.Drawing.Color]::Black
$watermarkLabel.BackColor = [System.Drawing.Color]::Transparent
$watermarkLabel.Location = New-Object System.Drawing.Point(180, 425)

$panel.Controls.Add($watermarkLabel)
$panel.Controls.Add($titleLabel)


$labels = @("Script Code", "Many License", "Time (Days)")
$textboxes = @()
for ($i = 0; $i -lt $labels.Length; $i++) {
    $label = New-Object System.Windows.Forms.Label
    $label.Text = $labels[$i]
    $label.Size = New-Object System.Drawing.Size(300, 20)
    $label.Font = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Bold)
    $label.ForeColor = [System.Drawing.Color]::Black
    $label.BackColor = [System.Drawing.Color]::Transparent
    $label.Location = New-Object System.Drawing.Point(25, (120 + 60 * $i))
    $panel.Controls.Add($label)

    $textbox = New-Object System.Windows.Forms.TextBox
    $textbox.Size = New-Object System.Drawing.Size(250, 30)
    $textbox.Location = New-Object System.Drawing.Point(25, (140 + 60 * $i))
    $textbox.Font = New-Object System.Drawing.Font("Arial", 12)
    $textbox.BackColor = [System.Drawing.Color]::FromArgb(200, 200, 200)
    $textbox.BorderStyle = [System.Windows.Forms.BorderStyle]::None
    #if ($labels[$i] -eq "Password" -or $labels[$i] -eq "Confirm Password") {
    #    $textbox.PasswordChar = '*'
    #}
    $panel.Controls.Add($textbox)
    $textboxes += $textbox
}

# Create a custom button for sign in
$buttonPanel = New-Object System.Windows.Forms.Panel
$buttonPanel.Size = New-Object System.Drawing.Size(60, 60)
$buttonPanel.Location = New-Object System.Drawing.Point((($form.ClientSize.Width - $buttonPanel.Width) / 2), 380)
$buttonPanel.BackColor = [System.Drawing.Color]::Transparent
$buttonPanel.BorderStyle = [System.Windows.Forms.BorderStyle]::None
$panel.Controls.Add($buttonPanel)

$nextButton = New-Object System.Windows.Forms.Button
$nextButton.Size = New-Object System.Drawing.Size(40, 40)
$nextButton.Location = New-Object System.Drawing.Point(10, 10)
$nextButton.BackColor = [System.Drawing.Color]::FromArgb(255, 144, 44)
$nextButton.ForeColor = [System.Drawing.Color]::White
$nextButton.Font = New-Object System.Drawing.Font("Arial", 12)
$nextButton.Text = "→"
$nextButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$nextButton.FlatAppearance.BorderSize = 0
$buttonPanel.Controls.Add($nextButton)

# Add button click event
$nextButton.Add_Click({
    $inputValues = @{}
    for ($i = 0; $i -lt $textboxes.Length; $i++) {
        $inputValues[$labels[$i]] = $textboxes[$i].Text
    }
    $json = $inputValues | ConvertTo-Json
    
    # Generate a random file name
    $fileName = [System.IO.Path]::GetRandomFileName() -replace '\.tmp$', '.json'
    $filePath = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), $fileName)
    
    # Save the JSON content to the file
    Set-Content -Path $filePath -Value $json
    
    # Hide the file
    [System.IO.File]::SetAttributes($filePath, [System.IO.FileAttributes]::Hidden)
    
    [System.Windows.Forms.MessageBox]::Show("Data telah disimpan ke file: " + $filePath)
})

# Show the form
$form.Add_Shown({$form.Activate()})
[System.Windows.Forms.Application]::Run($form)
