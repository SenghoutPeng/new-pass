# new-pass
## Setup Guide (Linux)
### Nuxt
For Frontend and Backend folders:

Change your directory to either **_frontend_** or **_backend_** then remove the **_node_modules_** and their **_package-lock.json_**
```
cd frontend/backend
rm -rf node_modules package-lock.json
```
then
```
npm install
```

> Require **NodeJS** with version >= **20.x**

Next, edit _**nuxt.config.ts**_ according to your setup for both _**frontend/backend**_ then test it locally by running
```
npm run dev
```

(optional) Finally, if you are done with configuring _**nuxt.congig.ts**_, and is running the application on a server you need to build the project by
```
npm run build
```
> Rerun the build everytime you make **CHANGES** on the **Nuxt Project** either the **code** or **config** to **APPLY** all the changes

### Laravel
Change your directory to _api_ and install the dependencies
```
cd api
composer install
```
> Compatible with **PHP8.x** and **REQUIRE** **Composer** to be installed your machine

Then copy configs from **_.env.example_** to **_.env_.** By default when performing a _git clone_, **.env** will not be cloned with your project, hence you need to DUPLICATE **_.env.example_** then rename it to _**.env**_ or in linux just copy and rename it by
```
cp .env.example .env
```

Finally, edit _**.env**_ according to your setup then 
```
php artisan migrate:fresh --seed
php artisan cache:clear
php artisan config:clear
php artisan optimize:clear
```