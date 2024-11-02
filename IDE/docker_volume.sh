# 볼륨 생성 (volume name : cloud-cicd-src)
docker volume create  \
--opt device="C:\CICD\cicd-start\IDE\src" \
--opt o=bind --opt type=none cloud-cicd-src

docker volume create  \
--opt device="C:\CICD\cicd-start\IDE\src" \
--opt o=bind --opt type=none vscode

docker volume create  \
--opt device="C:\CICD\cicd-start\IDE\src" \
--opt o=bind --opt type=none jenkins-home

# 볼륨 생성 확인
docker volume ls