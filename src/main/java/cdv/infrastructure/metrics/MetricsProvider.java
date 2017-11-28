package cdv.infrastructure.metrics;

import com.codahale.metrics.Counter;
import com.codahale.metrics.Gauge;
import com.codahale.metrics.MetricRegistry;
import org.springframework.scheduling.annotation.Scheduled;

import javax.annotation.PostConstruct;
import java.util.concurrent.ThreadLocalRandom;

/**
 * Application bean that provides sample metrics
 *
 * @author Dmitry Kulga
 *         28.11.2017 12:01
 */
public class MetricsProvider {

    private final MetricRegistry metrics;
    private final Counter counter;

    public MetricsProvider(MetricRegistry metrics) {
        this.metrics = metrics;
        counter = metrics.counter("app.counter");
    }

    @PostConstruct
    public void init() {
        metrics.register("app.gauge",
                (Gauge<Integer>) () -> ThreadLocalRandom.current().nextInt(0, 100));
    }

    @Scheduled(fixedDelay = 5_000)
    public void count() {
        counter.inc(ThreadLocalRandom.current().nextInt(1, 4));
    }

}
