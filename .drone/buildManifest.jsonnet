local buildManifest(_clib2_repo='adtools', _os='os4', _gcc=11) = {
	"kind": 'pipeline',
	"type": 'docker',
	"name": 'build-manifest-' + _os + '-base-gcc' + _gcc + '-' + _clib2_repo,
	"steps": [
		{
			"name": 'build-manifest',
			"pull": 'always',
			"image": 'plugins/manifest',
			"settings": {
				"target": 'walkero/amigagccondocker:' + _os + '-base-gcc' + _gcc + '-' + _clib2_repo,
				"template": 'walkero/amigagccondocker:' + _os + '-base-gcc' + _gcc + '-' + _clib2_repo + '-ARCH',
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
		'build-' + _os + '-base-gcc' + _gcc + '-' + _clib2_repo + '-amd64',
		'build-' + _os + '-base-gcc' + _gcc + '-' + _clib2_repo + '-arm64'
	]
};

{
	os4_gcc11_adtools: buildManifest('adtools', 'os4', 11),
	os4_gcc11_afxgroup: buildManifest('afxgroup', 'os4', 11)
}