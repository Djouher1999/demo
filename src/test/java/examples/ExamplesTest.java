package examples;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;

import io.qameta.allure.karate.AllureKarate;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class ExamplesTest {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:examples")
        .hook(new AllureKarate())
                //.outputCucumberJson(true)
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
