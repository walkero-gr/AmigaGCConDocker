pipeline {
	agent any
	environment {
		DOCKERHUB_CREDS=credentials('walkero-dockerhub')
		DOCKERHUB_REPO="walkero/amigagccondocker"
		OS4_GCC_BASE_VER="1.8.0"
		MOS_GCC_BASE_VER="1.0.0"
		M68K_GCC_BASE_VER="1.0.0"
	}
	stages {
		stage('ppc-amigaos') {
			when {
				allOf {
					buildingTag()
					tag pattern: "os4-.*", comparator: "REGEXP"
				}
			}
			stages {
				stage('build-ppc-amigaos-sdk-image') {
					matrix {
						axes {
							axis {
								name 'ARCH'
								values 'amd64', 'arm64'
							}
						}
						agent { label "agent-${ARCH}" }
						stages {
							stage('build') {
								steps {
									sh """
										cd ppc-amigaos
										docker buildx build \
											--no-cache \
											--provenance=false \
											-t ${DOCKERHUB_REPO}:ppc-amigaos-sdk \
											-f Dockerfile.sdk .
									"""
								}
							}
						}
					}
				}
				stage('build-ppc-amigaos-images') {
					environment {
						TAG_VERSION = "${TAG_NAME.replace('os4-', '')}"
					}
					matrix {
						axes {
							axis {
								name 'ARCH'
								values 'amd64', 'arm64'
							}
							axis {
								name 'GCC'
								values '13', '11', '8', '6'
							}
						}
						agent { label "agent-${ARCH}" }
						stages {
							stage('build') {
								options {
									timeout(time: 60, unit: 'MINUTES')
								}
								steps {
									script {
										buildAndPush_os4(GCC, ARCH)
									}
								}
							}
						}
						post {
							always {
								sh """
									docker logout
								"""
							}
						}
					}
				}
				stage('create-ppc-amigaos-manifests') {
					environment {
						TAG_VERSION = "${TAG_NAME.replace('os4-', '')}"
					}
					agent { label "agent-amd64" }
					steps {
						script {
							createAndPushManifests('os4', ['13', '11', '8', '6'])
						}
					}
				}

			}
		}
		stage('ppc-morphos') {
			when {
				allOf {
					buildingTag()
					tag pattern: "mos-.*", comparator: "REGEXP"
				}
			}
			stages {
				stage('build-ppc-morphos-images') {
					environment {
						TAG_VERSION = "${TAG_NAME.replace('mos-', '')}"
					}
					matrix {
						axes {
							axis {
								name 'ARCH'
								values 'amd64', 'arm64'
							}
							axis {
								name 'GCC'
								values '15', '11', '9'
							}
						}
						agent { label "agent-${ARCH}" }
						stages {
							stage('build') {
								options {
									timeout(time: 60, unit: 'MINUTES')
								}
								steps {
									script {
										buildAndPush_mos(GCC, ARCH)
									}
								}
							}
						}
						post {
							always {
								sh """
									docker logout
								"""
							}
						}
					}
				}
				stage('create-ppc-morphos-manifests') {
					environment {
						TAG_VERSION = "${TAG_NAME.replace('mos-', '')}"
					}
					agent { label "agent-amd64" }
					steps {
						script {
							createAndPushManifests('mos', ['15', '11', '9'])
						}
					}
				}
			}
		}
		stage('m68k-amigaos') {
			when {
				allOf {
					buildingTag()
					tag pattern: "m68k-.*", comparator: "REGEXP"
				}
			}
			stages {
				stage('build-m68k-amigaos-sdk-image') {
					matrix {
						axes {
							axis {
								name 'ARCH'
								values 'amd64', 'arm64'
							}
						}
						agent { label "agent-${ARCH}" }
						stages {
							stage('build') {
								steps {
									sh """
										cd m68k-amigaos
										docker buildx build \
											--no-cache \
											--provenance=false \
											-t ${DOCKERHUB_REPO}:m68k-amigaos-sdk \
											-f Dockerfile.sdk .
									"""
								}
							}
						}
					}
				}
				stage('build-m68k-amigaos-images') {
					environment {
						TAG_VERSION = "${TAG_NAME.replace('m68k-', '')}"
					}
					matrix {
						axes {
							axis {
								name 'ARCH'
								values 'amd64', 'arm64'
							}
							axis {
								name 'GCC'
								values '6'
							}
						}
						agent { label "agent-${ARCH}" }
						stages {
							stage('build') {
								options {
									timeout(time: 60, unit: 'MINUTES')
								}
								steps {
									script {
										buildAndPush_m68k(GCC, ARCH)
									}
								}
							}
						}
						post {
							always {
								sh """
									docker logout
								"""
							}
						}
					}
				}
				stage('create-m68k-amigaos-manifests') {
					environment {
						TAG_VERSION = "${TAG_NAME.replace('m68k-', '')}"
					}
					agent { label "agent-amd64" }
					steps {
						script {
							createAndPushManifests('m68k', ['6'])
						}
					}
				}
			}
		}
	}
}

