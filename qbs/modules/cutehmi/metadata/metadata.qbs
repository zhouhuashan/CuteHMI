import qbs
import qbs.File
import qbs.FileInfo
import qbs.Process
import qbs.TextFile
import qbs.Utilities

Module {
	Parameter { property int reqMinor }

	Rule {
		multiplex: true
		inputs: "qbs"
		inputsFromDependencies: "qbs"

		prepare: {
			var json = new JavaScriptCommand();
			json.description = "generating " + product.sourceDirectory + "/cutehmi.metadata.json"
			json.highlight = "codegen";
			json.sourceCode = function() {
				minorMicro = product.version.split('.')
				var metadata = {
					"_comment": "This file has been autogenerated by Qbs cutehmi.metadata module.",
					"id": product.name,
					"name": product.humanName,
					"vendor": product.vendor,
					"description": product.description,
					"author": product.author,
					"copyright": product.copyright,
					"license": product.license,
					"minor": Number(minorMicro[0]),
					"micro": Number(minorMicro[1]),
					"dependencies": []
				}

				for (i in product.dependencies) {
					var dependency = product.dependencies[i]
					if ("cutehmi" in dependency.parameters && "metadata" in dependency.parameters.cutehmi) {
						var metadataDepencency = {
							"name": dependency.name,
							"reqMinor": dependency.parameters.cutehmi.metadata.reqMinor
						}
						metadata.dependencies.push(metadataDepencency)
						if (dependency.version !== undefined)
							if (Number(dependency.version.split('.')[0]) < dependency.parameters.cutehmi.metadata.reqMinor)
								throw "Product '" + product.name + "'"
											  + " requires dependency '" + dependency.name + "'"
											  + " to have minor version number at least '" + dependency.parameters.cutehmi.metadata.reqMinor + "'"
											  + ", while dependency has minor version number '" + Number(dependency.version.split('.')[0]) + "'."
					}
				}

				var f = new TextFile(product.sourceDirectory + "/cutehmi.metadata.json", TextFile.WriteOnly);
				try {
					f.write(JSON.stringify(metadata))
				} finally {
					f.close()
				}
			}
			return [json]
		}

		Artifact {
			filePath: product.sourceDirectory + "/cutehmi.metadata.json"
			fileTags: ["cutehmi.metadata"]
		}
	}
}