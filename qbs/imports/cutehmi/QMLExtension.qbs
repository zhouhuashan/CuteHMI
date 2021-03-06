import qbs
import qbs.FileInfo

import "CommonProduct.qbs" as CommonProduct

CommonProduct {
	type: "dynamiclibrary"

	targetName: baseName + "_" + major + (qbs.buildVariant.contains("debug") ? "d" : "")

	baseName: name.toLowerCase().replace(/\./g, '_') + "_qml"

	property string installDir: FileInfo.relativePath(project.sourceDirectory, sourceDirectory)

	property stringList qmlImportPaths: [qbs.installRoot + "/" + cutehmi.dirs.qmlExtensionInstallDir]	// QML import paths for QtCreator.

	Properties {
		condition: qbs.targetOS.contains("linux")
		targetName: baseName + "_" + major
	}

	Depends { name: "cutehmi.metadata" }
	Depends { name: "cutehmi.dirs" }
	Depends { name: "cutehmi.qmltypes" }

	Depends { name: "cpp" }

	FileTagger {
		patterns: "*.qml"
		fileTags: ["qml"]
	}

	FileTagger {
		patterns: "*.js"
		fileTags: ["js"]
	}

	FileTagger {
		patterns: "qmldir"
		fileTags: ["qmldir"]
	}

	FileTagger {
		patterns: "*.qmltypes"
		fileTags: ["qmltypes"]
	}

	FileTagger {
		patterns: "*.metainfo"
		fileTags: ["metainfo"]
	}

	Group {
		name: "Library"
		fileTagsFilter: "dynamiclibrary"
		qbs.install: true
		qbs.installDir: installDir + "/" + cutehmi.dirs.qmlPluginInstallDir
	}

	Group {
		name: "QML"
		fileTagsFilter: ["qml", "js", "qmldir", "qmltypes", "metainfo"]
		qbs.install: true
		qbs.installSourceBase: sourceDirectory
		qbs.installDir: installDir
	}	
}
