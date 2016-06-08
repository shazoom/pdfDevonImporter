on get_db_group_from_km()
	set mImportDbName to missing value
	set mImportGroupName to missing value
	try
		tell application "Keyboard Maestro Engine"
			set mImportDbName to get value of variable "dntp_db"
			set mImportGroupName to get value of variable "dntp_group"
		end tell
	end try
	return {mImportDbName, mImportGroupName}
end get_db_group_from_km

on get_DNtp_db_group(mImportDbName, mImportGroupName)
	tell application id "DNtp"
		set mGroup to missing value
		try
			set mDb to item 1 of (every database whose name = mImportDbName)
		on error number -1719
			return 2
		end try
		
		repeat with mParent in parents of mDb
			if name of mParent as string = mImportGroupName then
				set mGroup to mParent
			end if
		end repeat
	end tell
	return mGroup
end get_DNtp_db_group

try
	set dbgrpNames to get_db_group_from_km()
	set dbName to item 1 of dbgrpNames
	set groupName to item 2 of dbgrpNames
	if dbName = missing value or groupName = missing value then
		return 1
	end if
	
	set mGroup to get_DNtp_db_group(dbName, groupName)
	--set mGroup to item 2 of dbgrp
	if mGroup = missing value then
		return 2
	end if
	
	tell application "Keyboard Maestro Engine"
		set mPath to get value of variable "pdfPath"
	end tell
	
	tell application id "DNtp"
		set visState to false
		try
			tell application "System Events" to set visState to get visible of process "DEVONthink Pro"
		end try
		launch
		if visState = false then
			tell application "System Events" to set visible of process "DEVONthink Pro" to false
		end if
		import mPath to mGroup
	end tell
	
	return 0
on error errMsg number errNum
	display alert errMsg & " - " & errNum
	return 3
end try

