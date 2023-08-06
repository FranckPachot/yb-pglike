

img="https://github.com/FranckPachot/yb-pglike.git"
mkdir -p /var/tmp/repos-tests 
cd       /var/tmp/repos-tests #|| exit

# Search repos on GitHub:
#
# path:/docker-compose* /image: postgres/ /POSTGRES_PASSWORD:/ language:YAML  NOT is:archived 
#

case $1 in 

aws-dataall) # works
git clone https://github.com/awslabs/aws-dataall 
cd ./aws-dataall &&
sed -e 's!context: compose/postgres!context: '"${img}"'!' -i docker-compose.yaml &&
docker-compose -p $1 up
;;

discourse) # 
git clone https://github.com/discourse/discourse_docker.git
cd ./discourse_docker &&
sed -e 's?image: postgres.*?build: '"${img}"'?' -i docker-compose.yml &&
cat docker-compose.yml &&
echo "
./download_data.sh
docker-compose exec postgres bash /home/data/load_table.sh
" &&
docker-compose -p $1 -f docker-compose.yml up 
;;


metabase) # nothing happens on sign in
git clone https://github.com/entrepreneur-interet-general/demo_metabase_postgres.git
cd ./demo_metabase_postgres &&
sed -e 's?image: postgres.*?build: '"${img}"'?' -i docker-compose.yml &&
cat docker-compose.yml &&
echo "
./download_data.sh
docker-compose exec postgres bash /home/data/load_table.sh
" &&
docker-compose -p $1 -f docker-compose.yml up 
;;

odoo) # needs listen/notify
git clone https://github.com/choboellobo/odoo-16.git
cd ./odoo-16 &&
sed -e 's?image: postgres.*?build: '"${img}"'?' -i docker-compose.yml &&
cat docker-compose.yml &&
docker-compose -p $1 -f docker-compose.yml up
;;

papercups) # err
git clone https://github.com/lucasavila00/papercups.git
cd ./papercups &&
sed -e 's!image: postgres!build: '"${img}"'!' -i docker-compose.dev.yml &&
docker-compose -p $1 -f docker-compose.dev.yml up
;;

photoprism) # err
git clone https://github.com/photoprism/photoprism.git
cd ./photoprism &&
sed -e 's!image: postgres!build: '"${img}"'!' -i docker-compose.postgres.yml &&
docker-compose -p $1 -f docker-compose.postgres.yml up
;;

rucio) # serializable error
git clone https://github.com/rucio/rucio.git
cd ./rucio/etc/docker/dev &&
sed -e 's!image: docker.io[/]postgres.*!build: '"${img}"'!' -i docker-compose.yml &&
sed -e 's!command:.*fsync=off!#&1!' -i docker-compose.yml &&
docker-compose -p $1 -f docker-compose.yml up
# tools/run_tests_docker.sh
;;

runtipi) # err
git clone https://github.com/meienberger/runtipi.git
cd ./runtipi &&
#sed -e 's!image: postgres!build: '"${img}"'!' -i docker-compose.yml &&
#cat .env.example .env.test > .env && docker-compose -f docker-compose.yml up
docker-compose -p $1 -f docker-compose.test.yml up
;;

shiori) # err
git clone https://github.com/go-shiori/shiori.git
cd ./shiori &&
sed -e 's?image: postgres.*?build: '"${img}"'?' -i docker-compose.yaml &&
sed -e 's/SHIORI_DBMS: mysql/SHIORI_DBMS: postgres/' -i docker-compose.yaml &&
cat docker-compose.yaml &&
docker-compose -p $1 -f docker-compose.yaml up
;;

wiki) # works
git clone https://github.com/requarks/wiki
cd ./wiki/dev/examples &&
sed -e 's!image: postgres.*!build: '"${img}"'!' -i docker-compose.yml &&
docker-compose -p wiki up
;;

*)
echo "List of repos there:"
awk -F")" '/^[^)*]*[)] #/{printf "%30s %s\n",$1,$2}' $OLDPWD/$0 
;;

esac



