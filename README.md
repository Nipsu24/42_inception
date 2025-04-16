<h1 align="center">inception</h1>

> Hive Helsinki (School 42) 15th project (Rank05/06) of core curriculum.

<h2 align="center">
	<a href="#about">About</a>
	<span> · </span>
	<a href="#Project details">Project details</a>
	<span> · </span>
	<a href="#requirements">Requirements</a>
	<span> · </span>
	<a href="#instructions">Instructions</a>
</h2>

## About
The project builds 3 connected docker containers (nginx, mariadb, wordpress) by using docker-compose, launched by a Makefile.
After a successful build, a wordpress website can be accessed, both as common user and admin user.

## Project details
For each of the 3 containers Dockerfiles and scripts/config files ensure the build of the respective container and the set-up and configuration of the applications.
By utelising docker-compose, a communication network among the containers is established with a clear dependency/build hierarchy (mariadb > wordpress > nginx).
The project was built and run entirely in a virtual machine on Alpine.

## Requirements
- docker and docker-compose installed

## Instructions

### 1. Creating .env file

In order to create the .env file which holds information about log-in credentials and passwords which are later used for setting up the respective application, the `create_env.sh` script
needs to be populated, e.g.:

```
$ vim create_env.sh
LOGIN="mmeier"
WP_USERNAME="mmeier"
WP_ADM_NAME="boss"

DB_PASS="42"
DB_ROOT_PASS="42"
WP_USERPASS="42"
WP_ADM_PASS="42" 
```
after saving the changes done in the `create_env.sh`
```
make env
```
then
```
make
```
### 2. Check docker container availability

The docker containers should be now up and running which can be varified with the following command in the terminal:

```
docker ps
```

### 3. Access website

Depending on the credentials in the .env file the website can be accessed as follows from a browser (example taken from above):
```
https://mmeier.42.fr
```
In order to login as admin, access the following website and enter the credentials set in the .env file:
```
https://mmeier.42.fr/wp-admin
```
Common users are able to e.g. post comments, whereby the admin user can accept and publish those comments or conduct otherwise changes to the website (setting up new pages, altering text/layout)
