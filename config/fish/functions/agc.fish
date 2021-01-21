function agc --description 'AWS log groups Core'
  aws logs describe-log-streams --log-group "/ecs/Snocko-Core-taskdef" --order-by LastEventTime --descending
end
