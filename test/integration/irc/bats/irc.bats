#!/usr/bin/env bats

@test "check git is installed" {
  run git --help
  [ "$status" -eq 0 ]
}

@test "git installed at /usr/bin/git" {
  run which git
  [ "$output" = "/usr/bin/git" ]
}

@test "confirm that the myhubot script created the directory" {
  run ls /home/vagrant/myhubot-official
  [ "$status" -eq 0 ]
}


