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

yarn create strapi-app backend --template @ef2/strapi
cd back-end
cp .env.example .env

cd ..


# Create frontend directory
mkdir front-end

# Load NEXTjs starter into front-end folder
yarn create next-app front-end --typescript --eslint -e https://github.com/ef2-digital/next
cd front-end
cp .env.local.example .env.local
