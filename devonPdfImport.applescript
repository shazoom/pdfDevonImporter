tell application "Keyboard Maestro Engine"
	set mPath to get value of variable "arg"
end tell
tell application "DEVONthink Pro"
	set visState to false
	try
		tell application "System Events" to set visState to get visible of process "DEVONthink Pro"
	end try
	launch
	if visState = false then
		tell application "System Events" to set visible of process "DEVONthink Pro" to false
	end if
	if incoming group exists then
		import mPath to incoming group
	else
		import mPath
	end if
end tell

