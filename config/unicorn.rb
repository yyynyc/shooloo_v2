root = "/home/deployer/apps/shooloo_v2/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.shooloo_v2.sock"
listen "127.0.0.1:3000"
worker_processes 2
timeout 30