def buildAndPush_os4(gccVer, arch) {
	def imageTagBase = "${env.DOCKERHUB_REPO}:os4-gcc${gccVer}"
	def imageTagVersioned = "${imageTagBase}-${env.TAG_VERSION}-${arch}"
	def imageTagLatest = "${imageTagBase}-${arch}"

	try {
		sh """
			cd ppc-amigaos
			docker buildx build \
				--provenance=false \
				--cache-from ${imageTagLatest} \
				--build-arg BASE_VER=${env.OS4_GCC_BASE_VER} \
				--build-arg GCC_VER=${gccVer} \
				-t ${imageTagVersioned} \
				-t ${imageTagLatest} \
				-f Dockerfile .
		"""
		retry(3) {
			sh """
				echo \$DOCKERHUB_CREDS_PSW | docker login -u \$DOCKERHUB_CREDS_USR --password-stdin
				docker push ${imageTagVersioned}
				docker push ${imageTagLatest}
			"""
		}
	} finally {
		sh 'docker logout'
	}
}

def createAndPushManifests(system, gccVersions) {
	gccVersions.each { gccVer ->
		def imageTagBase = "${env.DOCKERHUB_REPO}:${system}-gcc${gccVer}"
		def imageTagVersioned = "${imageTagBase}-${env.TAG_VERSION}"
		def imageTagLatest = imageTagBase

		sh """
			docker manifest rm ${imageTagVersioned} || true
			docker manifest rm ${imageTagLatest} || true

			docker manifest create \
				--amend ${imageTagVersioned} \
				${imageTagVersioned}-amd64 \
				${imageTagVersioned}-arm64

			docker manifest create \
				--amend ${imageTagLatest} \
				${imageTagLatest}-amd64 \
				${imageTagLatest}-arm64
		"""
	}

	try {
		sh 'echo \$DOCKERHUB_CREDS_PSW | docker login -u \$DOCKERHUB_CREDS_USR --password-stdin'
		gccVersions.each { gccVer ->
			def imageTagBase = "${env.DOCKERHUB_REPO}:${system}-gcc${gccVer}"
			def imageTagVersioned = "${imageTagBase}-${env.TAG_VERSION}"
			def imageTagLatest = imageTagBase

			retry(3) {
				sh """
					docker manifest push ${imageTagVersioned}
					docker manifest push ${imageTagLatest}
				"""
			}
		}
	} finally {
		sh 'docker logout'
	}
}

def buildAndPush_mos(gccVer, arch) {
	def imageTagBase = "${env.DOCKERHUB_REPO}:mos-gcc${gccVer}"
	def imageTagVersioned = "${imageTagBase}-${env.TAG_VERSION}-${arch}"
	def imageTagLatest = "${imageTagBase}-${arch}"

	try {
		sh """
			cd ppc-morphos
			docker buildx build \
				--provenance=false \
				--cache-from ${imageTagLatest} \
				--build-arg BASE_VER=${env.MOS_GCC_BASE_VER} \
				--build-arg GCC_VER=${gccVer} \
				-t ${imageTagVersioned} \
				-t ${imageTagLatest} \
				-f Dockerfile .
		"""
		retry(3) {
			sh """
				echo \$DOCKERHUB_CREDS_PSW | docker login -u \$DOCKERHUB_CREDS_USR --password-stdin
				docker push ${imageTagVersioned}
				docker push ${imageTagLatest}
			"""
		}
	} finally {
		sh 'docker logout'
	}
}

def buildAndPush_m68k(gccVer, arch) {
	def imageTagBase = "${env.DOCKERHUB_REPO}:m68k-gcc${gccVer}"
	def imageTagVersioned = "${imageTagBase}-${env.TAG_VERSION}-${arch}"
	def imageTagLatest = "${imageTagBase}-${arch}"

	try {
		sh """
			cd m68k-amigaos
			docker buildx build \
				--provenance=false \
				--cache-from ${imageTagLatest} \
				--build-arg BASE_VER=${env.M68K_GCC_BASE_VER} \
				--build-arg GCC_VER=${gccVer} \
				-t ${imageTagVersioned} \
				-t ${imageTagLatest} \
				-f Dockerfile .
		"""
		retry(3) {
			sh """
				echo \$DOCKERHUB_CREDS_PSW | docker login -u \$DOCKERHUB_CREDS_USR --password-stdin
				docker push ${imageTagVersioned}
				docker push ${imageTagLatest}
			"""
		}
	} finally {
		sh 'docker logout'
	}
}
