local awsbuilder = import '.drone/awsbuilders.jsonnet';
local buildBase = import '.drone/buildBase.jsonnet';
local buildManifest = import '.drone/buildManifest.jsonnet';
local buildMain = import '.drone/buildMain.jsonnet';

[
	awsbuilder['poweron'],
	buildBase.os4_gcc11_adtools.amd64,
	// buildBase.os4_gcc11_adtools.arm64,
	// buildManifest.os4_base_gcc11_adtools,
	// buildBase.os4_gcc11_afxgroup.amd64,
	// buildBase.os4_gcc11_afxgroup.arm64,
	// buildManifest.os4_gcc11_afxgroup,

	// buildMain.os4_gcc11_adtools.amd64,
	// buildMain.os4_gcc11_adtools.arm64,
	// buildManifest.os4_gcc11_adtools,
	// buildMain.os4_gcc11_afxgroup.amd64,
	// buildMain.os4_gcc11_afxgroup.arm64,
	// buildManifest.os4_gcc11_afxgroup,

	// buildBase.os4_gcc8_adtools.amd64,
	// buildBase.os4_gcc8_adtools.arm64,
	// buildManifest.os4_base_gcc8_adtools,
	// buildBase.os4_gcc8_afxgroup.amd64,
	// buildBase.os4_gcc8_afxgroup.arm64,
	// buildManifest.os4_gcc8_afxgroup,

	// buildMain.os4_gcc8_adtools.amd64,
	// buildMain.os4_gcc8_adtools.arm64,
	// buildManifest.os4_gcc8_adtools,
	// buildMain.os4_gcc8_afxgroup.amd64,
	// buildMain.os4_gcc8_afxgroup.arm64,
	// buildManifest.os4_gcc8_afxgroup,
]
