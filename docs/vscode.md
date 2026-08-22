# VSCode setup

I recommend using VSCode with [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension installed. You can use that extension to connect to the running GCC container. If you want automatically to set the extensions, set the user and other configurations for each container, after you attach to it, select from the action menu (F1) the "Remote-Containers: Open Container Configuration File" and add the configuration based on your preference. Below is my example and a list of plugins I like to use:

```json
{
	"extensions": [
		"batyan-soft.fast-tasks",
		"donjayamanne.githistory",
		"eamodio.gitlens",
		"editorconfig.editorconfig",
		"github.copilot",
		"github.copilot-chat",
		"gruntfuggly.todo-tree",
		"humao.rest-client",
		"jbenden.c-cpp-flylint",
		"johnstoncode.svn-scm",
		"ms-vscode.cpptools",
		"paragdiwan.gitpatch",
		"patricklee.vsnotes",
		"twxs.cmake"
	],
	"workspaceFolder": "/opt/code",
	"remoteUser": "amidev"
}
```
