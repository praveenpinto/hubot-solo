#
#
# Pull your hubot scripts down from github
#
#

include_recipe "hubot-solo::nodejs"
package "git-core"

bash "install hubot" do
  user "vagrant"
  cwd "/home/vagrant/"
  #creates "maybe"
  code <<-EOH
  STATUS=0
  npm install -g hubot || STATUS=1
  exit $STATUS
  EOH
end

bash "install coffeescript" do
  user "vagrant"
  cwd "/home/vagrant/"
  #creates "maybe"
  code <<-EOH
  STATUS=0
  npm install -g coffee-script || STATUS=1
  exit $STATUS
  EOH
end

bash "create hubot" do
  user "vagrant"
  cwd "/home/vagrant/"
  #creates "maybe"
  code <<-EOH
  STATUS=0
  hubot --create myhubot || STATUS=1
  exit $STATUS
  EOH
end

bash "initialize git in hubot" do
  user "vagrant"
  cwd "/home/vagrant/myhubot"
  creates "/home/vagrant/myhubot/.git/"
  code <<-EOH
  STATUS=0
  git init || STATUS=1
  git add . || STATUS=1
  git commit -m "Gratz you have a hubot" || STATUS=1
  exit $STATUS
  EOH
end

