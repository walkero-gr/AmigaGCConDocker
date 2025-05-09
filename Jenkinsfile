pipeline {
	agent any
	environment {
		DOCKERHUB_CREDS=credentials('walkero-dockerhub')
		AWS_CREDS=credentials('aws-ec2-credentials')
		AWS_DEFAULT_REGION="eu-north-1"
		DOCKERHUB_REPO="walkero/amigagccondocker"
		OS4_GCC_BASE_VER="1.5.0"
	}
	stages {
		stage('aws-poweron') {
			when { buildingTag() }
			steps {
				sh '''
					aws ec2 start-instances --instance-ids i-07474e4fe80f14754 i-02bb3cbe63a2b3fef
				'''
			}
		}
		stage('build-ppc-amigaos-images') {
			when { 
				allOf {
					buildingTag()
					tag pattern: "os4-.*", comparator: "REGEXP"
				}
			}
			matrix {
				axes {
					axis {
						name 'ARCH'
						values 'amd64', 'arm64'
					}
					axis {
						name 'GCC'
						values '11'
					}
				}
				agent { label "aws-${ARCH}" }
				stages {
					stage('build') {
						steps {
							sh '''
								cd ppc-amigaos
								docker build \
									--cache-from ${DOCKERHUB_REPO}:os4-gcc${GCC}-${ARCH} \
									--build-arg OS=os4 \
									--build-arg BASE_VER=${OS4_GCC_BASE_VER} \
									--build-arg GCC_VER=${GCC} \
									-t ${DOCKERHUB_REPO}:os4-gcc${GCC}-${TAG_NAME.replace("os4-", "")}-${ARCH} \
									-t ${DOCKERHUB_REPO}:os4-gcc${GCC}-${ARCH} \
									-f Dockerfile .
							'''
						}
					}
					stage('dockerhub-login') {
						steps {
							sh '''
								echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
							'''
						}
					}
					stage('push-images') {
						steps {
							sh '''
								docker push ${DOCKERHUB_REPO}:os4-gcc${GCC}-${TAG_NAME.replace("os4-", "")}-${ARCH}
								docker push ${DOCKERHUB_REPO}:os4-gcc${GCC}-${ARCH}
							'''
						}
					}
					stage('remove-images') {
						steps {
							sh '''
								docker image ls
								docker rmi -f $(docker images --filter=reference="${DOCKERHUB_REPO}:*" -q)
								docker image prune -a --force
								docker image ls
							'''
						}
					}
				}
				post {
					always {
						sh '''
							docker logout
						'''
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
			matrix {
				axes {
					axis {
						name 'GCC'
						values '11'
					}
				}
				stages {
					stage('create') {
						steps {
							sh '''
								docker manifest create \
									--amend ${DOCKERHUB_REPO}:os4-gcc${GCC}-${TAG_NAME.replace("os4-", "")} \
									${DOCKERHUB_REPO}:os4-gcc${GCC}-${TAG_NAME.replace("os4-", "")}-amd64 \
									${DOCKERHUB_REPO}:os4-gcc${GCC}-${TAG_NAME.replace("os4-", "")}-arm64

								docker manifest create \
									--amend ${DOCKERHUB_REPO}:os4-gcc${GCC} \
									${DOCKERHUB_REPO}:os4-gcc${GCC}-amd64 \
									${DOCKERHUB_REPO}:os4-gcc${GCC}-arm64
							'''
						}
					}
					stage('push-manifests') {
						when { buildingTag() }
						steps {
							sh '''
								echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
								docker manifest push ${DOCKERHUB_REPO}:os4-gcc${GCC}-${TAG_NAME}
								docker manifest push ${DOCKERHUB_REPO}:os4-gcc${GCC}
								docker logout
							'''
						}
					}
					stage('clear-manifests') {
						when { buildingTag() }
						steps {
							sh '''
								docker manifest rm ${DOCKERHUB_REPO}:os4-gcc${GCC}-${TAG_NAME}
								docker manifest rm ${DOCKERHUB_REPO}:os4-gcc${GCC}
							'''
						}
					}
				}
			}
		}
	}
}
