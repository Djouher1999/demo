package examples.e_commerce;

import com.intuit.karate.junit5.Karate;

class E2eRunner {
       @Karate.Test
    Karate testUsers() {
        return Karate.run("e2e").relativeTo(getClass());
    }  
}
