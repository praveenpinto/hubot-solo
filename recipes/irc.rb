#
# irc recipe
#

include_recipe "hubot-solo::nodejs"
include_recipe "hubot-solo::official_git_hubot"
include_recipe "hubot-solo::foreverjs"
include_recipe "hubot-solo::redis"

bash "install hubot-irc" do
  user "vagrant"
  cwd "/home/vagrant/repo/hubot"
  creates "maybe"
  code <<-EOH
  STATUS=0
  su vagrant -c npm install hubot-irc --save || STATUS=1
  su vagrant -c npm install || STATUS=1
  exit $STATUS
  EOH
end


bash "run myhubot" do
  user "vagrant"
  cwd "/home/vagrant/repo/hubot"
  creates "maybe"
  code <<-EOH
  STATUS=0
  su vagrant -c \
   forever start -l forever.log -o out.log -e err.log
   HUBOT_IRC_SERVER=irc.freenode.net \
   HUBOT_IRC_ROOMS="#jjtesting-irc" \
   HUBOT_IRC_NICK="jjhubot-testing" \
   HUBOT_IRC_UNFLOOD="true" \
   bin/hubot -a irc --name jjhubot-testing || STATUS=1
  exit $STATUS
  EOH
end

# stop the forever via
# forever stop bin/hubot

