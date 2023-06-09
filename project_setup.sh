# This script will help configure automated projects with the correct starters

# Created by Daan de Gooijer
RED="\e[31m"
ENDRED="\e[0m"

set -e

echo "Welcome to the EF2 project set up script.\n"
echo "This script will set up a basic project structure\n"
echo "Before you continue, please make sure you're using node version 16.x and have already have a MYSQL DB ready\n"

# Get the project name - this will be used in the folder path and in the htacess username
echo "Repository Name:"
read name

echo $(printf "Begin setup for ${RED}$name${ENDRED}\n\n")

mkdir $name
cd $name

echo "Initializing REPO $name \n "

echo 'Bitbucket username?'
read username
echo 'Bitbucket Password?'
read -s password

curl -X POST -v -u $username:$password "https://api.bitbucket.org/2.0/repositories/ef2techniek/$name" -H "Content-Type: application/json" -d '{"scm": "git", "is_private": "true", "fork_policy": "no_public_forks"}'
git init
git remote add origin git@bitbucket.org:ef2techniek/$name.git

echo "mkdir back-end...\n "
# Create the backend directory
mkdir back-end

echo "loading Strapi inside back-end \n "
# Load Strapi into back-end folder
yarn create strapi-app back-end --template @ef2/strapi@latest --typescript --no-run

echo "Configuring Strapi \n "
cd back-end

#Copy plugins and database settings from template
cd data
cp plugins.example.ts ../config/plugins.ts
rm plugins.example.ts
cd ..

{
    echo "STRAPI_DISABLE_UPDATE_NOTIFICATION=true"
    echo "BROWSER=false"
    echo "STRAPI_PLUGIN_I18N_INIT_LOCALE_CODE='nl'"
} >> .env

cd ..

# Create frontend directory
# Load NEXTjs starter into front-end folder
yarn create next-app front-end --typescript --eslint -e https://github.com/ef2-digital/next
cd front-end
cp .env.local.example .env.local
cd ..

echo "Pushing REPO $name to bitbucket \n "
git add .
git commit -m "Automated strapi/next push"
git push --set-upstream origin main

echo "\n\nSetup done succesfully! \n\n"
echo $(printf "Startup your Strapi environment by going to the ${RED}'back-end'${ENDRED} folder and use the command: 'yarn develop' \n ")
echo $(printf "Start your NEXTjs environment by going to the ${RED}'front-end'${ENDRED} folder and use the command: 'yarn dev' \n\n")
echo "Happy coding!"
