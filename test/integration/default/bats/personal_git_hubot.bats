#!/usr/bin/env bats

@test "check git is installed" {
  run git --help
  [ "$status" -eq 0 ]
}

@test "git installed at /usr/bin/git" {
  run which git
  [ "$output" = "/usr/bin/git" ]
}

@test "confirm that the git clone happened" {
  run ls /home/vagrant/repo/hubot
  [ "$status" -eq 0 ]
}


