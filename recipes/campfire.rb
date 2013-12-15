#
# campfire recipe
#

include_recipe "hubot-solo::nodejs"
include_recipe "hubot-solo::official_git_hubot"
include_recipe "hubot-solo::foreverjs"
include_recipe "hubot-solo::redis"

bash "run myhubot" do
  user "vagrant"
  cwd "/home/vagrant/repo/hubot"
  creates "maybe"
  code <<-EOH
  STATUS=0
  su vagrant -c \
   forever start -l forever.log -o out.log -e err.log
   HUBOT_CAMPFIRE_ACCOUNT="some account"
   HUBOT_CAMPFIRE_TOKEN="some token"
   HUBOT_CAMPFIRE_ROOMS="666,333"
   bin/hubot -a campfire --name Hubot || STATUS=1
  exit $STATUS
  EOH
end

# stop the forever via
# forever stop bin/hubot

