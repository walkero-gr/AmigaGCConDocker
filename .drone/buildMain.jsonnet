local buildMain(_arch='amd64', _clib2_repo='adtools', _os='os4', _gcc=11) = 
	local _name = _os + '-gcc' + _gcc + '-' + _clib2_repo + '-' + _arch;
	{
		"kind": 'pipeline',
		"type": 'docker',
		"name": 'build-' + _name,
		"platform": {
			"arch": _arch,
			"os": 'linux'
		},
		"steps": [
			{
				"name": 'build-main',
				"pull": 'always',
				"image": 'plugins/docker',
				"settings": {
					"repo": 'walkero/amigagccondocker',
					"tags": [
						_name
					],
					"cache_from": [
						'walkero/amigagccondocker:' + _name
					],
					"dockerfile": 'os4.Dockerfile',
					// "purge": true,
					// "dry_run": true,
					"compress": true,
					"build_args": [
						'OS=' + _os,
						'CLIB2_REPO=' + _clib2_repo,
						'GCC_VER=' + _gcc
					],
					"username": {
						"from_secret": 'DOCKERHUB_USERNAME'
					},
					"password": {
						"from_secret": 'DOCKERHUB_PASSWORD'
					},
				}
			},
			{
				"name": 'test-main',
				"image": 'walkero/amigagccondocker:' + _name,
				"commands": [
					'cd tests/os4',
					'su amidev',
					'ppc-amigaos-gcc -o test test.c',
					'ppc-amigaos-g++ -athread=native test2.c -o test2',
					'ppc-amigaos-gcc -gstabs -athread=native sdl_example.c -o sdl_example -I${SDL2_INC} -L${SDL2_LIB} -lSDL2 -lpthread',
					'ppc-amigaos-gcc -D__USE_INLINE__ httpget.c -o httpget',
					'cd /opt/sdk/ppc-amigaos/Examples/GUI/Window/',
					'ppc-amigaos-gcc -o Window Window.c -lauto',
					'ppc-amigaos-gcc -o WindowPopup WindowPopup.c -lauto',
					'ppc-amigaos-gcc -o AppWindow AppWindow.c -lauto',
				],
				"depends_on": [
					'build-main'
				]
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
			'awsbuilders-poweron'
		],
		"node": {
			"agents": 'awsbuilders'
		}
	};

{
	os4: {
		gcc11: {
			adtools: {
				amd64: buildMain('amd64', 'adtools', 'os4', 11),
				arm64: buildMain('arm64', 'adtools', 'os4', 11)
			},
			afxgroup: {
				amd64: buildMain('amd64', 'afxgroup', 'os4', 11),
				arm64: buildMain('arm64', 'afxgroup', 'os4', 11)
			}
		},
		gcc8: {
			adtools: {
				amd64: buildMain('amd64', 'adtools', 'os4', 8),
				arm64: buildMain('arm64', 'adtools', 'os4', 8)
			},
			afxgroup: {
				amd64: buildMain('amd64', 'afxgroup', 'os4', 8),
				arm64: buildMain('arm64', 'afxgroup', 'os4', 8)
			}
		}
	}
}