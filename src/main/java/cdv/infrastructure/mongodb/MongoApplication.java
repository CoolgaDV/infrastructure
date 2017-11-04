package cdv.infrastructure.mongodb;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.data.mongodb.core.MongoTemplate;

import java.util.Properties;

/**
 * @author Dmitry Kulga
 *         04.11.2017 11:11
 */
public class MongoApplication {

    private final AbstractApplicationContext context;

    private MongoApplication(AbstractApplicationContext context) {
        this.context = context;
    }

    public static MongoApplication create(String connectionString, String databaseName) {
        AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext();
        context.register(MongoConfiguration.class);
        PropertySourcesPlaceholderConfigurer propertyProvider =
                new PropertySourcesPlaceholderConfigurer();
        Properties properties = new Properties();
        properties.put(MongoConfiguration.CONNECTION_URL, connectionString);
        properties.put(MongoConfiguration.DATABASE_NAME, databaseName);
        propertyProvider.setProperties(properties);
        context.addBeanFactoryPostProcessor(propertyProvider);
        context.refresh();
        return new MongoApplication(context);
    }

    public MongoTemplate getTemplate() {
        return context.getBean(MongoTemplate.class);
    }

    public void close() {
        context.close();
    }

}
