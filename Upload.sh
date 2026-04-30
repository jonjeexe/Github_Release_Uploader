#!/bin/bash
# this script is belong to Crave.io and modified by @Jonjeexe

RELEASETAG=$1
REPONAME=$2
RELEASETITLE=$3

IMG_FILES=""
ZIP_FILES=""

# Check if token.txt exists
if [ ! -f token.txt ]; then
    echo "token.txt doesn't exist!"
    echo "Create token.txt with your GitHub Personal Access Token"
    exit 1
fi

# Check if gh is installed
if ! command -v gh &> /dev/null; then
    echo "gh could not be found. Installing gh..."
    curl -sS https://webi.sh/gh | sh
    source ~/.config/envman/PATH.env
    echo "gh installed."
fi

# Set Upload Limit if not already set
: ${GH_UPLOAD_LIMIT:=2147483648}
echo "Upload Limit is set to $GH_UPLOAD_LIMIT"

# Authenticate against github.com
gh auth login --with-token < token.txt

# Scan for IMG files in current directory
for img_file in *.img; do
    if [[ -f "$img_file" && $(stat -c%s "$img_file") -le $GH_UPLOAD_LIMIT ]]; then
        IMG_FILES+="$img_file "
        echo "Selecting $img_file for Upload"
    else
        [ -f "$img_file" ] && echo "Skipping $img_file (too large or not found)"
    fi
done

# Scan for ZIP files in current directory
if ls *.zip &> /dev/null; then
    for zip_file in *.zip; do
        if [[ $(stat -c%s "$zip_file") -le $GH_UPLOAD_LIMIT ]]; then
            ZIP_FILES+="$zip_file "
            echo "• Selecting $zip_file for Upload"
        else
            echo "- Skipping $zip_file (too large)"
        fi
    done
else
    echo "! No zip files found in current directory"
fi

# Create release and upload
echo "# Creating release: $RELEASETAG"
gh release create "$RELEASETAG" --repo "$REPONAME" --title "$RELEASETITLE" --generate-notes

echo "Uploading files..."
if [ -n "$ZIP_FILES" ] || [ -n "$IMG_FILES" ]; then
    gh release upload "$RELEASETAG" --repo "$REPONAME" $ZIP_FILES $IMG_FILES
    echo "✅ Upload complete !"
else
    echo "! No files to upload"
fi