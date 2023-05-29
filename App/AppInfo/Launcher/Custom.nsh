${SegmentFile}

${Segment.OnInit}
	${registry::Read} "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" "CurrentBuild" $0 $1

	${If} $0 < 10000 ;earlier than Windows 10
		StrCpy $AppName "Shotcut"
		${If} ${IsWin2000}
			StrCpy $1 2000
		${ElseIf} ${IsWinXP}
			StrCpy $1 XP
		${ElseIf} ${IsWin2003}
			StrCpy $1 2003
		${ElseIf} ${IsWinVista}
			StrCpy $1 Vista
		${ElseIf} ${IsWin2008}
			StrCpy $1 2008
		${ElseIf} ${IsWin7}
			StrCpy $1 7
		${ElseIf} ${IsWin2008R2}
			StrCpy $1 "2008 R2"
		${ElseIf} ${IsWin8}
			StrCpy $1 8
		${ElseIf} ${IsWin2012}
			StrCpy $1 2012
		${Else}
			StrCpy $1 "Pre-Win10"
		${EndIf}	
		StrCpy $0 "10"
		MessageBox MB_OK "$(LauncherIncompatibleMinOS)"
		Abort
	${EndIf}
!macroend

${SegmentInit}
	ExpandEnvStrings $1 "%PortableApps.comDocuments%"
	${If} $1 == ""
	${OrIfNot} ${FileExists} "$1\*.*"
		${GetParent} $EXEDIR $3
		${GetParent} $3 $1
		${If} $1 == "" ;Be sure we didn't just GetParent on Root
			StrCpy $1 $3
		${EndIf}
		${If} ${FileExists} "$1\Documents\*.*"
			StrCpy $2 "$1\Documents"
		${Else}
			${GetRoot} $EXEDIR $1
			${If} ${FileExists} "$1\Documents\*.*"
				StrCpy $2 "$1\Documents"
			${Else}
				StrCpy $2 "$1"
			${EndIf}
		${EndIf}
		System::Call 'Kernel32::SetEnvironmentVariable(t, t) i("PortableApps.comDocuments", "$2").r0'
	${EndIf}
	
	ExpandEnvStrings $1 "%PortableApps.comVideos%"
	${If} $1 == ""
	${OrIfNot} ${FileExists} "$1\*.*"
		ExpandEnvStrings $1 "%PortableApps.comDocuments%"
		${If} ${FileExists} "$1\Videos\*.*"
			StrCpy $2 "$1\Videos"
		${Else}
			${GetParent} $EXEDIR $3
			${GetParent} $3 $1
			${If} $1 == "" ;Be sure we didn't just GetParent on Root
				StrCpy $1 $3
			${EndIf}
			${If} ${FileExists} "$1\Videos\*.*"
				StrCpy $2 "$1\Videos"
			${Else}
				${GetRoot} $EXEDIR $1
				${If} ${FileExists} "$1\Videos\*.*"
					StrCpy $2 "$1\Videos"
				${Else}
					StrCpy $2 "$1"
				${EndIf}
			${EndIf}
		${EndIf}
		System::Call 'Kernel32::SetEnvironmentVariable(t, t) i("PortableApps.comVideos", "$2").r0'
	${EndIf}
	
	ExpandEnvStrings $2 "%PortableApps.comVideos%"
	StrLen $0 $2
	${If} $0 == 2
		StrCpy $2 "$2\"
	${EndIf}
	${WordReplace} $2 "\" "/" "+" $2
	System::Call 'Kernel32::SetEnvironmentVariable(t, t) i("CustomPortableApps.comVideosForwardSlash", "$2").r0'
!macroend
