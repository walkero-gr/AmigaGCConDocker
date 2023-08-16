local awsbuilder = import '.drone/awsbuilders.jsonnet';
local buildBase = import '.drone/buildBase.jsonnet';
local buildManifest = import '.drone/buildManifest.jsonnet';
local buildMain = import '.drone/buildMain.jsonnet';

[
	awsbuilder['poweron'],
	// buildBase.amd64_os4_gcc11_adtools,
	// buildBase.arm64_os4_gcc11_adtools,
	// buildManifest.os4_base_gcc11_adtools,
	// buildBase.amd64_os4_gcc11_afxgroup,
	// buildBase.arm64_os4_gcc11_afxgroup,
	// buildManifest.os4_gcc11_afxgroup,

	buildMain.os4_gcc11_adtools.amd64,
	buildMain.os4_gcc11_adtools.arm64,
	buildManifest.os4_gcc11_adtools,
	buildMain.os4_gcc11_afxgroup.amd64,
	buildMain.os4_gcc11_afxgroup.arm64,
	buildManifest.os4_gcc11_afxgroup,
]
