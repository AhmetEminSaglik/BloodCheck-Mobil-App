frontend:

#POWERSHELL

```bash
Remove-Item -Recurse -Force .\dist
docker rmi ahmeteminsaglik/react:3.0
npm run build
docker build -t ahmeteminsaglik/react:3.0 .      
docker push ahmeteminsaglik/react:3.0
```

#CMD

```bash
rmdir /s /q dist
docker rmi ahmeteminsaglik/react-bloodcheck:3.0
npm run build
docker build -t ahmeteminsaglik/react-bloodcheck:3.0 .
docker push ahmeteminsaglik/react-bloodcheck:3.0
```

backend parent:

```bash
docker rmi ahmeteminsaglik/ws-bloodcheck:3.0
mvn clean install -DskipTests
docker build -t ahmeteminsaglik/ws-bloodcheck:3.0 .
docker push ahmeteminsaglik/ws-bloodcheck:3.0 
 
 ```

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

receive files from server:

```bash
scp -r root@178.18.241.162:/root/portfolio-compose  local/destination
```

send files to server:
Example:

```bash
scp .env config.yaml username@sunucu_ip_adresi:/home/username/
```

my server:

```bash
scp .env docker-compose.yaml root@178.18.241.162:/root/portfolio-compose/v1.4
scp .env config.yaml root@178.18.241.162:/root/portfolio/
```

------------------------------------------------------------------------
portfolio-parent:\

```bash
docker build -t ahmeteminsaglik/ws-bloodcheck:1.1 .
docker push ahmeteminsaglik/ws-bloodcheck:1.1
```

frontend:

```bash
npm run build
docker build -t ahmeteminsaglik/react:1.1 .      
docker push ahmeteminsaglik/react:1.1
```

------------------------------------------------------------------------
docker logs -f <contianre_id> --> let you watch real time logs

```bash
psql -h localhost -p 5439 -U test -l -->  hshows you created db
```

------------------------------------------------------------------------

```bash
docker exec -it 3 bash    --> attach to container linux shell
```

```bash
 mvn clean install -DskipTests
 docker build -t ahmeteminsaglik/ws-bloodcheck:1.1 .
 docker push ahmeteminsaglik/ws-bloodcheck:1.1 
 
 ```

#### docker'daki butun verileri temizler.

```bash
docker builder prune -af
docker system prune -af
```

```bash
docker build --progress=plain --no-cache .
```

#### donarda build etmezse

```bash
docker build --no-cache -t ahmeteminsaglik/react:1.0 .
```