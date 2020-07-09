variable "app" {}
variable "docker_image" {}
variable "docker_registry" {
  default = "https://index.docker.io"
}
variable "env" {}
variable "region" {
  default = "WestEurope"
}
variable "tags" {
  type = map
}