# This script will help configure automated projects with the correct starters 

# Created by Daan de Gooijer

echo -e "\n"
echo ">> Welcome to the EF2 project set up script."
echo -e ">> This script will set up a basic project structure\n"

# Get the project name - this will be used in the folder path and in the htacess username
echo ">> Repository Name:"
read name

echo -e "\n"

echo -e ">> Begin setup...\n "
# Echo verbose commands
#set -x

# Create the backend directory
mkdir back-end

# Load Strapi into back-end folder

yarn create strapi-app backend --template @ef2/strapi@latest --typescript --no-run --quickstart

cd back-end
cp .env.example .env
cd data
cp plugins.example.ts ../config/plugins.ts
cp database.example.ts ../config/database.ts


# Get the DB user name
echo ">> Database username:"
read username

printf "DATABASE_USERNAME=$username" > .env

# Get the DB user password
echo ">> Database password:"
read password

printf "DATABASE_PASSWORD=$password" > .env

# Get the DB name
echo ">> Database name:"
read name

printf "DATABASE_NAME=$name" > .env

$key=`openssl rand -base64 24`
$key2=`openssl rand -base64 24`
$key3=`openssl rand -base64 24`
$key4=`openssl rand -base64 24`
$key5=`openssl rand -base64 24`
$key6=`openssl rand -base64 24`

printf "APP_KEYS=$key1,$key2,$key3" > .env
printf "API_TOKEN_SALT=$key4" > .env
printf "ADMIN_JWT_SECRET=$key5" > .env
printf "TRANSFER_TOKEN_SALT=$key6" > .env

yarn build

cd ..


# Create frontend directory
mkdir front-end

# Load NEXTjs starter into front-end folder
yarn create next-app front-end --typescript --eslint -e https://github.com/ef2-digital/next
cd front-end
cp .env.local.example .env.local
