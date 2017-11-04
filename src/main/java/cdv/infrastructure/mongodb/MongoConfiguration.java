package cdv.infrastructure.mongodb;

import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.SimpleMongoDbFactory;

/**
 * @author Dmitry Kulga
 *         04.11.2017 10:55
 */
@Configuration
public class MongoConfiguration {

    static final String CONNECTION_URL = "connection.url";
    static final String DATABASE_NAME = "database.name";

    @Value("${" + CONNECTION_URL + "}")
    private String connectionUrl;

    @Value("${" + DATABASE_NAME + "}")
    private String databaseName;

    @Bean
    public MongoTemplate mongoTemplate() throws Exception {
        SimpleMongoDbFactory factory = new SimpleMongoDbFactory(
                new MongoClient(new MongoClientURI(connectionUrl)),
                databaseName);
        return new MongoTemplate(factory);
    }

}
