# suppress messages about "no jobs available"
# see https://github.com/chanks/que/blob/master/docs/logging.md
Que.log_formatter = proc do |data|
  if [:job_worked, :job_errored].include?(data[:event])
    JSON.dump(data)
  end
end