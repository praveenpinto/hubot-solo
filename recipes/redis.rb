#
#
# install redis
#
#

remote_file "/tmp/redis-2.8.3.tar.gz" do
  owner "root"
  group "root"
  mode "0644"
  source "http://download.redis.io/releases/redis-2.8.3.tar.gz"
end

bash "untar and build redis" do
  user "root"
  cwd "/tmp/"
  code <<-EOH
  STATUS=0
  tar xvzf redis-2.8.3.tar.gz || STATUS=1
  cd  redis-2.8.3 || STATUS=1
  make || STATUS=1
  exit $STATUS
  EOH
end

cookbook_file "/tmp/redis-2.8.3/redis.conf" do
  owner "root"
  group "root"
  mode "0644"
  source "redis.conf"
end


bash "run redis" do
  user "root"
  cwd "/tmp/redis-2.8.3"
  code <<-EOH
  STATUS=0
  src/redis-server /tmp/redis-2.8.3/redis.conf || STATUS=1
  exit $STATUS
  EOH
end



