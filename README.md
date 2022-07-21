To authorize the Google Cloud SDK we are going to create a container with Ruby preinstalled

In the project directory, create a Ruby docker container mapping the project directory to the /app folder of the container and opening the shell

```
docker run -it -v ${pwd}:/app ruby:2.4 sh
```

In the container shell, install the Travis CLI

```
gem install travis
```

Then login to travis with a GitHub PAT previously generated

```
travis login --github-token GITHUB_ACCESS_TOKEN --com
```

Then enter the `app` directory inside the container and encrypt the `service-account.json` file that contains the Google Cloud project keys

```
travis encrypt-file service-account.json -r nicolaslazzos/kubernetes-ci-cd --com
```

Then follow the instructions and delete the `service-account.json` file.
