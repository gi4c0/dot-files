function ali --description 'AWS log Integration'
  aws logs describe-log-streams --log-group "/ecs/Snocko-Integration-taskdef" --order-by LastEventTime --descending $argv[1]
end
