param(
    [string]$Tag = "v1.0",
    [string]$Title = "Release $Tag",
    [string]$Notes = "Automated release for $Tag"
)

# Navigate to repo folder
cd C:\Users\Administrator\azure-cleanup-scripts

# Create tag if missing
if (-not (git tag --list $Tag)) {
    git tag -a $Tag -m "Release $Tag"
    git push origin $Tag
}

# Create GitHub release with attached scripts
gh release create $Tag `
    cleanup-azure.ps1 `
    run-cleanup.ps1 `
    --title $Title `
    --notes $Notes
