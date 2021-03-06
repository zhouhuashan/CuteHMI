import qbs

import cutehmi

cutehmi.QMLExtension {
	name: "CuteHMI.LockScreen"

	major: 1

	minor: 0

	micro: 0

	vendor: "CuteHMI"

	friendlyName: "Lock Screen QML"

	description: "QML components, which allow to set up screen locking."

	author: "Wojciech Zygmuntowicz, Michal Policht"

	copyright: "Wojciech Zygmuntowicz, Michal Policht"

	license: "Mozilla Public License, v. 2.0"

	files: [
        "ChangePasswordWizard.qml",
        "KeyButton.qml",
        "LockScreen.qml",
        "LockScreenPopup.qml",
        "LockScreenSettings.qml",
        "qmldir",
        "src/CuteHMILockScreenQMLPlugin.cpp",
        "src/CuteHMILockScreenQMLPlugin.hpp",
        "src/cutehmi/lockscreen/qml/Auth.cpp",
        "src/cutehmi/lockscreen/qml/Auth.hpp",
        "src/cutehmi/lockscreen/qml/Settings.cpp",
        "src/cutehmi/lockscreen/qml/Settings.hpp",
    ]

	Depends { name: "Qt.core" }
	Depends { name: "Qt.qml" }
}

