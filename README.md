## Github Release Uploader
<p>Script that help you to push your output into your GitHub repo release using github personal access token.</p><br>

## Requirements
1. Fine-grained Github Personal Access Token (Recommended)
2. Create github repo to push output files
<br>

## Create Github Personal Access Token
1. Navigate to Settings:
2. Click your profile picture in the top-right corner of any GitHub page and select Settings.
3. Open Developer Settings:
4. Scroll down the left sidebar and click Developer settings.
5. Create Token:
6. Select Personal access tokens > Fine-grained tokens and click Generate new token.

- Configure Details:
Enter a Token name and select an Expiration date.
Under Repository access, select Only select repositories and choose the repo you want to push releases to.

- Set Permissions:
Go to Repository permissions.
Find Contents and set the access to Read and write. This is required for creating and managing releases and tags.

- Optional: If your release process modifies GitHub Actions, grant Workflows write access.

- Generate and Save: Click Generate token. Copy the token immediately; you will not be able to see it again.


---
<br>

### Download Script

```
curl -O https://raw.githubusercontent.com/jonjeexe/Github_Release_Uploader/refs/heads/main/Upload.sh && chmod +x Upload.sh
```
<br>

### Run with only 3 parameters 

** Before executing script create a `token.txt` and past `Github personal access token` in token.txt which you created in previous steps.

```
./upload.sh "tag" "repo url" "Release title" 
```

<br>
<h5>Example:-</h5>

`./upload.sh "v1.0.0" "jonjeexe/Local_Manifests_Eclipse" "First Release"`

---
<br>

### For Crave.io devspace CLI
Manual Method How to pull output to Devspace CLI
Simply use the crave pull command inside the same directory as before

1. Pull zip of your build
```
crave pull out/target/product/*/*.zip
```

2. Pull img of your build
```
crave pull out/target/product/*/*.img
```

3. Then enter into output folder
```
cd <codename>
```

then follow previous steps download script create a github personal access token and past into token.txt and run Upload.sh from the dir where is ur build zip.

thank you i hope it help you ♡
