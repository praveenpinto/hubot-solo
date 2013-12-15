#
# main default recipe, this is for testing only!
#

include_recipe "hubot-solo::nodejs"
include_recipe "hubot-solo::personal_git_hubot"
include_recipe "hubot-solo::official_git_hubot"
include_recipe "hubot-solo::foreverjs"
include_recipe "hubot-solo::redis"

bash "run myhubot" do
  user "vagrant"
  cwd "/home/vagrant/repo/hubot"
  creates "maybe"
  code <<-EOH
  STATUS=0
  su vagrant -c bin/hubot --help || STATUS=1
  exit $STATUS
  EOH
end

