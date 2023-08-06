docker compose -f  docker-compose-context.yaml down
docker compose -f  docker-compose-context.yaml up -d
until
docker compose -f  docker-compose-context.yaml logs app | grep -C 100 " done in"
do
sleep 1
done
until
docker compose -f docker-compose-context.yaml run app pgbench -nh db 
do
sleep 1
done
( cd .. && docker build -t pachot/yb-pglike . && docker push pachot/yb-pglike )
