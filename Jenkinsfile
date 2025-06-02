pipeline {
	agent any
	environment {
		DOCKERHUB_CREDS=credentials('walkero-dockerhub')
		AWS_CREDS=credentials('aws-ec2-credentials')
		AWS_DEFAULT_REGION="eu-north-1"
		DOCKERHUB_REPO="walkero/amigagccondocker"
		GIT_CREDS = credentials('github-access-token')
	}
	stages {
		stage('update-build-badge') {
			when { 
				allOf {
					buildingTag()
					tag pattern: "os4-.*", comparator: "REGEXP"
				}
			}
			steps {
				sh """
					git checkout -b main
					sed -i -E \"s|(view/tags/job/)os4-[^/]+/|\\1\${TAG_NAME}/|g\" README.md
					git config user.name \"George Sokianos\"
					git config user.email \"walkero@gmail.com\"
					git add README.md
					git commit -m \"Updating the release badge with ${TAG_NAME}\"
				"""
				sh 'git push https://$GIT_CREDS_USR:$GIT_CREDS_PSW@github.com/walkero-gr/AmigaGCConDocker.git main'
				sh """
					git checkout ${TAG_NAME}
				"""
			}
		}
		stage('aws-poweron') {
			when { buildingTag() }
			steps {
				sh """
					aws ec2 start-instances --instance-ids i-07474e4fe80f14754 i-02bb3cbe63a2b3fef || { echo "Failed to start AWS instances"; exit 1; }
				"""
			}
		}
		stage('build-ppc-amigaos-images') {
			when { 
				allOf {
					buildingTag()
					tag pattern: "os4-.*", comparator: "REGEXP"
				}
			}
			environment {
				TAG_VERSION = "${TAG_NAME.replace('os4-', '')}"
				OS4_GCC_BASE_VER="1.5.0"
			}
			matrix {
				axes {
					axis {
						name 'ARCH'
						values 'amd64', 'arm64'
					}
					axis {
						name 'GCC'
						values '11', '8', '6'
					}
				}
				agent { label "aws-${ARCH}" }
				stages {
					stage('build') {
						options {
							timeout(time: 60, unit: 'MINUTES')
						}
						steps {
							sh """
								cd ppc-amigaos
								docker build \
									--cache-from ${DOCKERHUB_REPO}:os4-gcc${GCC}-${ARCH} \
									--build-arg OS=os4 \
									--build-arg BASE_VER=${OS4_GCC_BASE_VER} \
									--build-arg GCC_VER=${GCC} \
									-t ${DOCKERHUB_REPO}:os4-gcc${GCC}-${TAG_VERSION}-${ARCH} \
									-t ${DOCKERHUB_REPO}:os4-gcc${GCC}-${ARCH} \
									-f Dockerfile .
							"""
						}
					}
					stage('dockerhub-login') {
						steps {
							sh """
								echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
							"""
						}
					}
					stage('push-images') {
						steps {
							sh """
								set -e
								docker push ${DOCKERHUB_REPO}:os4-gcc${GCC}-${TAG_VERSION}-${ARCH} || { echo "Failed to push tagged image"; exit 1; }
								docker push ${DOCKERHUB_REPO}:os4-gcc${GCC}-${ARCH} || { echo "Failed to push latest image"; exit 1; }
							"""
						}
					}
					stage('remove-images') {
						steps {
							sh """
								docker rmi -f \$(docker images --filter=reference="${DOCKERHUB_REPO}:*" -q)
								docker image prune -a --force
							"""
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
			matrix {
				axes {
					axis {
						name 'GCC'
						values '11', '8', '6'
					}
				}
				stages {
					stage('create') {
						steps {
							sh """
								docker manifest create \
									--amend ${DOCKERHUB_REPO}:os4-gcc${GCC}-${TAG_VERSION} \
									${DOCKERHUB_REPO}:os4-gcc${GCC}-${TAG_VERSION}-amd64 \
									${DOCKERHUB_REPO}:os4-gcc${GCC}-${TAG_VERSION}-arm64

								docker manifest create \
									--amend ${DOCKERHUB_REPO}:os4-gcc${GCC} \
									${DOCKERHUB_REPO}:os4-gcc${GCC}-amd64 \
									${DOCKERHUB_REPO}:os4-gcc${GCC}-arm64
							"""
						}
					}
					stage('push-manifests') {
						when { buildingTag() }
						steps {
							sh """
								echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
								docker manifest push ${DOCKERHUB_REPO}:os4-gcc${GCC}-${TAG_VERSION}
								docker manifest push ${DOCKERHUB_REPO}:os4-gcc${GCC}
								docker logout
							"""
						}
					}
					stage('clear-manifests') {
						when { buildingTag() }
						steps {
							sh """
								docker manifest rm ${DOCKERHUB_REPO}:os4-gcc${GCC}-${TAG_VERSION}
								docker manifest rm ${DOCKERHUB_REPO}:os4-gcc${GCC}
							"""
						}
					}
				}
			}
		}
	}
}
