on setKMParams(params)	repeat with pair in params		set varName to item 1 of pair		set varValue to item 2 of pair		tell application "Keyboard Maestro Engine"			setvariable varName to varValue		end tell	end repeatend setKMParamson processMetaData(metaData)	set splitData to paragraphs of metaData	set noOfItems to count splitData	set params to {}	repeat with i from 1 to noOfItems		if i mod 2 = 0 then			set mValue to item i of splitData			set end of params to {mKey, mValue}		else			set mKey to item i of splitData		end if	end repeat	return paramsend processMetaDatatell application "Keyboard Maestro Engine"	set metaData to get value of variable "rawMetaData"end telllog metaDatasetKMParams(processMetaData(metaData))return 0