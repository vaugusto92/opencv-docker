# opencv-docker

docker build --build-arg platform=java --build-arg version=4.4.0 --tag opencv .

docker run -it -v $(pwd):/work --rm opencv bash

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


(defproject simple-sample "0.1.0-SNAPSHOT"
  :dependencies [[org.clojure/clojure "1.5.1"]
                 [opencv/opencv "4.4.0"]
                 [opencv/opencv-native "4.4.0"]]
  :main simple-sample.core
  :jvm-opts ["-Djava.library.path=/usr/local/opencv/build/lib/"]
  :injections [(clojure.lang.RT/loadLibrary org.opencv.core.Core/NATIVE_LIBRARY_NAME)])

cp install-opencv.sh /usr/local/opencv/
