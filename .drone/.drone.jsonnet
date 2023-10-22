local awsbuilder = import '.drone/awsbuilders.jsonnet';
local buildBase = import '.drone/buildBase.jsonnet';
local buildBaseExp = import '.drone/buildBaseExp.jsonnet';
local buildManifest = import '.drone/buildManifest.jsonnet';
local buildMain = import '.drone/buildMain.jsonnet';

[
	awsbuilder['poweron'],

	// GCC 11 for OS4 with adtools clib2
	buildBase.os4.gcc11.adtools.amd64,
	buildBase.os4.gcc11.adtools.arm64,
	buildManifest.os4.gcc11.adtools.base,

	buildMain.os4.gcc11.adtools.amd64,
	buildMain.os4.gcc11.adtools.arm64,
	buildManifest.os4.gcc11.adtools.full,
	
	// Experimental GCC 11 for OS4 with clib4
	buildBaseExp.os4.gcc11.exp.amd64,
	buildBaseExp.os4.gcc11.exp.arm64,
	buildManifest.os4.gcc11.exp.base,

	buildMain.os4.gcc11.exp.amd64,
	buildMain.os4.gcc11.exp.arm64,
	buildManifest.os4.gcc11.exp.full,

	// GCC 8 for OS4 with adtools clib2
	buildBase.os4.gcc8.adtools.amd64,
	buildBase.os4.gcc8.adtools.arm64,
	buildManifest.os4.gcc8.adtools.base,

	buildMain.os4.gcc8.adtools.amd64,
	buildMain.os4.gcc8.adtools.arm64,
	buildManifest.os4.gcc8.adtools.full,
]
