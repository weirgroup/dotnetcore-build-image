workflow "New workflow" {
  on = "push"
  resolves = ["Docker Push"]
}

action "GitHub - Login" {
  uses = "actions/docker/login@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Docker Build" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  needs = ["GitHub - Login"]
  args = "build -t weirgroup/dotnetcore-build-image:latest ."
}

action "Docker Push" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  args = "push weirgroup/dotnetcore-build-image:latest ."
  needs = ["Docker Build"]
}
