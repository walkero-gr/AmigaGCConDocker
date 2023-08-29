local buildManifest(_clib2_repo='adtools', _os='os4', _base='', _gcc=11) = 
	local _name = _os + '-' + _base + 'gcc' + _gcc + '-' + _clib2_repo;
	{
		"kind": 'pipeline',
		"type": 'docker',
		"name": 'build-manifest-' + _name,
		"steps": [
			{
				"name": 'build-manifest',
				"pull": 'always',
				"image": 'plugins/manifest',
				"settings": {
					"target": 'walkero/amigagccondocker:' + _name,
					"template": 'walkero/amigagccondocker:' + _name + '-ARCH',
					"platforms": [
						'linux/amd64',
						'linux/arm64'
					],
					"username": {
						"from_secret": 'DOCKERHUB_USERNAME'
					},
					"password": {
						"from_secret": 'DOCKERHUB_PASSWORD'
					},
				}
			}
		],
		"trigger": {
			"branch": {
				"include": [
					'master',
					'main'
				]
			},
			"event": {
				"include": [
					'push'
				]
			}
		},
		"depends_on": [
			'build-' + _name + '-amd64',
			'build-' + _name + '-arm64'
		]
	};

{
	os4_base_gcc11_adtools: buildManifest('adtools', 'os4', 'base-', 11),
	os4_base_gcc11_afxgroup: buildManifest('afxgroup', 'os4', 'base-', 11),
	os4_gcc11_adtools: buildManifest('adtools', 'os4', '', 11),
	os4_gcc11_afxgroup: buildManifest('afxgroup', 'os4', '', 11),

	os4_base_gcc8_adtools: buildManifest('adtools', 'os4', 'base-', 8),
	os4_base_gcc8_afxgroup: buildManifest('afxgroup', 'os4', 'base-', 8),
	os4_gcc8_adtools: buildManifest('adtools', 'os4', '', 8),
	os4_gcc8_afxgroup: buildManifest('afxgroup', 'os4', '', 8),
}