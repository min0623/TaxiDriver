# TaxiDriver
 
[API 스펙 명세](http://wiki.dramancompany.com/display/~%EC%9E%84%EC%84%B1%EB%AF%BC/TaxiDriver)
 
## 실행하는 법
 
(프로젝트의 루트 디렉토리에서)

    docker-compose build
    docker-compose run -e RAILS_ENV=development app rake db:create
    docker-compose run -e RAILS_ENV=development app rake db:migrate
    docker-compose up

이후 localhost의 3000번 포트로 접속한다.