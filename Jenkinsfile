pipeline {
	agent any
	environment {
		DOCKERHUB_CREDS=credentials('walkero-dockerhub')
		DOCKERHUB_REPO="walkero/amigagccondocker"
	}
	stages {
		stage('build-ppc-amigaos-images') {
			when { 
				allOf {
					buildingTag()
					tag pattern: "os4-.*", comparator: "REGEXP"
				}
			}
			environment {
				TAG_VERSION = "${TAG_NAME.replace('os4-', '')}"
				OS4_GCC_BASE_VER="1.8.0"
			}
			matrix {
				axes {
					axis {
						name 'ARCH'
						values 'amd64', 'arm64'
					}
					axis {
						name 'GCC'
						values '13', '11', '8'
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
								buildAndPush(GCC, ARCH)
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
			when { 
				allOf {
					buildingTag()
					tag pattern: "os4-.*", comparator: "REGEXP"
				}
			}
			environment {
				TAG_VERSION = "${TAG_NAME.replace('os4-', '')}"
			}
			steps {
				script {
					createAndPushManifests(['13', '11', '8'])
				}
			}
		}
	}
}

def buildAndPush(gccVer, arch) {
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

def createAndPushManifests(gccVersions) {
	gccVersions.each { gccVer ->
		def imageTagBase = "${env.DOCKERHUB_REPO}:os4-gcc${gccVer}"
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
			def imageTagBase = "${env.DOCKERHUB_REPO}:os4-gcc${gccVer}"
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