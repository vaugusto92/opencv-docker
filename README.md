# opencv-docker

docker build --build-arg platform=java --build-arg version=4.4.0 --tag opencv .

docker run -it --rm opencv bash

java.library.path=/tmp/build/lib

ant -DocvJarDir=/tmp/build/bin -DocvLibDir=/tmp/build/lib rebuild-run
ant -DocvJarDir=/tmp/build/bin/ -DocvLibDir=/tmp/build/lib/ rebuild-run

ant -DocvJarDir=/usr/local/opencv/build/bin/ -DocvLibDir=/usr/local/opencv/build/lib/ rebuild-run

cp -r opencv-4.4.0/samples/java/ant/. ./samples/ant/
cp -r opencv-4.4.0/samples/java/clojure/. ./samples/clojure/

mvn deploy:deploy-file -DgroupId=opencv \ 
                       -DartifactId=opencv \
                       -Dversion=$version
                       -Dpackaging=jar
                       -Dfile=opencv-$jar_version.jar \
                       -Durl=file:repo


(defproject foo "0.1.0-SNAPSHOT"
  :dependencies [[org.clojure/clojure "1.4.0"]
                 [local/bar "1.0.0"]]
  :repositories {"project" "file:repo"})


cp install-opencv.sh /usr/local/opencv/
