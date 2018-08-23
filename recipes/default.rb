execute "apt-get-update" do
  command "apt-get update"
end

execute "install" do
  command "apt-get install -y erlang"
end

package 'gnupg'

remote_file '/tmp/rabbitmq-release-signing-key.asc' do
  source 'https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc'
  action :create
end

execute "download rabbit" do
  command "apt-key add /tmp/rabbitmq-release-signing-key.asc"
end

execute "configure source list" do
  command "echo 'deb https://dl.bintray.com/rabbitmq/debian bionic erlang' > /etc/apt/sources.list.d/bintray.erlang.list"
end

execute "configure source list 2" do
  command "echo 'deb https://dl.bintray.com/rabbitmq/debian bionic main' >> /etc/apt/sources.list.d/bintray.erlang.list"
end

package 'rabbitmq-server'

execute "add web" do
  command "rabbitmq-plugins enable rabbitmq_management"
end

service "rabbitmq-server" do
  action :restart
end

execute "test" do
  command "curl -w ' <-- We downloaded %{size_download} bytes\n' -i -u guest:guest http://localhost:15672/api/whoami"
  live_stream true
  action :run
end
