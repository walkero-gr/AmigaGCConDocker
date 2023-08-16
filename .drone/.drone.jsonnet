local awsbuilder = import '.drone/awsbuilders.jsonnet';
local buildBase = import '.drone/buildBase.jsonnet';
local buildManifest = import '.drone/buildManifest.jsonnet';

[
	awsbuilder['poweron'],
	buildBase.amd64_os4_gcc11,
	// buildBase.arm64_os4_gcc11,
	// buildManifest.os4_gcc11,
	// buildBase.amd64_os4_gcc11_afxgroup,
	// buildBase.arm64_os4_gcc11_afxgroup,
	// buildManifest.os4_gcc11_afxgroup,
]
