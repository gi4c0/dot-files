function agi --description 'AWS log groups Integration'
  aws logs describe-log-streams --log-group "/ecs/Snocko-Integration-taskdef" --order-by LastEventTime --descending
end
