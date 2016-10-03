# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)

# from https://github.com/chanks/que/blob/master/docs/advanced_setup.md#forking-servers
if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    if forked
      Que.mode = :async
    end
  end
end

run Rails.application