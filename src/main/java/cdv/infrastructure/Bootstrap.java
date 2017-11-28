package cdv.infrastructure;

import cdv.infrastructure.metrics.MetricsConfiguration;
import org.springframework.boot.Banner;
import org.springframework.boot.builder.SpringApplicationBuilder;

/**
 * Application entry point
 *
 * @author Dmitry Kulga
 *         28.11.2017 09:44
 */
public class Bootstrap {

    public static void main(String[] args) {
        new SpringApplicationBuilder()
                .sources(MetricsConfiguration.class)
                .bannerMode(Banner.Mode.OFF)
                .run(args);
    }

}
