local awsbuilder = import '.drone/awsbuilders.jsonnet';
local buildBase = import '.drone/buildBase.jsonnet';
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
	
	// GCC 11 for OS4 with afxgroup clib2
	buildBase.os4.gcc11.afxgroup.amd64,
	buildBase.os4.gcc11.afxgroup.arm64,
	buildManifest.os4.gcc11.afxgroup.base,

	buildMain.os4.gcc11.afxgroup.amd64,
	buildMain.os4.gcc11.afxgroup.arm64,
	buildManifest.os4.gcc11.afxgroup.full,

	// GCC 8 for OS4 with adtools clib2
	buildBase.os4.gcc8.adtools.amd64,
	buildBase.os4.gcc8.adtools.arm64,
	buildManifest.os4.gcc8.adtools.base,

	buildMain.os4.gcc8.adtools.amd64,
	buildMain.os4.gcc8.adtools.arm64,
	buildManifest.os4.gcc8.adtools.full,
	
	// GCC 8 for OS4 with afxgroup clib2
	buildBase.os4.gcc8.afxgroup.amd64,
	buildBase.os4.gcc8.afxgroup.arm64,
	buildManifest.os4.gcc8.afxgroup.base,

	buildMain.os4.gcc8.afxgroup.amd64,
	buildMain.os4.gcc8.afxgroup.arm64,
	buildManifest.os4.gcc8.afxgroup.full,
]
