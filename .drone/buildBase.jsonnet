local buildBase(_arch='amd64', _clib2_repo='adtools', _clib2_src='git', _os='os4', _gcc=11) = {
	"kind": 'pipeline',
	"type": 'docker',
	"name": 'build-' + _os + '-base-gcc' + _gcc + '-' + _clib2_repo + '-' + _arch,
	"platform": {
		"arch": _arch,
		"os": 'linux'
	},
	"steps": [
		{
			"name": 'build-base',
			"pull": 'always',
			"image": 'plugins/docker',
			"settings": {
				"repo": 'walkero/amigagccondocker',
				"tags": [
					_os + '-base-gcc' + _gcc + '-' + _clib2_repo + '-' + _arch
				],
				"cache_from": [
					'walkero/amigagccondocker:' + _os + '-base-gcc' + _gcc + '-' + _clib2_repo + '-' + _arch
				],
				"dockerfile": 'base/os4/Dockerfile',
				"context": 'base/os4',
				"purge": true,
				"compress": true,
				"build_args": [
					'OS=' + _os,
					'CLIB2_REPO=' + _clib2_repo,
					'CLIB2_SRC=' + _clib2_src,
					'GCC_VER=' + _gcc,
					'FILES_PATH=./files'
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
		},
		"ref": {
			"include": [
				'base-*'
			]
		}
	},
	"depends_on": [
		'awsbuilders-poweron'
	],
	"node": {
		"agents": 'awsbuilders'
	}
};

{
	amd64_os4_gcc11_adtools: buildBase('amd64', 'adtools', 'git', 'os4', 11),
	arm64_os4_gcc11_adtools: buildBase('arm64', 'adtools', 'git', 'os4', 11),
	amd64_os4_gcc11_afxgroup: buildBase('amd64', 'afxgroup', 'git', 'os4', 11),
	arm64_os4_gcc11_afxgroup: buildBase('arm64', 'afxgroup', 'git', 'os4', 11)
}