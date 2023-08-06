cd $(dirname $0)
docker compose -f  docker-compose-context.yaml down
docker image rm $(basename $PWD)-db
docker compose -f  docker-compose-context.yaml up -d
docker compose -f  docker-compose-context.yaml logs -f app
read -p  "Do you want to push the image to Docker Hub? " rep
echo "$rep" | grep -i ^y && {
 docker login -u pachot
 cd .. && docker build -t pachot/yb-pglike . && docker push pachot/yb-pglike 
}
