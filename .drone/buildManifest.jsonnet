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
	os4: {
		gcc11: {
			adtools: {
				base: buildManifest('adtools', 'os4', 'base-', 11),
				full: buildManifest('adtools', 'os4', '', 11)
			},
			afxgroup: {
				base: buildManifest('afxgroup', 'os4', 'base-', 11),
				full: buildManifest('afxgroup', 'os4', '', 11)
			}
		},
		gcc8: {
			adtools: {
				base: buildManifest('adtools', 'os4', 'base-', 8),
				full: buildManifest('adtools', 'os4', '', 8)
			},
			afxgroup: {
				base: buildManifest('afxgroup', 'os4', 'base-', 8),
				full: buildManifest('afxgroup', 'os4', '', 8)
			}
		}
	}
}