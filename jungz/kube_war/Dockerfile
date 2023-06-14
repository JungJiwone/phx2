FROM tomcat:8.5-alpine #톰캣8.5 사용

ENV TZ=Asia/Seoul
Run rm /usr/local/tomcat/conf/server.xml #기본으로 있는 server.xml을 지움
COPY server.xml /usr/local/tomcat/conf/ #현재 디렉토리에 있는 server.xml을 복사
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone #시간을 서울로 설정
RUN value=`cat conf/server.xml` && echo "${value//8080/1111}" >| conf/server.xml #기본포트가 8080인데 1111로 변경 필요한사람은 쓰고 8080쓸거면 지워도됌
RUN rm -Rf /usr/local/tomcat/webapps/ROOT #기본으로 있는 ROOT를 지움
COPY keti_main.war /usr/local/tomcat/webapps #현재 Dockerfile이 작성되는 디렉토리에 있는 war파일을 컨테이너 내부로 복사
ENV JAVA_OPTS="-Dserver.type=dev" #자바 옵션 설정
