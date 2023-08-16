{
	poweron: {
		"kind": 'pipeline',
		"type": 'docker',
		"name": 'awsbuilders-poweron',
		"clone": {
			"disable": true
		},
		"steps": [
			{
				"name": 'start-aws-instances',
				"pull": 'always',
				"image": 'amazon/aws-cli',
				"environment": {
					"AWS_ACCESS_KEY_ID": {
						"from_secret": 'AWS_ACCESS_KEY'
					},
					"AWS_SECRET_ACCESS_KEY": {
						"from_secret": 'AWS_SECRET_ACCESS_KEY'
					},
				},
				"commands": [
					'aws ec2 start-instances --region eu-north-1 --instance-ids i-01e3d598710a23947 i-02bb3cbe63a2b3fef',
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
					'push',
					'pull_request',
					'tag'
				]
			}
		}
	}
}