package examples.Brands;
import com.intuit.karate.junit5.Karate;

class BrandRunner {
        @Karate.Test
    Karate testUsers() {
        return Karate.run("brand").relativeTo(getClass());
    }  
}
