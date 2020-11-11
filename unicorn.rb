@dir = File.join(File.dirname(__FILE__), "")
@log = File.join(@dir,"log")
@run = File.join(@dir,"run")
Dir.exists?(@log) || Dir.mkdir(@log)
Dir.exists?(@run) || Dir.mkdir(@run)

worker_processes 2
working_directory @dir
timeout 30

@socket_path = File.expand_path(File.join(@run, "unicorn.sock"))

listen @socket_path, :backlog => 64
#listen "0.0.0.0:80", :backlog => 64
pid File.join(@run, "unicorn.pid")
stderr_path File.join(@log, "unicorn.stderr.log")
stdout_path File.join(@log, "unicorn.stdout.log")
