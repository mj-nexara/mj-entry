$folders = @("controllers", "models", "routes", "middleware", "views", "public", "uploads")
foreach ($folder in $folders) {
    New-Item -Path ".\$folder" -ItemType Directory -Force
}
