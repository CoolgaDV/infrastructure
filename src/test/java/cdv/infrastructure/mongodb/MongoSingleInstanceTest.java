package cdv.infrastructure.mongodb;

import cdv.infrastructure.DeployManager;
import org.junit.AfterClass;
import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.data.mongodb.core.MongoTemplate;

import java.io.IOException;
import java.util.List;

/**
 * @author Dmitry Kulga
 *         04.11.2017 11:33
 */
public class MongoSingleInstanceTest {

    private static MongoApplication mongoApplication;
    private static MongoTemplate mongoTemplate;
    private static DeployManager deployManager = new DeployManager(
            "deploy/mongodb/single",
            "start.sh",
            "stop.sh");

    @BeforeClass
    public static void setUp() throws IOException, InterruptedException {
        deployManager.start();
        mongoApplication = MongoApplication.create("mongodb://localhost:5353", "sample");
        mongoTemplate = mongoApplication.getTemplate();
    }

    @AfterClass
    public static void tearDown() throws IOException, InterruptedException {
        mongoApplication.close();
        deployManager.stop();
    }

    @Test
    public void testWriteAndRead() {

        MongoEntity to = new MongoEntity();
        to.setFirst("some");
        to.setSecond(42);
        mongoTemplate.insert(to);

        List<MongoEntity> entities = mongoTemplate.findAll(MongoEntity.class);
        Assert.assertEquals(1, entities.size());

        MongoEntity from  = entities.get(0);
        Assert.assertNotNull(from.getId());
        Assert.assertEquals(to.getFirst(), from.getFirst());
        Assert.assertEquals(to.getSecond(), from.getSecond());
    }

}
