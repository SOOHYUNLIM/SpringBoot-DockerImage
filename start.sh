REPOSITORY=/home/ec2-user/build/build/libs

JAR_NAME=$(ls $REPOSITORY/ | tail -n 1)

echo "JAR Name: $JAR_NAME"

java -jar $REPOSITORY/$JAR_NAME
