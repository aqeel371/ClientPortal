In order to create all new projects this is base project you need to fork and rename the project.
# Step 1: Fork the project
fork the existing project repository
`git repo fork https://github.com/aqeel371/GenralProject.git --clone`

# Step 2: Rename the project

- Click on the project you want to rename in the "Project navigator" in the left panel of the Xcode window.

- In the right panel, select the "File inspector", and the name of your project should be found under "Identity and Type". Change it to your new name.
When the dialog asks whether to rename or not rename the project's content items, click "Rename". Say yes to any warning about uncommitted changes.

- At the top middle of the window, to the left of the active device/simulator, there is a scheme for your product under its old name; click & hold on it, then choose "Manage Schemes…".
Click on the old name in the scheme (similar to renaming files in Xcode) and it will become editable; change the name and click "Close".

- Quit Xcode. Rename the master folder that contains all your project files.
- In the correctly-named master folder, beside your newly-named .xcodeproj file, there is probably a wrongly-named OLD folder containing your source files. Rename the OLD folder to your new name. {If you use git you could use git mv oldname newname. Note that when using git mv old new you generally must (i) completely commit all other changes (ii) only then git mv old new (iii) commit that (iv) only then make further changes. If steps i-ii-iii-iv are followed, git will maintain history through the rename.}
- Re-open the project in Xcode. If you see a warning "The folder OLD does not exist", dismiss the warning. The source files in the renamed folder will have red names because the path to them has broken.
- In the "Project navigator" in the left-hand panel, click on the top-level folder representing the OLD folder you renamed.
- In the right-hand panel, under "Identity and Type", change the "Name" field from the OLD name to the new name.
- Just below that field is a "Location" menu. If the full path has not corrected itself, click on the nearby folder icon and choose the renamed folder. You may have to perform this fix for each source file if the links to them remain broken.
- Click on the project in the "Project navigator" on the left, and in the main panel select "Build Settings".
- Search for "plist" in the settings.
- In the Packaging section, you will see fields for Info.plist and Product Bundle Identifier.
- If there is a file name entered in Info.plist, update it (it may have been updated automatically in Step 1).
- Do the same for Product Bundle Identifier, unless it is utilizing the ${PRODUCT_NAME} variable. In that case, search for "product" in the settings and update Product Name. If Product Name is based on ${TARGET_NAME}, click on the actual target item in the TARGETS list on the left of the settings pane and edit it, and all related settings will update immediately.
- Search the settings for "prefix" and ensure that Prefix Header's path is also updated to the new name.
- If you use SwiftUI, search for "Development Assets" and update the path. Enclose in double-quotes ("") quotes if the path contains a space ( ).
- If you have an entitlements file, search for "signing" and update Code Signing Entitlements. Accordingly, rename the actual entitlements file in the Project Navigator also. (Side note: In Xcode 13 entitlements files have a yellow checkmark icon in the Project Navigator; you may have created one if e.g. you use shared containers/App Groups.)
- Repeat step 3 for tests (if you have them)
- Repeat step 3 for core data if its name matches project name (if you have it)
- Clean and rebuild your project
`Command + Shift + K` to clean
`Command + B` to build
Further points.

If the project has storyboards.
- At this stage, open the overall folder simply in the Mac finder. 
- Type the old name in the file text search. You will see that the old name appears very often as customModule="OldName" in all storyboard files.
- These can be fixed, in Xcode, one by one, on each storyboard: Tap on the view controller in the file inspector, and be sure to tap on the actual storyboard in the white column on the left of the actual storyboard panel. 
- Tap on the Identity Inspector (4th small button) in the right hand panel. Look at the Custom Class -> Module field. Notice it seemingly shows NewName in gray. However (still as of Xcode14.2) it is incorrect. 
- Simply tap the drop-down, and explicitly select the new name. (If you now review that storyboard file with a text editor, you will see it is fixed.) You may prefer to change them all just using a plain text editor.

# Step 3: Update remote URL
update the remote url with this command
`git remote set-url origin new.git.url/here`
