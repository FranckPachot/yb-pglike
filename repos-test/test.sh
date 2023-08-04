
img="https://github.com/FranckPachot/yb-pglike.git"
mkdir -p /var/tmp/tests 

# Search on GitHub:
#
# path:/docker-compose* /image: postgres/ /POSTGRES_PASSWORD:/ language:YAML  NOT is:archived 
#

cd       /var/tmp/tests &&
rm -rf shiori
git clone https://github.com/choboellobo/odoo-16.git
cd ./odoo-16 &&
sed -e 's?image: postgres.*?build: '"${img}"'?' -i docker-compose.yml &&
cat docker-compose.yml &&
docker-compose -f docker-compose.yml up

exit

cd       /var/tmp/tests &&
rm -rf shiori
git clone https://github.com/go-shiori/shiori.git
cd ./shiori &&
sed -e 's?image: postgres.*?build: '"${img}"'?' -i docker-compose.yaml &&
sed -e 's/SHIORI_DBMS: mysql/SHIORI_DBMS: postgres/' -i docker-compose.yaml &&
cat docker-compose.yaml &&
docker-compose -f docker-compose.yaml up

exit

cd       /var/tmp/tests &&
git clone https://github.com/lucasavila00/papercups.git
cd ./papercups &&
sed -e 's!image: postgres!build: '"${img}"'!' -i docker-compose.dev.yml &&
docker-compose -f docker-compose.dev.yml up

exit

cd       /var/tmp/tests &&
git clone https://github.com/meienberger/runtipi.git
cd ./runtipi &&
#sed -e 's!image: postgres!build: '"${img}"'!' -i docker-compose.yml &&
#cat .env.example .env.test > .env && docker-compose -f docker-compose.yml up
docker-compose -f docker-compose.test.yml up

exit

cd       /var/tmp/tests &&
git clone https://github.com/photoprism/photoprism.git
cd ./photoprism &&
sed -e 's!image: postgres!build: '"${img}"'!' -i docker-compose.postgres.yml &&
docker-compose -f docker-compose.postgres.yml up

exit

cd       /var/tmp/tests &&
git clone https://github.com/initOS/dob.git
cd ./dob &&
#sed -e 's!image: postgres!build: '"${img}"'!' -i docker-compose.postgres.yml &&
./setup.sh && docker-compose up

exit

########### Following works


# A modern data marketplace that makes collaboration among diverse users (like business, analysts and engineers) easier, increasing efficiency and agility in data projects on AWS.
cd       /var/tmp/tests &&
git clone https://github.com/awslabs/aws-dataall 
cd ./aws-dataall &&
sed -e 's!context: compose/postgres!context: '"${img}"'!' -i docker-compose.yaml &&
docker-compose up


exit

