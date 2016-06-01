on getMetaData(pdf_path)
	set results to {}
	set attributes to {"kMDItemFSName", "kMDItemAuthors", "kMDItemEncodingApplications", "kMDItemCreator", "kMDItemTitle", "kMDItemDescription", "kMDItemContentCreationDate", "kMDItemKeywords"}
	tell application "Finder"
		-- Removes lines containing only: ( or )
		-- Removes leading white space and "
		-- Removes trailing " and comma
		-- Doubly impossible to read; contains lots of extra escaping for AppleScript 😁
		set mSedCmd to "sed -E '/^[ \\t]*\\([ \\t]*$/d' | sed -E '/^\\s*)\\s*$/d' | sed -E 's/^[ \\t]*\"?//' | sed -E 's/\"?,?$//'"
		repeat with i from 1 to number of items in attributes
			set attr to item i of attributes as string
			set mCmd to "/usr/bin/mdls -name " & attr & " -raw -nullMarker None " & quoted form of pdf_path
			set mParas to paragraphs of (do shell script mCmd)
			set value to ""
			set mParasCount to number of items in mParas
			repeat with i from 1 to mParasCount
				set mPara to item i of mParas
				set mLine to (do shell script "echo '" & mPara & "'|" & mSedCmd)
				if mLine ≠ "" and i < mParasCount then
					set value to value & mLine & ", "
				else if mLine ≠ "" then
					set value to value & mLine
				end if
			end repeat
			set end of results to value
		end repeat
	end tell
	set metaData to {filename:item 1 of results, author:item 2 of results, producer:item 3 of results, creator:item 4 of results, title:item 5 of results, mDescription:item 6 of results, mDate:item 7 of results, keywords:item 8 of results}
	return metaData
end getMetaData

on setKMParams(params)
	repeat with i from 1 to number of items in params
		set pair to item i of params
		set varName to item 1 of pair
		set varValue to item 2 of pair
		tell application "Keyboard Maestro Engine"
			setvariable varName to varValue
		end tell
	end repeat
end setKMParams

tell application "Keyboard Maestro Engine"
	set mPath to get value of variable "arg"
end tell

set md to getMetaData(mPath)

set params to {{"Description", mDescription of md}, {"Filename", filename of md}, {"Author", author of md}, {"Producer", producer of md}, {"Creator", creator of md}, {"Title", title of md}, {"Date", mDate of md}, {"Keywords", keywords of md}}
setKMParams(params)