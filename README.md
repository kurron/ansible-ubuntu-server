#Overview
This is an [Ansible](http://www.ansible.com/) playbook designed to greatly simplify the installation 
of the application monitoring simulation environment into an [Ubuntu 14.04](http://www.ubuntu.com/) instance.

#Prerequisites

* an Ubuntu 14.04 Server instance with [SSH](http://www.openssh.com/) enabled and working
* the instance must have a user that has `sudo` privledges
* the instance should have at least 6GB of RAM
* a box with the most current Ansible installed -- all testing was done using Ansible 1.9.3 on an Ubuntu 14.04 desktop talking to an Ubuntu 14.04 server
 
#Building
Since this project is just a collection of configuration and data files for Ansible to consume, no building is necessary.

#Installation
The first step is to get the files onto your Ansible box.  A great way is to use [Git](https://git-scm.com/) and
simply clone this project via `git clone https://github.com/kurron/ansible-monitor-provision`.  Another option is to 
[download the zip](https://github.com/kurron/ansible-monitor-provision/archive/master.zip) directly from GitHub.

Once you have the files available to you, you are going to have to edit the `hosts` file with a text editor.  The 
file is documented and should be easily understood. **You must also edit the `ansible.cfg` file, specifically the 
`remote_user` property.**  Failure to do this will prevent Ansible from SSH'ing into the instance.

To install the environment all you have to do is issue `./playbook.yml` from the command line.  Ansible will ask you for the password 
of the SSH account being used as well as the password to use for `sudo` (normally, you can just hit `Enter` here). You will 
also be prompted for configuration values that have reasonable defaults that can optionally be changed. the In a few moments your instance 
should be provisioned and ready to go.  **Please note that you must reboot the instance in order for some of the optimizations to take affect.** 

#Tips and Tricks

##Git Projects
The simulation environment is expressed as a collection of Docker containers.  There are a couple of GitHub projects that simplify the 
installation and control of the environment.  If you SSH into your box, you should find a `GitHub` directory in the user's home directory. 
The first project, `docker-monitor-compose`, is the primary project and spins up the databases and applications that comprise the environment. 
Execute `./start.sh` to install the containers and start them up.  It'll take a few minutes to download everything from the internet to 
be patient. You can run `./check-health.sh` to verify everything is up. It may take a minute or two for everything to fully start.

```bash
./start.sh
Pulling mysql-data (busybox:latest)...
latest: Pulling from library/busybox
cfa753dfea5e: Pull complete
d7057cb02084: Pull complete
library/busybox:latest: The image you are pulling has been verified. Important: image verification is a tech preview feature and should not be relied on to provide security.
Digest: sha256:16a2a52884c2a9481ed267c2d46483eac7693b813a63132368ab098a71303f8a
Status: Downloaded newer image for busybox:latest
Creating mysql-data...
Pulling rabbitmq-service (kurron/docker-monitor-rabbitmq:latest)...
latest: Pulling from kurron/docker-monitor-rabbitmq
d3a1f33e8a5a: Downloading [====>                                              ] 5.406 MB/65.79 MB
d3a1f33e8a5a: Pull complete
c22013c84729: Pull complete
d74508fb6632: Pull complete
91e54dfb1179: Pull complete
8e1940fe110d: Pull complete
358704cddcfd: Pull complete
0ac8da0788dc: Pull complete
6b7898c2281a: Pull complete
98a15b463ba7: Pull complete
2656217a381c: Pull complete
3b460102a79b: Pull complete
1302db5d4d7f: Pull complete
e1f22efd51f9: Pull complete
72cb2539bf37: Pull complete
bc36e44db6c3: Pull complete
dffd2393af4b: Pull complete
Digest: sha256:3c27e0e13adc1a1aea3426ffa44911e60984177ef7da4f2b08bddbb9980e0a9d
Status: Downloaded newer image for kurron/docker-monitor-rabbitmq:latest
Creating rabbitmq-service...
Creating mongodb-data...
Pulling mongodb (mongo:latest)...
latest: Pulling from library/mongo
ba249489d0b6: Pull complete
19de96c112fc: Pull complete
430e6598f55b: Pull complete
ec5be38a3c65: Pull complete
7328803ca452: Pull complete
e81ad85ddfce: Pull complete
5e7b428dddf7: Pull complete
0dab801053d9: Pull complete
96de83c82d4b: Pull complete
df59596772ab: Pull complete
f48ad436057a: Pull complete
c537910de5cc: Pull complete
ba53e9f50f18: Pull complete
541753126ccd: Pull complete
fbb60036722d: Pull complete
e9c96a892a89: Pull complete
b86849b1ee30: Pull complete
library/mongo:latest: The image you are pulling has been verified. Important: image verification is a tech preview feature and should not be relied on to provide security.
Digest: sha256:0e2e4975814269acf77ecd2e26ffafcdf0cfdea94159f92d84520fd320fa98c7
Status: Downloaded newer image for mongo:latest
Creating mongodb...
Creating redis-data...
Creating rabbitmq-data...
Pulling mongodb-service (kurron/docker-monitor-mongodb:latest)...
latest: Pulling from kurron/docker-monitor-mongodb
52730bc134b3: Pull complete
3f160e4a94cb: Pull complete
5cd4059aa62d: Pull complete
a28518a5dbd4: Pull complete
d3a1f33e8a5a: Already exists
c22013c84729: Already exists
d74508fb6632: Already exists
91e54dfb1179: Already exists
8e1940fe110d: Already exists
358704cddcfd: Already exists
0ac8da0788dc: Already exists
6b7898c2281a: Already exists
98a15b463ba7: Already exists
2656217a381c: Already exists
3b460102a79b: Already exists
1302db5d4d7f: Already exists
Digest: sha256:3bd5502ae613e2cc360f9c9b16a7d742cc4178e01adc3ccadea393c54633dc4a
Status: Downloaded newer image for kurron/docker-monitor-mongodb:latest
Creating mongodb-service...
Pulling mysql (mysql:latest)...
latest: Pulling from library/mysql
2e32b26a94ed: Pull complete
637386aea7a0: Pull complete
f40aa7fe5d68: Pull complete
ca21348f3728: Pull complete
b783bc3b44b9: Pull complete
f94304dc94e3: Pull complete
efb904a945ff: Pull complete
64ef882b700f: Pull complete
291b704c92b1: Pull complete
adfeb78ac4de: Pull complete
f27e5410cda3: Pull complete
ca4b92f905b9: Pull complete
065018fec3d7: Pull complete
6762f304c834: Pull complete
ba249489d0b6: Already exists
19de96c112fc: Already exists
library/mysql:latest: The image you are pulling has been verified. Important: image verification is a tech preview feature and should not be relied on to provide security.
Digest: sha256:842ee1ad1b0f19561d9fee65bb7c6197b2a2b4093f069e7969acefb6355e8c1b
Status: Downloaded newer image for mysql:latest
Creating mysql...
Pulling api-gateway-service (kurron/docker-monitor-api-gateway:latest)...
latest: Pulling from kurron/docker-monitor-api-gateway
1e4db0d8adee: Pull complete
489ce1db7f03: Pull complete
599a9e3ef3f1: Pull complete
756375c88efe: Pull complete
d3a1f33e8a5a: Already exists
c22013c84729: Already exists
d74508fb6632: Already exists
91e54dfb1179: Already exists
8e1940fe110d: Already exists
358704cddcfd: Already exists
0ac8da0788dc: Already exists
6b7898c2281a: Already exists
98a15b463ba7: Already exists
2656217a381c: Already exists
3b460102a79b: Already exists
1302db5d4d7f: Already exists
Digest: sha256:587381c8335631d9a0d7b83c5dc4b9c852460f9274ac85defa1b6f5bfab06cdf
Status: Downloaded newer image for kurron/docker-monitor-api-gateway:latest
Creating api-gateway-service...
Pulling redis-service (kurron/docker-monitor-redis:latest)...
latest: Pulling from kurron/docker-monitor-redis
d7c164ab144d: Pull complete
1292c06bff9b: Pull complete
149094bcf958: Pull complete
4bacb41cbdf4: Pull complete
d3a1f33e8a5a: Already exists
c22013c84729: Already exists
d74508fb6632: Already exists
91e54dfb1179: Already exists
8e1940fe110d: Already exists
358704cddcfd: Already exists
0ac8da0788dc: Already exists
6b7898c2281a: Already exists
98a15b463ba7: Already exists
2656217a381c: Already exists
3b460102a79b: Already exists
1302db5d4d7f: Already exists
Digest: sha256:3f5bc2fb1c449ac8d6da0bc6c4a03e3890eaf533f15e4f6df9275abc591e075d
Status: Downloaded newer image for kurron/docker-monitor-redis:latest
Creating redis-service...
Creating postgresql-data...
Pulling postgresql (postgres:latest)...
latest: Pulling from library/postgres
843e2bded498: Pull complete
8c00acfb0175: Pull complete
72893ec31c4c: Pull complete
640a8e5c87b4: Pull complete
c370f4f57320: Pull complete
ae0f1b627d5e: Pull complete
1ee7d372b3e2: Pull complete
716505dd384f: Pull complete
5f1b1f91bfd4: Pull complete
241d4bf7490c: Pull complete
b924e91017bc: Pull complete
5ea6304ae9d3: Pull complete
7f2fa48b55fb: Pull complete
2ad0abeca190: Pull complete
a04ebe635e69: Pull complete
0e57c609ffa9: Pull complete
a9e279ca41a9: Pull complete
8d2164ecd807: Pull complete
1f89bef4c5c4: Pull complete
c540273be9bb: Pull complete
506c40f60539: Pull complete
library/postgres:latest: The image you are pulling has been verified. Important: image verification is a tech preview feature and should not be relied on to provide security.
Digest: sha256:a11e806f65a093bde78acb1ecc0182adcb7e9fe61176344b903442517012fc4a
Status: Downloaded newer image for postgres:latest
Creating postgresql...
Pulling postresql-service (kurron/docker-monitor-postgresql:latest)...
latest: Pulling from kurron/docker-monitor-postgresql
9699650828aa: Pull complete
9099065998fd: Pull complete
b101fd452f81: Pull complete
0cbf25b216ee: Pull complete
d3a1f33e8a5a: Already exists
c22013c84729: Already exists
d74508fb6632: Already exists
91e54dfb1179: Already exists
8e1940fe110d: Already exists
358704cddcfd: Already exists
0ac8da0788dc: Already exists
6b7898c2281a: Already exists
98a15b463ba7: Already exists
2656217a381c: Already exists
3b460102a79b: Already exists
1302db5d4d7f: Already exists
Digest: sha256:04351170a04870e419d8b4c2c9da51b9455c9a9eca0a1a9a5b87ce1f23bb74fe
Status: Downloaded newer image for kurron/docker-monitor-postgresql:latest
Creating postgresql-service...
Pulling redis (redis:latest)...
latest: Pulling from library/redis
d990a769a35e: Pull complete
8656a511ce9c: Pull complete
f7022ac152fb: Pull complete
8e84d9ce7554: Pull complete
c9e5dd2a9302: Pull complete
27b967cdd519: Pull complete
3024bf5093a1: Pull complete
e6a9eb403efb: Pull complete
c3532a4c89bc: Pull complete
35fc08946add: Pull complete
d586de7d17cd: Pull complete
1f677d77a8fa: Pull complete
ed09b32b8ab1: Pull complete
54647d88bc19: Pull complete
2f2578ff984f: Pull complete
ba249489d0b6: Already exists
19de96c112fc: Already exists
library/redis:latest: The image you are pulling has been verified. Important: image verification is a tech preview feature and should not be relied on to provide security.
Digest: sha256:3c3e4a25690f9f82a2a1ec6d4f577dc2c81563c1ccd52efdf4903ccdd26cada3
Status: Downloaded newer image for redis:latest
Creating redis...
Pulling mysql-service (kurron/docker-monitor-mysql:latest)...
latest: Pulling from kurron/docker-monitor-mysql
e04c74bf9c40: Pull complete
433426f0df96: Pull complete
67eebc458767: Pull complete
ce0c2aa0b4f2: Pull complete
d3a1f33e8a5a: Already exists
c22013c84729: Already exists
d74508fb6632: Already exists
91e54dfb1179: Already exists
8e1940fe110d: Already exists
358704cddcfd: Already exists
0ac8da0788dc: Already exists
6b7898c2281a: Already exists
98a15b463ba7: Already exists
2656217a381c: Already exists
3b460102a79b: Already exists
1302db5d4d7f: Already exists
Digest: sha256:0b8d14f8546b00f9fcd53edbef1c7b57c145c812ca7ffb77cd393f7adb375b87
Status: Downloaded newer image for kurron/docker-monitor-mysql:latest
Creating mysql-service...
Pulling rabbitmq (kurron/docker-rabbitmq:latest)...
latest: Pulling from kurron/docker-rabbitmq
f450b32f955f: Pull complete
6ae55e717133: Pull complete
336edff5a74c: Pull complete
2415d8a1571d: Pull complete
89e764f7d879: Pull complete
55dbe7c3d0c1: Pull complete
2f7545c26d4e: Pull complete
d6d4226861c0: Pull complete
d4a650287e13: Pull complete
db301d662e5e: Pull complete
992dbfa68acf: Pull complete
efcf1631b102: Pull complete
b32de60522d9: Pull complete
f951ad325ec9: Pull complete
462879282ace: Pull complete
38a10294f3e7: Pull complete
8a890ee54ec4: Pull complete
2ed1a469656a: Pull complete
2ecf53c56258: Pull complete
883a9af8fba1: Pull complete
e8c1d002d2ff: Pull complete
53929a6c7e33: Pull complete
f78c91d863e9: Pull complete
6c7cfa34c27b: Pull complete
355a81a8ee94: Pull complete
ba249489d0b6: Already exists
19de96c112fc: Already exists
Digest: sha256:15432a316a4b19ac7529738022f42613a7b2e82c12af7279e1c52d646bbe4abb
Status: Downloaded newer image for kurron/docker-rabbitmq:latest
Creating rabbitmq...
```

```bash
 ./check-health.sh
* Hostname was NOT found in DNS cache
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0*   Trying 127.0.0.1...
* Connected to localhost (127.0.0.1) port 8000 (#0)
> GET /operations/health HTTP/1.1
> User-Agent: curl/7.35.0
> Host: localhost:8000
> Accept: */*
>
< HTTP/1.1 200 OK
* Server Apache-Coyote/1.1 is not blacklisted
< Server: Apache-Coyote/1.1
< X-Application-Context: application:8000
< Content-Type: application/json;charset=UTF-8
< Transfer-Encoding: chunked
< Date: Tue, 22 Sep 2015 19:05:06 GMT
<
{ [data not shown]
100   478    0   478    0     0   3932      0 --:--:-- --:--:-- --:--:--  3983
* Connection #0 to host localhost left intact
{
    "diskSpace": {
        "free": 38548078592,
        "status": "UP",
        "threshold": 10485760
    },
    "mongoDbService": {
        "HTTP Status": "OK",
        "status": "UP"
    },
    "mySqlService": {
        "HTTP Status": "OK",
        "status": "UP"
    },
    "postgreSqlService": {
        "HTTP Status": "OK",
        "status": "UP"
    },
    "rabbit": {
        "status": "UP",
        "version": "3.5.4"
    },
    "redisService": {
        "HTTP Status": "OK",
        "status": "UP"
    },
    "status": "UP"
}
```
The second project, `docker-monitor-jmeter`, is a project that will pump requests through the system.  After the environment has been started, 
you can start the data pump via `./start.sh`.  The script will tail the log of the container so you can see how things are progressing.  You can
`ctrl-c` to break out of the tail.  The data pump will continue to run in the background.

```bash
 ./start.sh
Pulling jmeter (kurron/docker-monitor-jmeter:latest)...
latest: Pulling from kurron/docker-monitor-jmeter
4937180f894a: Pull complete
4885eff48145: Pull complete
8360edcaf147: Pull complete
8efe2a175dfb: Pull complete
bd93e168553a: Pull complete
cf61fa14461e: Pull complete
afd9c56271c3: Pull complete
3f172fea0fad: Pull complete
5787e2a11634: Pull complete
5c1a56c0e230: Pull complete
d3a1f33e8a5a: Already exists
c22013c84729: Already exists
d74508fb6632: Already exists
91e54dfb1179: Already exists
8e1940fe110d: Already exists
358704cddcfd: Already exists
0ac8da0788dc: Already exists
6b7898c2281a: Already exists
98a15b463ba7: Already exists
2656217a381c: Already exists
3b460102a79b: Already exists
1302db5d4d7f: Already exists
Digest: sha256:39dc041b344479dcc86b629a6e615a2cdfd49620090c2b301fe041fdd1ea9d5b
Status: Downloaded newer image for kurron/docker-monitor-jmeter:latest
Creating monitor-jmeter...
Creating jmeter-config...
Creating summariser <summary>
Created the tree successfully using /config/configuration.jmx
Starting the test @ Tue Sep 22 19:06:15 UTC 2015 (1442948775334)
Waiting for possible shutdown message on port 4445
summary +     55 in    15s =    3.8/s Avg:   257 Min:    71 Max:  2508 Err:     0 (0.00%) Active: 5 Started: 5 Finished: 0
summary +    371 in    30s =   12.4/s Avg:   221 Min:    52 Max:   831 Err:     0 (0.00%) Active: 10 Started: 10 Finished: 0
summary =    426 in    45s =    9.5/s Avg:   225 Min:    52 Max:  2508 Err:     0 (0.00%)
```

#Troubleshooting

##The Environment
Check out the [README](https://github.com/kurron/docker-monitor-compose) of the environment project for troubleshooting tips.

##The Data Pump
Check out the [README](https://github.com/kurron/docker-monitor-jmeter) of the data pump project for troubleshooting tips.

##Only Works On Ubuntu
When Ansible runs, it gathers up information about the target machine and will refuse to provision machine if 
it isn't an Ubuntu box.

#License and Credits
This project is licensed under the [Apache License Version 2.0, January 2004](http://www.apache.org/licenses/).

#List of Changes
