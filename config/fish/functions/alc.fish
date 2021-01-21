function alc --description 'AWS log Core'
  aws logs get-log-events --log-group-name "/ecs/Snocko-Core-taskdef" --log-stream-name $argv[1]
end
