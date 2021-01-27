function ali --description 'AWS log Integration'
  aws logs get-log-events --log-group-name "/ecs/Snocko-Integration-taskdef" --log-stream-name $argv[1]
end
