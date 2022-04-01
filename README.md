# PM Docker Builder - GitHub Action
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)


A [GitHub Action](https://github.com/features/actions) to easly build docker image and push to the registry.

## Usage

You can use this action after any other action. Here is an example setup of this action:

1. Create a `.github/workflows/docker-build.yml` file in your GitHub repo.
2. Add the following code to the `docker-build.yml` file.

```yml
on: push
name: Build docker Demo
jobs:
  slackNotification:
    name: Build docker
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Build docker
      uses: pmagentur/pm_docker_builder@v0.1
      env:
        USERNAME: ${{ secrets.USERNAME }}
        PASSWORD: ${{ secrets.PASSWORD }}
        CREATE_BACKUP: "True"

```

3. Create `USERNAME` and `PASSWORD` secrets [GitHub Action's Secret](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets), which represent Your Docker's registry username and password

## Environment Variables

By default, action is designed to run with minimal configuration but you can alter Slack notification using following environment variables:

Variable       | Default                                               | Purpose
---------------|-------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------
USERNAME  | Must be passed as an env variable                     | Docker registry username
PASSWORD  | GitHub Repository name                      | Docker registry password
REGISTRY | `hub.docker.com`                                               | Docker registry url (public or private)
REPOSITORY     | GitHub Repo name excluding owner name , If `octocat/Hello-World`, then REPOSITORY=`Hello-World` | Docker repository name (IMAGE = (REGISTRY/REPOSITORY:TAG))
TAG    | `latest`                                         | Docker image's tag
DOCKERFILE_PATH  | `.`                    | The location of the Dockerfile (Same as CONTEXT_PATH)
CREATE_BACKUP    | `False`                                              | If it is set to `True`, Action Creates doublicated docker image using build number as a tag and puses to docker registry
CONTEXT_PATH     | `$DOCKERFILE_PATH` | Sets the build context directory (Same as DOCKERFILE_PATH)
DOCKERFILE       | `$CONTEXT_PATH + '/Dockerfile'` | Defines the dockerfile which will be used for the build

You can see the action block with all variables as below:

```yml
    - name: Slack notifier
      uses: pmagentur/pm_slack_notifier@v0.1
      env:
        USERNAME: ${{ secrets.USERNAME }}
        PASSWORD: ${{ secrets.PASSWORD }}
        REGISTRY: docker.pmagenture.com
        REPOSITORY: 'pm-test-image'
        CONTEXT_PATH: '..'
        DOCKERFILE: './Dockerfile.stage'
        CREATE_BACKUP: 'True'
```

## License

[MIT](LICENSE) © 2019 PM Agentur
