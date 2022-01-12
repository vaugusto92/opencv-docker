(require 'leiningen.core.eval)

(def JVM-OPTS
  {:common   []
    :macosx   []
    :linux    ["-Djava.class.path=/usr/local/opencv/build/bin/" "-Djava.library.path=/usr/local/opencv/build/lib/"]
    :windows  []})

(defn jvm-opts
  "Return a complete vector of jvm-opts for the current os."
  [] (let [os (leiningen.core.eval/get-os)]
        (vec (set (concat (get JVM-OPTS :common)
                          (get JVM-OPTS os))))))


(defproject simple-sample "0.1.0-SNAPSHOT"
  :description "A simple project to start REPLing with OpenCV"
  :url "http://example.com/FIXME"
  :license {:name "BSD 3-Clause License"
            :url "http://opensource.org/licenses/BSD-3-Clause"}
  :resource-paths ["lib/opencv-440.jar"]
  :main simple-sample.core
  :injections [(clojure.lang.RT/loadLibrary org.opencv.core.Core/NATIVE_LIBRARY_NAME)]
  :jvm-opts ^:replace ~(jvm-opts)
)
