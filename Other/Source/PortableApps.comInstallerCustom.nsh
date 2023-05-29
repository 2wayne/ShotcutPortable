!macro CustomCodePreInstall
	${If} ${FileExists} "$INSTDIR\App\AppInfo\appinfo.ini"
		ReadINIStr $0 "$INSTDIR\App\AppInfo\appinfo.ini" "Version" "PackageVersion"
		${VersionCompare} $0 "23.0.0.0" $R0
		${If} $R0 == 2
			ReadRegStr $1 HKLM "Software\Microsoft\Windows NT\CurrentVersion" "CurrentBuild"
			${If} $1 < 10000 ;Windows 7/8/8.1
				${GetParent} $INSTDIR $1
				CreateDirectory "$1\ShotcutPortableLegacyWin7"
				CopyFiles /SILENT "$INSTDIR\*.*" "$1\ShotcutPortableLegacyWin7"
				WriteINIStr "$1\ShotcutPortableLegacyWin7\App\AppInfo\AppInfo.ini" "Details" "AppID" "ShotcutPortableLegacyWin7"
				WriteINIStr "$1\ShotcutPortableLegacyWin7\App\AppInfo\AppInfo.ini" "Details" "Name" "Shotcut Portable (Legacy Win7)"
			${EndIf}
		${EndIf}
	${EndIf}
!macroend